<!DOCTYPE html>
<html lang="en">
<head>
	<!-- Templatename: /etc/mrtgLikeRRD/mrtgLikeRRD.tpl -->
	<meta charset="UTF-8" />
	<meta http-equiv="refresh" content="300" />
	<title>###PAGETITLE###</title>
	<style>
		body {
			background-color: #ffffff;
			color: #000000;
		}
		div {
			border-bottom: 2px solid #aaa;
			padding-bottom: 10px;
			margin-bottom: 5px;
		}
		div h2 {
			font-size: 1.2em;
		}
		div.graph img {
			margin: 5px 0;
		}
		div.graph table, div#legend table {
			font-size: .8em;
		}
		div.graph table td {
			padding: 0 10px;
			text-align: right;
		}
		div table .in th, div table td span.in {
			color: #00cc00;
		}
		div table .out th, div table td span.out {
			color: #0000ff;
		}
		div#legend th {
			text-align: right;
		}
		div#footer {
			border: none;
			font-size: .8em;
			font-family: Arial, Helvetica, sans-serif;
			width: 476px;
		}
		div#footer img {
			border: none;
			height: 25px;
		}
		div#footer address {
			text-align: right;
		}
		div#footer #version {
			margin: 0;
			padding: 0;
			float: left;
			width: 88px;
			text-align: right;
		}
	</style>
</head>
<body>
	<h1>###PAGETITLE###</h1>
	<p>The statistics were last updated <strong>###UPDATED###</strong>,<br />
at which time <strong>'###DEVICE###'</strong> had been up for <strong>###UPTIME###</strong>.</p>

<!-- Begin `Daily' Graph (5 Minute interval) -->
	<div class="graph">
		<h2>`Daily' Graph (5 Minute Average)</h2>
		<img src="###BASENAME###-day.png" title="day" alt="day" />
		<table>
			<tr>
				<th></th>
				<th scope="col">Min</th>
				<th scope="col">Max</th>
				<th scope="col">Average</th>
				<th scope="col">Current</th>
			</tr>
###IN_START###			<tr class="in">###IN_END###
###IN_START###				<th scope="row">###IN_DESC_SHORT###</th>###IN_END###
###IN_START###				<td>###D_MIN_I###</td>###IN_END###
###IN_START###				<td>###D_MAX_I###</td>###IN_END###
###IN_START###				<td>###D_AVG_I###</td>###IN_END###
###IN_START###				<td>###D_CUR_I###</td>###IN_END###
###IN_START###			</tr>###IN_END###
###OUT_START###			<tr class="out">###OUT_END###
###OUT_START###				<th scope="row">###OUT_DESC_SHORT###</th>###OUT_END###
###OUT_START###				<td>###D_MIN_O###</td>###OUT_END###
###OUT_START###				<td>###D_MAX_O###</td>###OUT_END###
###OUT_START###				<td>###D_AVG_O###</td>###OUT_END###
###OUT_START###				<td>###D_CUR_O###</td>###OUT_END###
###OUT_START###			</tr>###OUT_END###
		</table>
	</div>
<!-- End `Daily' Graph (5 Minute interval) -->

<!-- Begin `Weekly' Graph (30 Minute interval) -->
	<div class="graph">
		<h2>`Weekly' Graph (30 Minute Average)</h2>
		<img src="###BASENAME###-week.png" title="week" alt="week" />
		<table>
			<tr>
				<th></th>
				<th scope="col">Min</th>
				<th scope="col">Max</th>
				<th scope="col">Average</th>
				<th scope="col">Current</th>
			</tr>
###IN_START###			<tr class="in">###IN_END###
###IN_START###				<th scope="row">###IN_DESC_SHORT###</th>###IN_END###
###IN_START###				<td>###W_MIN_I###</td>###IN_END###
###IN_START###				<td>###W_MAX_I###</td>###IN_END###
###IN_START###				<td>###W_AVG_I###</td>###IN_END###
###IN_START###				<td>###W_CUR_I###</td>###IN_END###
###IN_START###			</tr>###IN_END###
###OUT_START###			<tr class="out">###OUT_END###
###OUT_START###				<th scope="row">###OUT_DESC_SHORT###</th>###OUT_END###
###OUT_START###				<td>###W_MIN_O###</td>###OUT_END###
###OUT_START###				<td>###W_MAX_O###</td>###OUT_END###
###OUT_START###				<td>###W_AVG_O###</td>###OUT_END###
###OUT_START###				<td>###W_CUR_O###</td>###OUT_END###
###OUT_START###			</tr>###OUT_END###
		</table>
	</div>
<!-- End `Weekly' Graph (30 Minute interval) -->

