#!/bin/bash

# This script is part of a collection of scripts to emulate creation
# of MRTG like pages while using RRDTool as a backend.
# This script queries snmp sources and prints the output in MRTG style.
# This script depends especially on "snmpwalk" and "snmpget".
# Additional infos (including a license notice) are at the end of this file.

METHOD='undefined'

while getopts i:n:m:c:a: option
do
	case "${option}"
	in
		i) METHOD='id'; IID=${OPTARG};;
		n) METHOD='name' ; INAME=${OPTARG};;
		m) METHOD='mac' ; IMAC=${OPTARG};;
		c) COMMUNITY=${OPTARG};;
		a) ADDRESS=${OPTARG};;
	esac
done

if [ $METHOD == undefined -o x$COMMUNITY == x -o x$ADDRESS == x ]; then
	echo "Error: invalid arguments (i=id / n=name / m=mac / c=community / a=address)"
	exit
fi

if [ $METHOD == name ]; then
	IID=unknown
	while read -r line; do
		if [[ $line == *\"${INAME}\"* ]]; then 
			METHOD='id'
			IID=`echo $line | sed -re "s/ = .*$//" | sed -re "s/^.*\.//"`
		fi
		line=''
	done < <(/usr/bin/snmpwalk -v 1 \
			-c ${COMMUNITY} \
			${ADDRESS} \
			iso.3.6.1.2.1.2.2.1.2)
fi
if [ $METHOD == mac ]; then
	IID=unknown
	IMAC=`echo ${IMAC} | /bin/sed -re "s/[:-]/ /g" | tr '[:lower:]' '[:upper:]'`
	while read -r line; do
		if [[ $line == *${IMAC} ]]; then 
			METHOD='id'
			IID=`echo $line | sed -re "s/ = .*$//" | sed -re "s/^.*\.//"`
		fi
		line=''
	done < <(/usr/bin/snmpwalk -v 1 \
			-c ${COMMUNITY} \
			${ADDRESS} \
			iso.3.6.1.2.1.2.2.1.6)
fi

if [ $METHOD = id ]; then
	cnt=0
	while read -r line; do
		result[$cnt]=${line}
		cnt=$((cnt+1))
	done < <(/usr/bin/snmpget -v 1 \
			-c ${COMMUNITY} \
			-Oqv \
			${ADDRESS} \
			iso.3.6.1.2.1.2.2.1.10.${IID} \
			iso.3.6.1.2.1.2.2.1.16.${IID} \
			iso.3.6.1.2.1.25.1.1.0 \
			iso.3.6.1.2.1.1.5.0)
else
	echo Error retrieving ID for interface - giving up
	exit
fi

RX=${result[0]}
TX=${result[1]}
UPTIME=${result[2]}
SYSTEM=${result[3]}

UPTIME=`echo $UPTIME | /bin/sed -re "s/:/ day(s), /"`
UPTIME=`echo $UPTIME | /bin/sed -re "s/:/ hour(s), /"`
UPTIME=`echo $UPTIME | /bin/sed -re "s/:/ minute(s) and /"`
UPTIME=`echo $UPTIME | /bin/sed -re "s/\..*$/ second(s) /"`
SYSTEM=`echo $SYSTEM | /bin/sed -re "s/^\"//" | /bin/sed -re "s/\"$//"`

echo $RX
echo $TX
echo $UPTIME
echo $SYSTEM

# mrtgLikeRRD Copyright (C) 2021 Armin Fuerst (armin@fuerst.priv.at)
# This script is part of a collection of scripts to emulate creation
# of MRTG like pages while using RRDTool as a backend.
# This script queries snmp sources and prints the output in MRTG style.
# This script depends especially on "snmpwalk" and "snmpget".
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

