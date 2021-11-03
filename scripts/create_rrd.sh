#!/bin/bash

# This script is part of a collection of scripts to emulate creation
# of MRTG like pages while using RRDTool as a backend.
# This script creates an RRD database based on a config file.
# Additional infos (including a license notice) are at the end of this file.

errorExit () {
	echo Error "(${RRDFILE}): $*"
	exit 1
}


BASECONFIG=/etc/mrtgLikeRRD/base.config

if [ $# -ne 1 ]; then
	echo ""
	echo "Error: Please provide target config as parameter"
	echo ""
	exit
fi
if [ ! -f ${BASECONFIG} ]; then
	echo "Error: base config ${BASECONFIG} not found"
	exit
fi
. ${BASECONFIG}
CONFIG=${TARGETDIR}/$1
RRDFILE=${CONFIG}
if [ "x${DBDIR}" = x ]; then
	errorExit "DBDIR not defined"
fi
if [ ! -x "${CONFIG}" ]; then
	errorExit "Target config '${CONFIG}' not existing or not executable"
fi

. ${CONFIG}

if [ "x${DATASOURCE}" != "xGAUGE" -a "x${DATASOURCE}" != "xCOUNTER" ]; then
	errorExit "unknown datasource (${DATASOURCE}) provided in config file"
fi

# Infos about used variables in RRD-files:
# * rrdtool info RRDFILE | grep ^ds | sed 's/.*\[\(.*\)\].*/\1/g' | uniq
#
# Change names of variables (rx->in and tx->out):
# * rrdtool tune RRDFILE -r rx:in -r tx:out

if [ -e ${DBDIR}/${RRDFILE} ]; then
	errorExit "${DBDIR}/${RRDFILE} existing"
fi

DS_IN="DS:in:${DATASOURCE}:600:0:U"
DS_OUT="DS:out:${DATASOURCE}:600:0:U"
if [ ${OUTPUT} = O ]; then
	DS_SUM=${DS_OUT}
elif [ ${OUTPUT} = I ]; then
	DS_SUM=${DS_IN}
elif [ ${OUTPUT} = B ]; then
	DS_SUM="${DS_IN} ${DS_OUT}"
else
	echo "Invalid value '${OUTPUT}' for display graph"
	exit
fi

/usr/bin/rrdtool \
	create ${DBDIR}/${RRDFILE} \
	--start N \
	--step 300 ${DS_SUM} \
	RRA:MIN:0:243:466 \
	RRA:MIN:0:22:466 \
	RRA:MIN:0:6:466 \
	RRA:MAX:0:243:466 \
	RRA:MAX:0:22:466 \
	RRA:MAX:0:6:466 \
	RRA:AVERAGE:0:243:466 \
	RRA:AVERAGE:0:22:466 \
	RRA:AVERAGE:0:6:466 \
	RRA:AVERAGE:0:1:466 \
	RRA:LAST:0:1:466 

# mrtgLikeRRD Copyright (C) 2021 Armin Fuerst (armin@fuerst.priv.at)
# This script is part of a collection of scripts to emulate creation
# of MRTG like pages while using RRDTool as a backend.
# This script creates an RRD database based on a config file.
# 
# mrtgLikeRRD simplifies adding additional sources to a collection
# of pages being created. It tries do create pages being as close
# as possible to MRTG.
# mrtgLikeRRD limits the functionality of RRDTool - RRDTool has many
# additional features you cannot use with mrtgLikeRRD. Especially the
# advantage of separating data collection from generation of the pages
# is not supported by mrtgLikeRRD.
# Following advantages of RRDTool are available to mrtgLikeRRD:
# + support of negative figures
# + support of float values (GAUGE)
# + support of missing values
#
# mrtgLikeRRD is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# mrtgLikeRRD is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with tempersensor.  If not, see <https://www.gnu.org/licenses/>.
#
#
# Why did I put the license notice at the bottom of the file?
# Because most of the time, when you open the file, the probability
# you want to know about the license is very little. If you open the
# file to learn about the license, it is still easy to find.
#
# Perhaps you want to have a look at the talk "Clean Coders Hate What 
# Happens to Your Code When You Use These Enterprise Programming Tricks"
# from Kevlin Henney at the NDC Conferences in London, January 16th-20th 
# 2017. While watching the whole talk is a good idea, starting at around 
# 27:50 provides some input what to put on the top of source code files.