<!-- Begin `Monthly' Graph (2 Hour interval) -->
	<div class="graph">
		<h2>`Monthly' Graph (2 Hour Average)</h2>
		<img src="###BASENAME###-month.png" title="month" alt="month" />
		<table>
			<tr>
				<th></th>
				<th scope="col">Min</th>
				<th scope="col">Max</th>
				<th scope="col">Average</th>
				<th scope="col">Current</th>
			</tr>
###IN_START###			<tr class="in">###IN_END###
###IN_START###				<th scope="row">###IN_DESC_SHORT###</th>###IN_END###
###IN_START###				<td>###M_MIN_I###</td>###IN_END###
###IN_START###				<td>###M_MAX_I###</td>###IN_END###
###IN_START###				<td>###M_AVG_I###</td>###IN_END###
###IN_START###				<td>###M_CUR_I###</td>###IN_END###
###IN_START###			</tr>###IN_END###
###OUT_START###			<tr class="out">###OUT_END###
###OUT_START###				<th scope="row">###OUT_DESC_SHORT###</th>###OUT_END###
###OUT_START###				<td>###M_MIN_O###</td>###OUT_END###
###OUT_START###				<td>###M_MAX_O###</td>###OUT_END###
###OUT_START###				<td>###M_AVG_O###</td>###OUT_END###
###OUT_START###				<td>###M_CUR_O###</td>###OUT_END###
###OUT_START###			</tr>###OUT_END###
		</table>
	</div>
<!-- End `Monthly' Graph (2 Hour interval) -->

<!-- Begin `Yearly' Graph (1 Day interval) -->
	<div class="graph">
		<h2>`Yearly' Graph (1 Day Average)</h2>
		<img src="###BASENAME###-year.png" title="year" alt="year" />
		<table>
			<tr>
				<th></th>
				<th scope="col">Min</th>
				<th scope="col">Max</th>
				<th scope="col">Average</th>
				<th scope="col">Current</th>
			</tr>
###IN_START###			<tr class="in">###IN_END###
###IN_START###				<th scope="row">###IN_DESC_SHORT###</th>###IN_END###
###IN_START###				<td>###Y_MIN_I###</td>###IN_END###
###IN_START###				<td>###Y_MAX_I###</td>###IN_END###
###IN_START###				<td>###Y_AVG_I###</td>###IN_END###
###IN_START###				<td>###Y_CUR_I###</td>###IN_END###
###IN_START###			</tr>###IN_END###
###OUT_START###			<tr class="out">###OUT_END###
###OUT_START###				<th scope="row">###OUT_DESC_SHORT###</th>###OUT_END###
###OUT_START###				<td>###Y_MIN_O###</td>###OUT_END###
###OUT_START###				<td>###Y_MAX_O###</td>###OUT_END###
###OUT_START###				<td>###Y_AVG_O###</td>###OUT_END###
###OUT_START###				<td>###Y_CUR_O###</td>###OUT_END###
###OUT_START###			</tr>###OUT_END###
		</table>
	</div>
<!-- End `Yearly' Graph (1 Day interval) -->

<!-- Begin Legend -->
	<div id="legend">
		<table>
###IN_START###			<tr class="in">###IN_END###
###IN_START###				<th scope="row">GREEN ###</th>###IN_END###
###IN_START###				<td>###IN_DESC_LONG###</td>###IN_END###
###IN_START###			</tr>###IN_END###
###OUT_START###			<tr class="out">###OUT_END###
###OUT_START###				<th scope="row">BLUE ###</th>###OUT_END###
###OUT_START###				<td>###OUT_DESC_LONG###</td>###OUT_END###
###OUT_START###			</tr>###OUT_END###
		</table>
	</div>
<!-- End Legend -->

<!-- Begin MRTG Block -->
	<div id="footer">
		<p>HTML based on output of <a href="http://oss.oetiker.ch/mrtg/">MRTG</a> 2.17.7</p>
<!--		<address>
			<a href="http://tobi.oetiker.ch/">Tobias Oetiker</a>
			<a href="mailto:tobi+mrtglink@oetiker.ch">&lt;tobi@oetiker.ch&gt;</a><br />
and			<a href="http://www.bungi.com/">Dave Rand</a>
			<a href="mailto:dlr@bungi.com">&lt;dlr@bungi.com&gt;</a>
		</address>-->
	</div>
<!-- End MRTG Block -->
</body>
</html>
