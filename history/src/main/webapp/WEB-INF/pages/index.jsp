<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html >
<html lang="en">
<head>
<title>데이터 센트럴 조감도</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="그것은 알기 싫다 데이터 센트럴 조감도" />
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/glyphicon.css">
<link rel="shortcut icon" type="image/png" href="favicon.png"/>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="js/ui-bootstrap-tpls-2.5.0.min.js"></script>

<script src="js/toArrayFilter.js"></script>
<script src="js/echarts.min.js"></script>

<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/modules/tilemap.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>



<style>
* {
	margin: 0;
}

html, body {
	height: 100%;
}

a { //
	color: grey;
}

.wrapper {
	min-height: 100%;
	height: auto !important;
	height: 100%;
	/* Negative indent footer by it's height */
	margin: 0 auto -50px;
}

/* Set the fixed height of the footer here */
.push, .footer {
	height: 50px;
}

.footer {
	background-color: #f5f5f5;
}

.provincial .nav-link {
	padding-right: 3rem;
}
/* Lastly, apply responsive CSS fixes as necessary */
@media ( max-width : 768px) {
	.footer {
		margin-left: -20px; //
		margin-right: -20px;
		padding-left: 20px;
		padding-right: 20px;
	}
}

.card {
	border-color: silver;
	border: 0px;
	border-left: 3px solid;
	margin-left: 20px;
	width: 210px;
	margin-bottom: 0.5rem !important;
}

.card-header {
	padding: 0.55rem 1.25rem;
	border-top: 1px solid rgba(0, 0, 0, 0.125);
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
	border-right: 1px solid rgba(0, 0, 0, 0.125);
	white-space: nowrap;
}

.card-body {
	padding: 0.55rem 1.25rem;
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
	border-right: 1px solid rgba(0, 0, 0, 0.125);
	font-size: 0.8rem
}

.badge {
	white-space: normal;
}

.modal-open .navbar-toggler {
	margin-right: 0px;
	!
	important;
}

.map {
	top: 5px;
	position: relative;
}

h6 div {
	display: table-cell;
	vertical-align: middle;
}

.popover {
	max-width: 100%;
	/* Max Width of the popover (depending on the container!) */
}

.champ {
	padding-left: 8px;
}

.nchamp {
	margin-left: -2px;
}

.mchamp {
	padding-left: 16px;
}

.rate {
	width: calc(100% - 35px) !important;
}

.item {
	margin-bottom: 10px;
}

.item:hover .bar, .item:hover .pin {
	opacity: 1;
}

.show .bar {
	opacity: 1;
}

.bar {
	opacity: 0;
	height: 10px;
	margin-left: 5px;
	margin-bottom: 3px;
}

.pin {
	opacity: 0;
	float: right;
	position: relative;
}

.title {
	display: inline-block;
	position: relative;
}

.inspection a { //
	color: #373a3c;
	color: grey;
	text-decoration: none;
}

.inspection:hover a { //
	color: silver;
}

.inspection .glyphicon-headphones {
	display: none;
}

.inspection .item {
	display: inline-block;
}

.inspection-tab li {
	padding-top: 20px;
	padding-bottom: 20px;
}

.inspection-tab ul {
	margin-bottom: 20px;
}

.member {
	line-height: 12px;
}

.member:hover {
	text-shadow: 0px 0px 3px grey;
}

.tooltip {
	opacity: 1;
	background-color: rgba(0, 0, 0, 0.2);
}

.tooltip-inner {
	background-color: rgba(0, 0, 0, 0.5);
	white-space: nowrap;
	max-width:300px;
}

.small {
	font-size: 80%;
}

.header {
	padding-left: 10px;
	border-top: none;
	border-right: none;
	border-left: none;
	padding-bottom: 5px;
}

a.member {
	text-decoration: none;
}

.no-margin {
	margin-bottom: 0px;
}

.jumbotron {
	padding: 10px;
}
</style>


</head>
<body>



	<div ng-app="myApp" class="wrapper" ng-controller="myCtrl"
		style="overflow-x: hidden;">

		<div
			class="navbar sticky-top navbar-expand-lg  navbar-dark bg-primary">
			<a class="navbar-brand" href="http://xsfm.co.kr/" target="xsfm">XSFM
				그것은 알기 싫다 <small>데이터 센트럴 조감도 </small>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarColor01" aria-controls="navbarColor01"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
						id="download" aria-expanded="false">{{currentElection.name}} <span
							class="caret"></span></a>
						<div class="dropdown-menu" aria-labelledby="download">
							<a class="dropdown-item" href="#"
								ng-repeat="election in elections"
								ng-click="selectElection(election)">{{election.name}}</a>
						</div></li>
				</ul>
				<form class="navbar-form form-inline">

					<div class="btn-group" style="margin-right: 8px; margin-top: 2px;">
						<label class="btn btn-primary" ng-model="result"
							uib-btn-radio="'show'">결과보기</label> <label
							class="btn btn-primary" ng-model="result" uib-btn-radio="'hide'">숨김</label>
					</div>
				</form>
				<form class="navbar-form form-inline">
					<div>
						<small><input class="form-control " type="text"
							placeholder="이름" ng-model="name"> </small>
						<button class="btn btn-secondary " type="submit"
							data-toggle="modal" data-target="#history"
							ng-click="search(name)">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</div>
				</form>
			</div>
		</div>


		<br>
		<div class="row provincial" ng-if="currentElection.type=='provincial'">
			<div class="col-sm-auto">
				<ul class="nav nav-pills  flex-column">
					<li class="nav-item" ng-repeat="state in states"><a href="#"
						data-toggle="tab" class="nav-link" ng-class="{active:$first}"
						ng-click="selectState(state)"> {{state.name}} </a></li>

				</ul>
				<br>
			</div>
			<div class="col " style="display: flex; width: 100%;">
				<div ng-class="{'rate':currentState.name=='비례'}" style="width: 100%">
					<div ng-repeat="item in items" class="item"
						ng-class="{'show':item.show}" >


						<span ng-if="item.code!='' && currentState.name !='비례'"
							style="display: inline-block;">

							<div ng-if="item.code!=''" id="main{{$index}}" class="map"
								style="width: 30px; height: 30px; display: inline-block;"
								ng-init="draw('main'+$index,item.code)"></div>
							<div class="title">
								<span ng-if="item.zone!=''"><a href="#"
									tooltip-animation="false" uib-tooltip="지역이력"
									data-toggle="modal" data-target="#zone"
									ng-click="getZoneHistory(item.zone);">{{item.name}}{{item.title}}</a></span>
								<span ng-if="item.zone==''">{{item.name}}{{item.title}}</span> <span
									class="badge"
									ng-style="{'color':parties[item.party].textColor,'background-color': parties[item.party].color,'margin-left':'2px'}">{{parties[item.party].name}}</span>

								<a ng-href="{{item.link}}" target="youtube"> <small>
										듣기</small></a>

							</div>
						</span> <span ng-if="item.code=='' ||  currentState.name =='비례'"
							style="display: inline-block;">
							{{item.name}}{{item.title}} <span class="badge"
							ng-style="{'color':parties[item.party].textColor,'background-color': parties[item.party].color,'margin-left':'5px'}">{{parties[item.party].name}}</span>


							<a ng-if="item.link!=''" ng-href="{{item.link}}" target="youtube">
								<small> 듣기</small>
						</a>


						</span>
						<button class="btn btn-sm btn-secondary pin"
							ng-click="toggleShow(item)" ng-show="result=='show'"
							ng-if="(item.type=='광역' || item.type=='기초' || item.type=='국회')">
							<span
								ng-class="{'glyphicon-pushpin':!item.show,'glyphicon-remove':item.show,}"
								class="glyphicon "></span>
						</button>


						<div class="bar" id="pie{{$index}}" ng-show="result=='show'"
							ng-if="(item.type=='광역' || item.type=='기초' || item.type=='국회')"
							ng-init="drawRate('pie'+$index,item.candidates,5)"></div>

						<div style="margin-bottom: 5px; margin-left: 5px;"
							ng-show="result=='show' && currentState.name=='비례' && item.type=='낙선'">
							<small style="margin-bottom: 5px;">득표 <span
								class="text-muted">{{item.code|number}}
									({{item.percent|number:2}}%)</span></small>
						</div>

						<div class="row">
							<div ng-repeat="candidate in item.candidates" class="card mb-3"
								ng-style="{'border-color':parties[candidate.party].color}"
								style="max-width: 21rem;"
								ng-init="subInit()">
								<div class="card-header"
									ng-class="{'champ': candidate.txt=='당선'}">
									<small><span class="glyphicon glyphicon-star"
										style="color: gold;" ng-if="candidate.txt=='당선'"></span></small> 
									<span uib-tooltip-html="tooltipHtml" tooltip-animation="false"
									ng-mouseover="makeTooltipHtml(candidate,'추가이력');"
									ng-if="candidate.history>1">
									<a
									href="#" data-toggle="modal" data-target="#history"									
									ng-click="getHistory(candidate.person)"
									>{{persons[candidate.person].name}}</a>
									</span>
									<span ng-if="candidate.history<=1"
										ng-class="{'nchamp': candidate.txt=='당선'}">{{persons[candidate.person].name}}
									</span> <span class="badge"
										ng-style="{'color':parties[candidate.party].textColor,'background-color': parties[candidate.party].color}">{{parties[candidate.party].name}}</span>
									<a ng-href="{{candidate.link}}" target="youtube"><small
										ng-show="candidate.link!=''">듣기</small></a>

								</div>
								<div class="card-body"
									ng-show="result=='show' && currentElection.result=='true'  && currentState.name != '비례'">
									<strong>{{candidate.txt}}</strong> <span class="text-muted"
										ng-show="candidate.txt=='당선' || candidate.txt=='낙선' ">{{candidate.rate|number}}
										({{candidate.percent|number:2}}%)</span>
								</div>
							</div>
							<!-- 			 		<div ng-if="item.type=='광역' || item.type=='기초'" id="pie{{$index}}" style="width: 41px;height:41px;display:inline-block;margin-left:15px;" ng-init="drawPie('pie'+$index,item.candidates)"></div>				 				 -->
						</div>

						<div ng-if="item.type=='광역' || item.type=='기초' || item.type=='국회'"
							ng-show="result=='show'">


							<!-- 					<div class="row" style="margin-left:6px;" > -->
							<!-- 			 		<small style="margin-bottom:5px;">득표</small>		 		 -->
							<!-- 			 		</div> -->
							<div class="row" style="margin-left: 6px;"
								ng-if="item.type=='광역' || item.type=='기초'">
								<div style="margin-right: 30px;"
									ng-if="item.type=='기초' && item.metros.length > 0">
									<small style="margin-bottom: 3px;">광역의원</small>
									<div style="height: 6px; margin-top: 2px;" id="metro{{$index}}"
										ng-init="drawMember('metro'+$index,item.metros,3)"></div>
									<table class="table table-sm "
										style="width: auto; margin-bottom: 0px; border-top: 2px solid white;"
										align="center">
										<col width="90" ng-repeat="council in item.metros">
										<col width="90">

										<tr>
											<td align="center" ng-repeat="council in item.metros"
												style="padding-top: 0px;"><small> <span
													class="badge"
													ng-style="{'color':parties[council.party].textColor,'background-color': parties[council.party].color}">{{parties[council.party].name}}</span>
											</small></td>
											<td align="center" style="padding-top: 0px;"><small>총원</small></td>
										</tr>
										<tr>
											<td align="center" ng-repeat="council in item.metros"
												ng-init="item.metroTotal = item.metroTotal+council.count"><small>{{council.count}}</small></td>
											<td align="center"><small>{{item.metroTotal}}</small></td>
										</tr>
									</table>
								</div>

								<div style="margin-right: 10px;">
									<small style="margin-bottom: 3px;">{{item.type}}의회 구성</small>
									<div style="height: 6px; margin-top: 2px;"
										id="member{{$index}}"
										ng-init="drawMember('member'+$index,item.councils,3)"></div>
									<table class="table table-sm "
										style="width: auto; margin-bottom: 0px; border-top: 2px solid white;"
										align="center">
										<col width="90" ng-repeat="council in item.councils">
										<col width="90">

										<tr>
											<td align="center" ng-repeat="council in item.councils"
												style="padding-top: 0px;"><small> <span
													class="badge"
													ng-style="{'color':parties[council.party].textColor,'background-color': parties[council.party].color}">{{parties[council.party].name}}</span>
											</small></td>
											<td align="center" style="padding-top: 0px;"><small>총원</small></td>
										</tr>
										<tr>
											<td align="center" ng-repeat="council in item.councils"
												ng-init="item.total = item.total+council.count"><small>{{council.count}}</small></td>
											<td align="center"><small>{{item.total}}</small></td>
										</tr>
									</table>
								</div>
								<div style="margin-right: 30px; line-height: 14px;"
									ng-style="{'padding-top':getCouncilPadding(item.total),'width':getCouncilWidth(item.total)}">
									<small
										ng-repeat="n in getCouncilArray(item.councils) track by $index"
										tooltip-animation="false" uib-tooltip="{{parties[n].name}}">
										<span class="glyphicon glyphicon-user member"
										ng-style="{'color': parties[n].color}"></span>
									</small>
								</div>
								<div ng-show="item.rates.length > 0" style="margin-right: 20px;">
									<small style="margin-left: 6px;">비례득표</small><br />

									<div id="rate{{$index}}"
										style="width: 65px; height: 65px; display: inline-block;"
										ng-init="drawRatePie({id:'rate'+$index,rates:item.rates})"></div>
								</div>
<!-- 								<div ng-show="item.mrates.length > 0"> -->
<!-- 									<small>광역비례득표</small><br /> -->

<!-- 									<div id="mrate{{$index}}" -->
<!-- 										style="width: 45px; height: 45px; display: inline-block; margin-left: 15px;" -->
<!-- 										ng-init="drawRatePie({id:'mrate'+$index,rates:item.mrates})"></div> -->
<!-- 								</div> -->
							</div>
							<!-- 			 		<hr style="margin-top:0px;"/> -->
						</div>
						<div ng-if="item.type=='광역득표'" style="padding-top: 5px;">
							<button class="btn btn-sm"
								ng-style="{'color':parties[party].textColor,'background-color': parties[party].color}"
								ng-repeat="(party, value) in metros"
								ng-click="drawMetroRate('metroRate',party,metros)">
								{{parties[party].name}}</button>
							<br>
							<small class="text-muted">지도 클릭시 후보이력</small>
							<div id="metroRate"
								ng-style="{'width':min(1024,min(getWidth('metroRate'),getHeight('metroRate'))),'height':min(1024,min(getWidth('metroRate'),getHeight('metroRate')))}"></div>
						</div>
						<div ng-if="item.type=='기초득표'" style="padding-top: 5px;">
							<button class="btn btn-sm"
								ng-style="{'color':parties[party].textColor,'background-color': parties[party].color}"
								ng-repeat="(party, value) in basics"
								ng-click="drawMetroRate('basicRate',party,basics)">
								{{parties[party].name}}</button>
							<br>
							<small class="text-muted">지도 클릭시 후보이력</small>
							<div id="basicRate"
								ng-style="{'width':getWidth('basicRate'),'height':getWidth('basicRate')}"></div>
						</div>
						<div ng-if="item.type=='광역비례득표'" style="padding-top: 5px;">
							<button class="btn btn-sm"
								ng-style="{'color':parties[party].textColor,'background-color': parties[party].color}"
								ng-repeat="(party, value) in rmetros"
								ng-click="drawMetroRate('metroRRate',party,rmetros)">
								{{parties[party].name}}</button>

							<div id="metroRRate"
								ng-style="{'width':min(1024,min(getWidth('metroRRate'),getHeight('metroRRate'))),'height':min(1024,min(getWidth('metroRRate'),getHeight('metroRRate')))}"></div>
						</div>
						<div ng-if="item.type=='기초비례득표'" style="padding-top: 5px;">
							<button class="btn btn-sm"
								ng-style="{'color':parties[party].textColor,'background-color': parties[party].color}"
								ng-repeat="(party, value) in rbasics"
								ng-click="drawMetroRate('basicRRate',party,rbasics)">
								{{parties[party].name}}</button>

							<div id="basicRRate"
								ng-style="{'width':getWidth('basicRate'),'height':getWidth('basicRate')}"></div>
						</div>
						<div ng-if="item.type=='득표'" style="padding-top: 5px;">
							<button class="btn btn-sm"
								ng-style="{'color':parties[party.party].textColor,'background-color': parties[party.party].color}"
								ng-repeat="party in rateParty | orderBy:'-count'"
								ng-click="drawSenateRate('metroRate',party.party,metros)">
								{{parties[party.party].name}}</button>
							<br>
							<small class="text-muted">지도 클릭시 후보이력</small>
							<div id="metroRate"
								ng-style="{'width':min(1024,getWidth('metroRate')),'height':min(1024,getWidth('metroRate'))*3/2}"
								style="margin: 0 auto;"></div>
						</div>

					</div>
				</div>
				<div ng-show="result=='show'" ng-if="currentState.name=='비례'">
					<small>득표</small>
					<div style="width: 20px; height: 100%; margin-left: 3px;" id="rate"
						ng-init="drawItemRate('rate','party')"></div>
				</div>

			</div>
		</div>

		<div class="row" ng-if="currentElection.type=='inspection'">
			<div class="col-lg-2">
				<ul class="nav nav-pills  flex-column">
					<li class="nav-item" ng-repeat="state in states"><a href="#"
						data-toggle="tab" class="nav-link" ng-class="{active:$first}"
						ng-click="selectState(state)"> {{state.name}} </a></li>

				</ul>
				<br>
			</div>
			<div class="col inspection-tab" style="padding-left: 20px;">

				<div
					ng-repeat="item in items | toArray:false  | filter : {'type':'소속위원'}"
					class="item">

					<div>
						<small><span class="text-muted"> {{item.name}} </span></small>
					</div>
					<div>
						<a href="#" ng-repeat="candidate in item.candidates"
							tooltip-animation="false" uib-tooltip-html="tooltipHtml"
							ng-mouseover="makeTooltipHtml(candidate,candidate.txt+' '+parties[candidate.party].name+' '+persons[candidate.person].name);"
							data-toggle="modal" data-target="#history"
							ng-click="getHistory(candidate.person);" class="member"> <span
							class="glyphicon glyphicon-user member"
							ng-style="{'color': parties[candidate.party].color}"
							ng-class="{'small':candidate.txt!='위원장'}"></span>
						</a>
					</div>
				</div>
				<br />
				<div
					ng-repeat="item in items | toArray:false  | filter : {'type':'오버뷰'}"
					style="margin-bottom: 20px;">
					<small class="text-muted">{{item.name}}</small> <a
						ng-href="{{item.link}}" ng-if="item.link!=''" target="youtube"
						style="margin-right: 10px;"> <small> 듣기</small></a>
				</div>
				<div class="row">
					<div class="col-lg-6">
						<div style="margin-bottom: 5px;">
							<small class="text-muted">이슈 {{(items | toArray:false |
								filter : {'type':'이슈'}).length}}</small>
						</div>
						<ul class="list-group"
							style="margin-right: 20px; border-top: 5px solid #2780E3;">
							<li class="list-group-item ">
								<div
									ng-repeat="item in items | toArray:false  | filter : {'type':'이슈'}">
									<hr ng-if="!$first">
									<small> <span class="glyphicon glyphicon-book "
										style="color: #2780E3;; margin-right: 5px;"></span>
									</small> {{item.name}} <a ng-href="{{item.link}}" ng-if="item.link!=''"
										target="youtube" style="margin-right: 10px;"> <small>
											듣기</small></a> <span><small> <a href="#"
											ng-repeat="candidate in item.candidates"
											tooltip-animation="false" uib-tooltip-html="tooltipHtml"
											ng-mouseover="makeTooltipHtml(candidate,candidate.txt+' '+parties[candidate.party].name+' '+persons[candidate.person].name);"
											data-toggle="modal" data-target="#history"
											ng-click="getHistory(candidate.person);" class="member"> <span
												class="glyphicon glyphicon-user member"
												ng-style="{'color': parties[candidate.party].color}"
												ng-class="{}"></span>
										</a></small> </span>
		
								</div>
							</li>
						</ul>
					</div>
					
					<div class="col-lg-6">
					
						<div style="margin-bottom: 5px;">
							<small class="text-muted">주목할 만한 시전과 피폭</small>
						</div>
						<ul class="list-group"
							style="margin-right: 20px; border-top: 5px solid #FF0039;">
							<li class="list-group-item ">
								<div
									ng-repeat="item in items | toArray:false  | filter : {'type':'피폭'}">
									<hr ng-if="!$first">
									<small><span
										class="glyphicon glyphicon-alert text-danger"
										style="margin-right: 5px;"></span> </small> {{item.name}} <a
										ng-href="{{item.link}}" ng-if="item.link!=''" target="youtube"
										style="margin-right: 10px;"> <small> 듣기</small></a> <span><small>
											<a href="#" ng-repeat="candidate in item.candidates"
											tooltip-animation="false" uib-tooltip-html="tooltipHtml"
											ng-mouseover="makeTooltipHtml(candidate,candidate.txt+' '+parties[candidate.party].name+' '+persons[candidate.person].name);"
											data-toggle="modal" data-target="#history"
											ng-click="getHistory(candidate.person);" class="member"> <span
												class="glyphicon glyphicon-user member"
												ng-style="{'color': parties[candidate.party].color}"
												ng-class="{}"></span>
										</a>
									</small> </span>
		
								</div>
							</li>
						</ul>
		
		
						<ul class="list-group"
							style="margin-right: 20px; margin-bottom: 10px; border-top: 5px solid gold;"
							ng-repeat="item in items | toArray:false  | filter : {'type':'파이날'}">
							<li class="list-group-item ">
								<div>
									<hr ng-if="!$first">
									<span class="glyphicon glyphicon-tower "
										style="color: gold; margin-right: 5px;"></span> Final 4 <a
										ng-href="{{item.link}}" ng-if="item.link!=''" target="youtube"
										style="margin-right: 10px;"> <small> 듣기</small></a> <span><small>
											<a href="#" tooltip-animation="false"
											uib-tooltip-html="tooltipHtml"
											ng-mouseover="makeTooltipHtml(candidate,candidate.txt+' '+parties[candidate.party].name+' '+persons[candidate.person].name);"
											ng-repeat="candidate in item.candidates" data-toggle="modal"
											data-target="#history" ng-click="getHistory(candidate.person);"
											class="member"> <span
												class="glyphicon glyphicon-user member"
												ng-style="{'color': parties[candidate.party].color}"
												ng-class="{}"></span>
										</a>
									</small> </span>
		
								</div>
							</li>
						</ul>
					</div>
				</div>

			</div>
		</div>



		<div ng-if="currentElection.type=='by'" style="padding-left: 10px;">
			<div ng-repeat="item in items" class="item"
				ng-class="{'show':item.show}">

				<span ng-if="item.code!='' && currentState.name !='비례'"
					style="display: inline-block;">

					<div ng-if="item.code!=''" id="main{{$index}}" class="map"
						style="width: 30px; height: 30px; display: inline-block;"
						ng-init="draw('main'+$index,item.code)"></div>
					<div class="title">
						<span ng-if="item.zone!=''"><a href="#"
							tooltip-animation="false" uib-tooltip="지역이력" data-toggle="modal"
							data-target="#zone" ng-click="getZoneHistory(item.zone);">{{item.name}}{{item.title}}</a></span>
						<span ng-if="item.zone==''">{{item.name}}{{item.title}}</span> <span
							class="badge"
							ng-style="{'color':parties[item.party].textColor,'background-color': parties[item.party].color,'margin-left':'2px'}">{{parties[item.party].name}}</span>

						<a ng-href="{{item.link}}" target="youtube"> <small>
								듣기</small></a>

					</div>
				</span> <span ng-if="item.code=='' ||  currentState.name =='비례'"
					style="display: inline-block;"> {{item.name}}{{item.title}}
					<span class="badge"
					ng-style="{'color':parties[item.party].textColor,'background-color': parties[item.party].color,'margin-left':'5px'}">{{parties[item.party].name}}</span>


					<a ng-href="{{item.link}}" target="youtube"> <small> 듣기</small></a>


				</span>
				<button class="btn btn-sm btn-secondary pin"
					ng-click="toggleShow(item)" ng-show="result=='show'"
					ng-if="(item.type=='광역' || item.type=='기초' || item.type=='국회')">
					<span
						ng-class="{'glyphicon-pushpin':!item.show,'glyphicon-remove':item.show,}"
						class="glyphicon "></span>
				</button>


				<div class="bar" id="pie{{$index}}" ng-show="result=='show'"
					ng-if="(item.type=='광역' || item.type=='기초' || item.type=='국회')"
					ng-init="drawRate('pie'+$index,item.candidates,5)"></div>




				<div class="row">
					<div ng-repeat="candidate in item.candidates">
						<div class="card mb-3"
							ng-style="{'border-color':parties[candidate.party].color}"
							style="max-width: 20rem;">
							<div class="card-header"
								ng-class="{'champ': candidate.txt=='당선'}">
								<small><span class="glyphicon glyphicon-star"
									style="color: gold;" ng-if="candidate.txt=='당선'"></span></small> 
									<span uib-tooltip-html="tooltipHtml" tooltip-animation="false"
									ng-mouseover="makeTooltipHtml(candidate,'추가이력');"
									ng-if="candidate.history>1">
									<a
									href="#" data-toggle="modal" data-target="#history"									
									ng-click="getHistory(candidate.person)"
									>{{persons[candidate.person].name}}</a>
									</span>
								<span ng-if="candidate.history<=1">{{persons[candidate.person].name}}
								</span> <span class="badge"
									ng-style="{'color':parties[candidate.party].textColor,'background-color': parties[candidate.party].color}">{{parties[candidate.party].name}}</span>
								<a ng-href="{{candidate.link}}" target="youtube"><small>듣기</small></a>

							</div>
							<div class="card-body" ng-if="candidate.count>0">
								<a ng-repeat="sub in candidate.subs " ng-href="{{sub.link}}"
									target="youtube" style="margin-right: 5px;">{{sub.txt}}</a>
							</div>

							<div class="card-body"
								ng-show="(result=='show' && currentElection.result=='true')">
								<strong>{{candidate.txt}}</strong> <span class="text-muted"
									ng-show="candidate.txt=='당선' || candidate.txt=='낙선' ">{{candidate.rate|number}}
									({{candidate.percent|number:2}}%)</span>
							</div>



						</div>
					</div>
				</div>
				<!-- 	 		<div ng-if="item.type=='광역' || item.type=='기초' || item.type=='국회'" ng-show="result=='show'" > -->
				<!-- 				<div class="row" style="margin-left:6px;"> -->
				<!-- 			 		<small style="margin-bottom:5px;">득표</small>		 		 -->
				<!-- 			 		<span id="pie{{$index}}" style="width:calc(100% - 50px);height:5px;margin-top: 7px;margin-left:5px;margin-bottom:20px;" ng-init="drawRate('pie'+$index,item.candidates)"></span> -->
				<!-- 		 		</div> -->
				<!-- 		 	</div>	 -->
			</div>

		</div>


		<div ng-if="currentElection.type=='presidential'"
			style="padding-left: 30px;" class="row">

			<div style="width: calc(100% - 65px);">
				<div ng-repeat="item in items" class="item">
					<h6>
						<small><span class="glyphicon glyphicon-star"
							style="color: gold;" ng-if="item.type == '당선'"></span></small> <a
							href="#" data-toggle="modal" data-target="#history"
							ng-if="item.history>1" ng-click="getHistory(item.person)"
							uib-tooltip-html="tooltipHtml" tooltip-animation="false"
							ng-mouseover="makeTooltipHtml(item,'추가이력');"
							tooltip-placement="top-left">{{persons[item.person].name}}</a>
						<span ng-if="item.history<=1">{{persons[item.person].name}}
						</span> <span class="badge"
							ng-style="{'color':parties[item.party].textColor,'background-color': parties[item.party].color}">{{parties[item.party].name}}</span>

						<a ng-href="{{item.link}}" target="youtube"> <small>듣기</small></a>
					</h6>
					<div style="margin-bottom: 5px;" ng-show="result=='show'">
						<small style="margin-bottom: 5px;"><strong>{{item.type}}</strong>
							<span ng-show="item.type=='당선' || item.type=='낙선'"
							class="text-muted">{{item.code|number}}
								({{item.percent|number:2}}%)</span></small>
					</div>

					<div class="row">
						<div ng-repeat="candidate in item.candidates" class="card mb-3"
							style="width: 13rem;"
							ng-style="{'border-color':parties[candidate.party].color}"
							style=" max-width: 20rem;">
							<div class="card-header">
								{{candidate.txt}} <a ng-href="{{candidate.link}}"
									target="youtube"><small>듣기</small></a>

							</div>
							<div class="card-body" ng-if="candidate.count>0">
								<a ng-repeat="sub in candidate.subs " ng-href="{{sub.link}}"
									target="youtube" style="margin-right: 5px;" ng-init="subInit();">{{sub.txt}}</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div ng-show="result=='show'">
				<small>득표</small>
				<div style="width: 20px; height: 100%; margin-left: 3px;" id="rate"
					ng-init="drawItemRate('rate','person')"></div>
			</div>
			<!-- 	  	<div ng-show="result=='show'"> -->
			<!-- 	  	<hr/> -->
			<!-- 	  		투표결과 -->
			<!-- 	  		<div id="rate" style="width:calc(100% - 10px);height:10px;margin-top: 7px;margin-left:5px;" ng-init="drawItemRate('rate')"></div> -->

			<!-- 		  	<div id="pie" style="width:calc(100% - 10px);height:150px;margin-top: 7px;margin-left:5px;margin-bottom:20px;" ng-init="drawPie('pie',items)"></div> -->
			<!-- 	  	</div> -->
		</div>


		<div class="modal fade" id="history" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" style="padding-left: 10px;">{{title}}</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="padding-left: 10px;">

						<div ng-repeat="(person,item) in history ">

							<hr ng-show="!$first">

							<div ng-if="persons[person].photo == true">
								<img ng-if="persons[person].photo == true"
									ng-src="portrait/{{person}}.jpg"
									style="width: 66px; height: 88px; margin-bottom: 10px; margin-left: 15px;margin-right: 5px;"></img>
								<span class="text-muted" style="top: 30px;position: relative;"><small>{{persons[person].txt}}</small></span>
								<span class="glyphicon glyphicon-knight" style="top: 34px;position: relative;color: gold;" 
								ng-if="(item.election | filter:positiveRate).length>=4"
								tooltip-animation="false" uib-tooltip="꾸준 출마자 "></span>
								<span class="glyphicon glyphicon-knight" style="top: 34px;position: relative;color: silver;" 
								ng-if="(item.election | filter:positiveRate).length==3"
								tooltip-animation="false" uib-tooltip="꾸준 출마자 "></span>
								<span class="glyphicon glyphicon-bishop" style="top: 34px;position: relative;color: gold;" ng-if="item.inspection.length>=7"
								tooltip-animation="false" uib-tooltip="프로 국감러"></span>
								<span class="glyphicon glyphicon-bishop" style="top: 34px;position: relative;color: silver;" ng-if="item.inspection.length==6"
								tooltip-animation="false" uib-tooltip="프로 국감러"></span>

							</div>
							<div ng-if="persons[person].photo != true" style="padding-left:16px;">
								<span class="glyphicon glyphicon-knight" style="color: gold;"
								ng-if="(item.election | filter:positiveRate).length>=4"								
								tooltip-animation="false" uib-tooltip="꾸준 출마자 "></span>
								<span class="glyphicon glyphicon-knight" style="color: silver;" 
								ng-if="(item.election | filter:positiveRate).length==3"
								tooltip-animation="false" uib-tooltip="꾸준 출마자 "></span>
								<span class="glyphicon glyphicon-bishop" style="color: gold;" ng-if="item.inspection.length>=7"
								tooltip-animation="false" uib-tooltip="프로 국감러"></span>
								<span class="glyphicon glyphicon-bishop" style="color: silver;" ng-if="item.inspection.length==6"
								tooltip-animation="false" uib-tooltip="프로 국감러"></span>

							</div>

							<div ng-repeat="i in item.election | orderBy:'date'">
									
								<h6 ng-class="{'mchamp':i.result!='당선'}">
									<small><span class="glyphicon glyphicon-star"
										style="color: gold;" ng-if="i.result=='당선'"></span></small> <span
										ng-show="i.link == ''"> {{i.txt}} </span> <a
										ng-show="i.link != ''" ng-href="{{i.link}}" target="youtube"
										style="color: grey;" tooltip-animation="false"
										uib-tooltip="듣기"> {{i.txt}}</a> <span class="badge"
										ng-style="{'color':parties[i.party].textColor,'background-color': parties[i.party].color}">{{parties[i.party].name}}</span>

									<small class="text-muted"><strong>{{i.result}}</strong></small>
								</h6>

							</div>

							<div style="width: 100%;margin-left: 5px;"
								ng-style="{'height':(item.election | filter:positiveRate).length*50+'px'}"
								id="history{{$index}}"
								ng-show="(item.election | filter:positiveRate).length>1"></div>


							<div ng-show="item.inspection.length>0"
								style="margin-left: 15px;">
								<div style="margin-bottom: 2px;">
									<small class="text-muted"><span
										style="margin-right: 5px;"></span><strong>국정감사기록</small></strong>
								</div>
								<!-- 			      	<h6 ng-repeat="i in item.inspection">  -->
								<!-- 			      		<small><span class="glyphicon glyphicon-file" style="color:silver;margin-right:2px;"></span></small>{{i.txt}}  -->
								<!-- 			      		<span class="badge badge-secondary" style=" background-color: darkgrey;">{{i.department}}</span> -->
								<!-- 			      		<small class="text-muted">{{i.date}} -->
								<!-- 			      		<a ng-show="i.link != ''" ng-href="{{i.link}}" target="youtube">  듣기</a></small> -->
								<!-- 			      	</h6> -->
								<span ng-repeat="i in item.inspection" class="inspection"
									style="margin-right: 2px;"> <a ng-href="{{i.link}}"
									id="inspection{{$index}}" target="youtube" data-html="true"
									data-content=" {{i.department}} <small class='text-muted'>{{i.date}}</small>"
									title="<strong>{{i.txt}}</strong>"
									ng-init="setPopover('inspection'+$index)"
									data-placement="bottom" ng-mouseenter="i.hover = true"
									ng-mouseleave="i.hover = false"> <span ng-if="i.type=='이슈'"
										class="glyphicon item"
										ng-class="{'glyphicon-book':!i.hover,'glyphicon-headphones':i.hover}"
										ng-style="{'color':parties[i.party].color}"></span> <span
										ng-if="i.type=='피폭'" class="glyphicon  item"
										ng-class="{'glyphicon-alert':!i.hover,'glyphicon-headphones':i.hover}"
										ng-style="{'color':parties[i.party].color}"></span> <span
										ng-if="i.type=='파이날'" class="glyphicon  item"
										ng-class="{'glyphicon-tower':!i.hover,'glyphicon-headphones':i.hover}"
										ng-style="{'color':parties[i.party].color}"></span>
								</a>
								</span>
							</div>


						</div>

						<div ng-show="( history |  toArray:false).length > 1"
							style="padding-left: 17px;">
							<br>
							<small><p class="text-muted">
									검색된 인물 : <strong>{{( history | toArray:false).length}}</strong>명
								</p></small>
						</div>

						<div ng-show="( history |  toArray:false).length == 0"
							style="padding-left: 17px;">데이터 없음</div>
						<center>
							<img ng-if="title=='503'" src="chicken.jpg"
								style="width: 200px; margin: 20px;" /> <img ng-if="title=='716'"
								src="mouse.png" style="width: 100px; margin: 20px;" />
						</center>
					</div>

				</div>
			</div>
		</div>


		<div class="modal fade" id="zone" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">{{zoneTitle}} 
							<small  style="margin-left:3px;color:silver;top: 2px; position: relative;"> 
								<small><span class="glyphicon glyphicon-user"> </span></small> {{pop|number}}</small></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<div ng-repeat="(name,eh) in electionHistory"
							style="margin-bottom: 15px;">
							<div style="margin-bottom: 3px;">
								<small><strong>{{name}}</strong></small>
							</div>
							<div ng-repeat="item in eh" style="margin-bottom: 2px;"
								ng-class="{'jumbotron':result=='show'}">
								<h6 ng-class="{'no-margin':result=='show'}">
									<a ng-href="{{item.link}}" target="youtube"
										tooltip-animation="false" uib-tooltip="듣기"
										style="color: grey;" tooltip-append-to-body="true">{{item.name}}{{item.title}}</a>
									<small ng-repeat="candidate in item.candidates"
										tooltip-animation="false" uib-tooltip-html="tooltipHtml"
										ng-mouseover="makeTooltipHtml(candidate,parties[candidate.party].name+' '+persons[candidate.person].name+' '+candidate.txt);"
										
										tooltip-append-to-body="true"
										> 
										<a
										ng-if="candidate.link!=''" ng-href="{{candidate.link}}"
										target="youtube"> <span class="glyphicon glyphicon-user"
											ng-style="{'color': parties[candidate.party].color}"></span>
									</a> <a ng-if="candidate.link==''"> <span
											class="glyphicon glyphicon-user"
											ng-style="{'color': parties[candidate.party].color}"></span>
									</a>

									</small>
								</h6>
								
								<div class="row" style="margin-left: 5px;"
									ng-show="result=='show'">
									<div style="margin-right: 10px;"
										ng-show="item.candidates.length>=2">
										<small class="text-muted">후보득표</small><br />
										<div id="result{{$parent.$index}}{{$index}}"
											style="margin-left: 5px; width: 40px; height: 40px; display: inline-block;"
											ng-init="drawRatePie({id:'result'+$parent.$index+$index,rates:item.candidates,candidate:true})"></div>
									</div>
									<div ng-show="item.councils.length > 0"
										style="margin-right: 10px;">
										<small class="text-muted">의회구성</small><br />

										<div id="zoneMember{{$parent.$index}}{{$index}}"
											style="margin-left: 5px; width: 40px; height: 40px; display: inline-block;"
											ng-init="drawRatePie({id:'zoneMember'+$parent.$index+$index,rates:item.councils,showRate:false})"></div>
									</div>

									<div ng-show="item.rates.length > 0"
										style="margin-right: 20px;">
										<small class="text-muted">비례득표</small><br />

										<div id="zoneRate{{$parent.$index}}{{$index}}"
											style="margin-left: 5px; width: 40px; height: 40px; display: inline-block;"
											ng-init="drawRatePie({id:'zoneRate'+$parent.$index+$index,rates:item.rates})"></div>
									</div>

								</div>

							</div>

						</div>


					</div>

				</div>
			</div>
		</div>


		<br>
		<div class="push"></div>


	</div>
	<div
		class="navbar footer sticky-bottom navbar-expand-lg  navbar-dark bg-dark">

		<ul class="nav navbar-nav">
			<li class="nav-item"><a class="nav-link"> <small>본
						페이지는 개인이 심심해서 만든 페이지이며 xsfm과는 관련이 없습니다.</small></a></li>
		</ul>
	</div>

	<script>
 
 window.mobileAndTabletcheck = function() {
  var check = false;
  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
  return check;
};
	
var app = angular.module('myApp', ['angular-toArrayFilter','ui.bootstrap']);
app.controller('myCtrl', function($scope,$http,$filter,$window,$sce) {
	
	$scope.result = 'show';
	$scope.tooltipHtml = $sce.trustAsHtml("test");
	
	$scope.makeTooltipHtml = function(candidate,txt){
		
		if($scope.persons[candidate.person].photo== true)
			$scope.tooltipHtml= $sce.trustAsHtml("<img src='portrait/"+candidate.person+".jpg' style='width:30px;height:40px;margin-right:5px;'/>"+txt);
		else $scope.tooltipHtml= $sce.trustAsHtml(txt); 
	}

	$scope.subInit = function(){
    	$scope.loadedTime = new Date().getTime();

	};

	
	$http.get("data/elections.do")
    .then(function(response) {
        $scope.elections = response.data;
        $scope.getStates($scope.elections[0].id);
        $scope.currentElection = $scope.elections[0];
    });
	

	$http.get("data/persons.do")
    .then(function(response) {
    	$scope.persons = {};
        response.data.forEach(function(person) {
        	$scope.persons[person.id] = person
        });
    });

	
	$http.get("data/parties.do")
    .then(function(response) {
    	$scope.parties = {};
    	
    	$scope.parties[0] = {color:'silver'};
        response.data.forEach(function(party) {
        	$scope.parties[party.id] = party;
        });

    });

	$http.get("data/zones.do")
    .then(function(response) {
    	$scope.zones = {};
    	
        response.data.forEach(function(zone) {
        	$scope.zones[zone.code] = zone;
        });

    });

	$scope.max = function(a,b){
		if(a<b) return b;
		return a;
	}
	$scope.min = function(a,b){
		if(a>b) return b;
		return a;
	}
	
	$scope.getWidth = function(id){
		
		var page = angular.element($window);

		var height = page.height();
		var width = page.width();
		if(width>=576 ) return width-142;
		if(width<576 ){ return width;}
	}
	
	$scope.getHeight = function(id){
		var page = angular.element($window);
		var height = page.height();
		var width = page.width();
		return height;
	}

	

	
	
	$scope.getStates = function(election){
		
		$scope.items = {};
		
		$http.get("data/states.do?election="+election)
	    .then(function(response) {
	        $scope.states = response.data;        
			$scope.currentState = $scope.states[0];

	        $scope.getItems($scope.states[0].id);
	    });

	}
	
	$scope.selectElection =function(election){
		
    	$scope.loadedTime = null;

        $scope.currentElection = election;
		 $scope.getStates(election.id);
	}
	
	$scope.selectState =function(state){

    	$scope.loadedTime = null;

		$scope.items = {};


		$scope.currentState = state;
		 $scope.getItems(state.id);
        if($scope.currentState.name == '통계'){
			$scope.getRates();
			$scope.getRRates();
	        	
        }

	}
	
	
	$scope.getRates = function(){
    	$scope.metros = {};
    	$scope.basics = {};
    	var metroParty = 0;
    	var basicParty = 0;
    	$scope.rateParty = [];

		$http.get("data/rates.do?election="+$scope.currentElection.id)
	    .then(function(response) {
	    	$scope.rates = response.data;
	    	angular.forEach($scope.rates,function(rate){
	    		if(rate.type == '광역' || rate.type == '국회'){
	    			if(metroParty == 0) metroParty =rate.party;
	    			if($scope.metros[rate.party]==undefined){
	    				$scope.metros[rate.party] = [];
	    				$scope.rateParty.push({party:rate.party,count:0});
	    			}
	    			$scope.metros[rate.party].push(rate);
	    			
	    		}else if(rate.type == '기초' ){
	    			if(basicParty == 0) basicParty =rate.party;

	    			if($scope.basics[rate.party]==undefined){
	    				$scope.basics[rate.party] = [];
	    			}
	    			
	    			var arr = rate.code.split(",");

	    			angular.forEach(arr,function(code){
	    				var r = angular.copy(rate);
	    				r.code = code;
		    			$scope.basics[rate.party].push(r);		    				
	    			});
	    		}
	    	});
	    	
	    	if(Object.keys($scope.basics).length > 0){
		    	$scope.drawMetroRate('metroRate',metroParty,$scope.metros);
		    	$scope.drawMetroRate('basicRate',basicParty,$scope.basics);
	    	}else{
	    		angular.forEach($scope.rateParty,function(party){
	    			party.count = $scope.metros[party.party].length;
	    		});
	    		for(var i=0;i<$scope.rateParty.length;){
	    			if($scope.rateParty[i].count<=2){
	    				$scope.rateParty.splice(i,1);
	    			}else{
	    				i++;
	    			}
	    		}
		    	$scope.drawSenateRate('metroRate',metroParty,$scope.metros);	    		
	    	}
	    });
		
	}
	
	$scope.getRRates = function(){
    	$scope.rmetros = {};
    	$scope.rbasics = {};
    	var metroParty = 0;
    	var basicParty = 0;

		$http.get("data/rrates.do?election="+$scope.currentElection.id)
	    .then(function(response) {
	    	$scope.rrates = response.data;
	    	angular.forEach($scope.rrates,function(rate){
	    		if(rate.type == '광역'){
	    			if(metroParty == 0) metroParty =rate.party;
	    			if($scope.rmetros[rate.party]==undefined)
	    				$scope.rmetros[rate.party] = [];
	    			$scope.rmetros[rate.party].push(rate);
	    			
	    		}else if(rate.type == '기초'){
	    			if(basicParty == 0) basicParty =rate.party;

	    			if($scope.rbasics[rate.party]==undefined){
	    				$scope.rbasics[rate.party] = [];
	    			}
	    			
	    			var arr = rate.code.split(",");

	    			angular.forEach(arr,function(code){
	    				var r = angular.copy(rate);
	    				r.code = code;
		    			$scope.rbasics[rate.party].push(r);		    				
	    			});
	    		}
	    	});
	    	
	    	
	    	$scope.drawMetroRate('metroRRate',metroParty,$scope.rmetros);
	    	$scope.drawMetroRate('basicRRate',basicParty,$scope.rbasics);

	    });
		
	}
	
	
	
	$scope.loading = true;
	$scope.candidateLoading = true;
	
	$scope.getItems = function(state) {
		
		
		
		$http.get("data/items.do?state="+state)
	    .then(function(response) {
	    	
	    	$scope.items = {};
	    	
	    	response.data.forEach(function(item){
				
	    		item.show = false;
	    		item.candidates = [];
	    		item.councils = [];
	    		item.rates = [];
	    		item.metros = [];
	    		item.mrates = [];

	    		$scope.items[item.id] = item;
	    		
	    	});
	    	
	    	if($scope.currentElection.type == 'presidential' || $scope.currentState.name == '비례'){
	    		var total = 0;
	    		angular.forEach($scope.items,function(item){
	    			if(item.code !=''){
		    			item.code = parseInt(item.code);
		    			total += item.code;
	    			}
	    			
	    		});
	    		angular.forEach($scope.items,function(item){
	    			item.percent = item.code * 100 / total;
	    		});
	    		
	    	}

    		
	    	$http.get("data/candidates.do?state="+state)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(candidate) {
    	    		
    	    		$scope.items[candidate.item].candidates.push(candidate);
    	        	$scope.getSubs(candidate);
            	});
    	    	
    	    	angular.forEach($scope.items,function(item){
    	    		var total = 0;
    	    		item.candidates.forEach(function(candidate){
    	    			total += candidate.rate;
    	    		});
    	    		item.candidates.forEach(function(candidate){
    	    			candidate.percent = candidate.rate*100/total;
    	    		});
    	    	});
    	    	
    	    	$scope.candidateLoading = false;
    	    	
    	    });	        	



    		$http.get("data/councils.do?state="+state)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(council) {
    	    		if(council.type == 'rate'){
        	    		$scope.items[council.item].rates.push(council);    	    			    	  
    	    		}else if(council.type == 'mrate'){
        	    		$scope.items[council.item].mrates.push(council);    	    			    	  
    	    		}else if(council.type == 'metro'){
        	    		$scope.items[council.item].metros.push(council);    	    			    	      	    			
    	    		}else{
        	    		$scope.items[council.item].councils.push(council);    	    			    	    			
    	    		}
            	});
    	    	
    	    	$scope.loading = false;

    	    	
    	    });

// 	        setTimeout(function(){
// 		        $scope.draw();
	        	
// 	        },1000)

	    });

    };
    

	$scope.getSubs = function(candidate){
		if(candidate.count > 0){
			$http.get("data/subs.do?candidate="+candidate.id)
		    .then(function(response) {
		    	candidate.subs = response.data;

		    });
		}
	}
	
	$scope.getHistory = function(person){
		$scope.history = {};

		$scope.title = $scope.persons[person].name;
		$http.get("data/history.do?person="+person)
	    .then(function(response) {
			$scope.makeHistory(response.data);
	    });
		$http.get("data/inspection.do?person="+person)
	    .then(function(response) {
			$scope.makeInspection(response.data);
	    });

	}

	$scope.getZoneHistory = function(code){

		
		$scope.zoneTitle = "";
		$scope.pop = 0;
		
    	$scope.electionHistory = {};
    	
    	if($scope.zones[code] == undefined){
        	var arr = code.split(",");
        	angular.forEach(arr,function(c){
        		$scope.zoneTitle += $scope.zones[c].name +" ";
        		$scope.pop += $scope.zones[c].pop;
        	});    		
    	}else{
    		$scope.zoneTitle =$scope.zones[code].name;
    		$scope.pop = $scope.zones[code].pop;
    	}

		$http.get("data/zoneHistory.do?code="+code)
	    .then(function(response) {
	    	
	    	response.data.forEach(function(item){
	    		if($scope.electionHistory[item.election] == undefined){
	    			$scope.electionHistory[item.election] = [];
	    		}
	    		$scope.electionHistory[item.election].push(item);
	    	});
	    	
			$scope.zoneItems = {};
	    	
			$scope.loading = true;
			
	    	response.data.forEach(function(item){
				
	    		item.show = false;
	    		item.candidates = [];
	    		item.councils = [];
	    		item.rates = [];
	    		item.metros = [];
	    		item.mrates = [];

	    		$scope.zoneItems[item.id] = item;
	    		
	    	});
	    	
    		
	    	$http.get("data/zoneCandidates.do?zone="+code)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(candidate) {
    	    		
    	    		$scope.zoneItems[candidate.item].candidates.push(candidate);
            	});
    	    	
    	    	var index = 0;
    	    	angular.forEach($scope.zoneItems,function(item){
    	    		var total = 0;
    	    		item.candidates.forEach(function(candidate){
    	    			total += candidate.rate;
    	    		});
    	    		item.candidates.forEach(function(candidate){
    	    			candidate.percent = candidate.rate*100/total;
    	    		});
    	    		
    	    		if(item.type=='기초' || item.type=='광역' || item.type=='국회') {
//    	    			$scope.drawRate('result'+index,item.candidates,5);
    	    		}
    	    		
    	    		index++;
    	    	});
    	    	
    	    	
    	    	$scope.candidateLoading = false;
    	    	
    	    	
    	    	
    	    });	        	



    		$http.get("data/zoneCouncils.do?zone="+code)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(council) {
    	    		if(council.type == 'rate'){
        	    		$scope.zoneItems[council.item].rates.push(council);    	    			    	  
    	    		}else if(council.type == 'mrate'){
        	    		$scope.zoneItems[council.item].mrates.push(council);    	    			    	  
    	    		}else if(council.type == 'metro'){
        	    		$scope.zoneItems[council.item].metros.push(council);    	    			    	      	    			
    	    		}else{
        	    		$scope.zoneItems[council.item].councils.push(council);    	    			    	    			
    	    		}
            	});
    	    	
    	    	$scope.loading = false;

    	    	
    	    });

	    });
		

	}

	$scope.search = function(name){
		$scope.history = {};

		$scope.title = name;
		
		
		$http.get("data/search.do?name="+encodeURIComponent(name))
	    .then(function(response) {
			$scope.makeHistory(response.data);
			
			angular.forEach($scope.history,function(history,person){
				$http.get("data/inspection.do?person="+person)
			    .then(function(response) {
					$scope.makeInspection(response.data);
			    });				
			});
	    });
		
	}

	$scope.makeHistory = function(arr){

    	arr.forEach(function(item) {
    		if($scope.history[item.person] == undefined){
    			$scope.history[item.person] = {
    					election:[],inspection:[]};
    		}
    		$scope.history[item.person].election.push(item);
    	});
    	
    	var index = 0;
    	angular.forEach($scope.history,function(history){
    		$scope.drawHistory("history"+index,history.election);
    		index++;
    	});
	}
	
	$scope.makeInspection = function(arr){
    	arr.forEach(function(item) {
    		if($scope.history[item.person] == undefined){
    			$scope.history[item.person] = {
    					election:[],inspection:[]};
    		}
    		$scope.history[item.person].inspection.push(item);
    	});
    	

	}
	
	$scope.setPopover = function(id){
		
		setTimeout(function(){
			$("#"+id).popover({
			    trigger : 'hover',  
			});
		},500);
	}
	
	$scope.setResult= function(result){
		$scope.result = result;
	}
	
	$scope.toggleShow = function(item){
		item.show = !item.show;
	}
	
	$scope.draw = function(id,code){
		
		if(code == null || code == undefined) return;
		code = code+"";
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null ) return;
			var myChart = echarts.init(main);
			 
			
			var arr = code.split(",");
			
			 var geoJson = {features: [],type:"FeatureCollection"};
			 
			 var index = 0;
			 arr.forEach(function(item){
				$http.get("json/"+item+".json")
			    .then(function(response) {
			    	geoJson.features.push(response.data.features[0]);
			    	
			    	
			    	index++;
			    	
			    	if(index>=arr.length){
			    		   echarts.registerMap(code, geoJson);

					        myChart.setOption(option = {
// 					        	graphic: [
// 					        		{
// 					        		    type: 'rect',
// 					        		    shape: {
// 					        		        x: 5,
// 					        		        y: 5,
// 					        		        width: 20,
// 					        		        height:20,
// // 					        		        r:5
// 					        		    },
// 					        		    style:{
// 					        		    	fill:'#373a3c'
// 					        		    }
// 					        		}
// 					        	],
					            series: [
					                {
					                    type: 'map',
					                    mapType: code, // 自定义扩展图表类型
					                    aspectScale:1,
					                    // 自定义名称映射
// 					                    zoom:0.6,
					                    cursor:'default',
					                    itemStyle: {
					                        normal: {
					                            borderColor: '#373a3c',
					                            areaColor: 'silver',
					                            borderWidth: 1
					                        },
					                        emphasis: {
					                            areaColor: 'grey',
					                            borderWidth: 0
					                        }
					                    },
					                }
					            ]
					        });
						
					        
			    	}
			    });
				 
			 });
			
				
		     

			if(code.length > 2){
				$("#"+id).popover({
				    trigger : 'hover',  
				    container: 'body',
				    html: true, 
				    content : '<textarea class="popover-textarea"></textarea>',
				    template: '<div class="popover" style="width:320px;height:300px;"><div class="arrow"></div>'+
				              '<div class="popover-content" id="enlarge'+id+
				              '" style="width:320px;height:300px;background-color: rgb(255, 255, 255);border-top: 5px solid #2780E3;border-bottom: 1px solid silver;border-right: 1px solid silver;">'+
				              '</div></div>' 
				})
				.on('shown.bs.popover', function() {
					  //hide any visible comment-popover
	// 			    $("[rel=comments]").not(this).popover('hide');
					
					var parent = arr[0].substring(0,2);
					  
					var main =document.getElementById("enlarge"+id);
					if(main == null) return;
					var myChart = echarts.init(main);
					 
					$http.get("json/"+parent+".json")
				    .then(function(response) {
				        var parentJson= response.data;        
						 
					        
					        var json = {features: [],type:"FeatureCollection"};
					        json.features[0] = parentJson.features[0];
					        json.features[0].properties.name = 'parent';
					        
					        
					        var option = {
// 					        		 backgroundColor: '#373a3c',
// 					        		 backgroundColor: '#ffffff',
								    visualMap: {
								        min: -100000,
								        max: 600000,
								        show:false,
								        calculable: true,
								        inRange: {
								            color: ['white','#50a3ba', '#eac736', '#d94e5d']
								        }
								    },
					        		 series: [
						                {
						                    type: 'map',
						                    mapType: code, // 自定义扩展图表类型
						                    aspectScale:1,
						                    // 自定义名称映射
						                    cursor:'default',
						                    label: {
						                        normal: {
						                            show: false
						                        },
						                        emphasis: {
						                            show: false
						                        }
						                    },
						                    data:[
						                    	{name:'parent',
						                    	value:-600000,
						                    	itemStyle:{
						                    			borderColor:'#f0f0f0',
						                    			normal:{borderWidth:1,color:'#ffffff'},
						                    			emphasis:{borderWidth:1,areaColor:'rgba(128, 128, 128, 0)'}
						                    	},
						                    	emphasis:{
						                    		itemStyle:{normal:{color:'#000000'}}}}
						                    ],
						                    nameMap: {'parent':'parent'}
						                }
						            ]
						        };
					        
					        var index = 1;
					        arr.forEach(function(item){
						        json.features[index] = geoJson.features[index-1];
						        json.features[index].properties.name = 'child'+index;

						        var c = item;
						        if(item.length>5){
						        	c = item.substring(0,5);
						        }

						        
						        option.series[0].data.push({
						        	name:'child'+index,
						        	value:$scope.zones[c].pop,
						        	itemStyle:{
							        	normal:{
							        		borderWidth:0
										},
					                    emphasis:{
					                    	areaColor:'#f04541'
				                        }
						        	}
						        });
						        option.series[0].nameMap['child'+index] = 'child'+index;
						        
						        index++;
					        });
					        
					        
					        echarts.registerMap(code, json);
					    	
					      
					        
					        
					        
					        myChart.setOption(option);
					        
				        
				        
				        
				        
				        
				    });
					  
				});
			
			}
			
			clearInterval(intvId);
		},50);
		
		
		
	
	}
	
	$scope.hexToRgbA = function(hex,opacity){
	    var c;
	    if(/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)){
	        c= hex.substring(1).split('');
	        if(c.length== 3){
	            c= [c[0], c[0], c[1], c[1], c[2], c[2]];
	        }
	        c= '0x'+c.join('');
	        return 'rgba('+[(c>>16)&255, (c>>8)&255, c&255].join(',')+','+opacity+')';
	    }
	    throw new Error('Bad Hex');
	}
	
	$scope.drawMetroRate = function(id,party,rates){
		
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null ) return;
			var myChart = echarts.init(main);

			 var geoJson = {features: [],type:"FeatureCollection"};

			 var index = 0;

			 var data = [];
			 
			 var max = 0;
			 angular.forEach(rates[party],function(rate){
				 if(max < rate.rate / rate.total){ max = rate.rate / rate.total;}
			 });
			
			 
			angular.forEach(rates[party],function(rate){
				
				var r= rate.rate / rate.total;
				var code = rate.code;
				data.push({
					name:code,
					value :r,
					txt : rate.txt,
					link: rate.link,
					person:rate.person,
					itemStyle:{
		        	normal:{
		        		color:$scope.hexToRgbA($scope.parties[party].color,r/max),
			        	borderColor:$scope.parties[party].color,
	                    shadowColor: 'rgba(0, 0, 0, 0.3)'
	                },
	                 emphasis:{
	                    	areaColor:$scope.hexToRgbA($scope.parties[party].color,r/max),
	                    	label:{
	                    		show:false
	                    	}
                    },
                    label:{
                		show:false
                	}
			      }
				});
				

				var arr = code.split(",");
				
				 var layoutCenter = null;
				 var layoutSize = null;
				 if(data.length == 1){
					layoutCenter = ['20%', '20%'];
					layoutSize = 200;
				}
				 
					$http.get("json/"+code+".json")
				    .then(function(response) {
				    	response.data.features[0].properties.name = code;
				    	geoJson.features.push(response.data.features[0]);
				    	
				    	index++;
				    	
				    	if(index>=rates[party].length){
				    		   echarts.registerMap(id, geoJson);

						        myChart.setOption(option = {
					        		 tooltip: {
					        	            trigger: 'item',
						        	        position:'top',
					        	            formatter:  function (params, ticket, callback) {
					            	        	var value = $filter('number')(params.data.value*100,2);
					            	        	
					            	        	if(params.data.person != 0 && $scope.persons[params.data.person].photo == true){
						            	            return "<img src='portrait/"+params.data.person+".jpg' style='width:30px;height:40px;margin-right:5px;'/>"+params.data.txt+" : "+ value +"%";
					            	        	}else{
						            	            return params.data.txt+" : "+ value +"%";					            	        		
					            	        	}
					            	        },
					            	        extraCssText:'border-radius:0px;'
					        	        },
					        	    grid:{
					        	    	top:'0',
					        	    	left:'0'
					        	    },
						            series: [
						                {
						                    type: 'map',
						                    top:'50',
						                    layoutCenter: layoutCenter,
						                    layoutSize: layoutSize,
						                    mapType: id, // 自定义扩展图表类型
						                    aspectScale:1,
						                    cursor:'default',
						                    itemStyle:{
						                        normal:{label:{show:false}},
						                        emphasis:{label:{show:false},
						                        	shadowColor: 'rgba(0, 0, 0, 0.5)',
						                            shadowBlur: 10}
						                    },						                    
						                    data:data
						                }
						            ]
						        });
						        myChart.off('click');
						        myChart.on('click', function (params) {
			            			$scope.getHistory(params.data.person);
			            			$("#history").modal();
						        });
						        
				    	}
				    });
					 
				
				 
			});
			
			clearInterval(intvId);
		},50);
		
		
		
	
	};
	
	$scope.drawSenateRate = function(id,party,rates){
		
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null ) return;
			
			
			 var max = 0;
			 angular.forEach(rates[party],function(rate){
				 if(max < rate.rate / rate.total){ max = rate.rate / rate.total;}
			 });

			 
			var data = [];
			
			angular.forEach(rates[party],function(rate){
				var r= rate.rate / rate.total;

				var a =r/max;
				if(a<0.2) a= 0.2;
				data.push({
		            'x': rate.x,
		            'y': rate.y,
					v :$filter('number')(r*100,2),
					txt : rate.txt,
					person: rate.person,
					link: rate.link,
					name: rate.name,

					abbreviation: $scope.getWidth()>576?rate.name.substring(0,2):rate.name.substring(0,1),
		            color:$scope.hexToRgbA($scope.parties[party].color,a),
		        });
			});
			
			
			var fontSize = $scope.getWidth()>576?'11px':'5px';
			
			Highcharts.chart(id, {
			    chart: {
			        type: 'tilemap',
			        height: '140%',
			        inverted: true
			    },
				exporting:{
					buttons:{
						contextButton:{
							enabled:false
						}
					}
				},
			    title: {
			        text: '',
			        visible: false
			    },


			    xAxis: {
			        visible: false
			    },

			    yAxis: {
			        visible: false
			    },

			    legend: {
			        enabled: false
			    },

			    tooltip: {
			    	useHTML: true,
			        headerFormat: null,
			        formatter:function(){
			        	if($scope.persons[this.point.person].photo == true){
				        	return "<img src='portrait/"+this.point.person+".jpg' style='width:30px;height:40px;margin-right:5px;'/>"+this.point.txt + " (" +this.point.v+"%)";			    
			        	}else
				        	return this.point.txt + " (" +this.point.v+"%)";
			        }
			    },
			    plotOptions: {
			        series: {
			        	cursor:'pointer',
			        	tileShape:'circle',
			            dataLabels: {
			                enabled: true,
			                format: '{point.abbreviation}',
			                fontSize:fontSize,
			                color: $scope.parties[party].textColor,
			                style: {
			                    textOutline: false
			                }
			            },
			            events:{
			            	click:function(e){
		            			$scope.getHistory(e.point.person)
		            			$("#history").modal();
			            	}			            	
			            }
			        }
			    },

			    series: [{
			        data:data
			    }]
			});

			
			clearInterval(intvId);
		},50);
		
		
		
	
	}
	
	
	$scope.drawItemRate = function(id,type){
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null || angular.equals({}, $scope.items) || $scope.loading == true  || $scope.candidateLoading == true) return;

			if($scope.loadedTime == null) return;
			var now =   new Date().getTime();
			if($scope.loadedTime +500 > now) return;
			
	        var max = 0;
	        angular.forEach($scope.items,function(candidate){
	        	if(candidate.type == '당선' || candidate.type == '낙선'){
	        		candidate.code = parseInt(candidate.code);
		        	max+= candidate.code;
	        	}
	        });


	        var option = {
        	    tooltip : {
        	        trigger: 'item',
//         	        position:'right',
        	        formatter: function (params, ticket, callback) {
        	        	var value = $filter('number')(params.value);
        	            return params.seriesName+" : " + value + " ("+$filter('number')(params.data.percent,2)+"%)";
        	        },
        	        extraCssText:'border-radius:0px;'

        	    },
        	    grid: {
        	        left: '0',
        	        right:'0',
        	        bottom:'0',
        	        top:'0'

        	    },
        	    yAxis:  {
        	    	show:false,
        	    	 splitLine: {
        	                show: false
        	            },
        	            max:max,
        	        type: 'value',
        	        inverse:true
        	    },
        	    xAxis: {
        	    	show:false,
        	        type: 'category',        	       	
        	        data: ['rate']
        	    },
	            series: [
	                
	            ]
	        };
	        
	        	
	        angular.forEach( $scope.items,function(candidate){	        	
	        	if(candidate.type == '당선' || candidate.type == '낙선'){
	        		candidate.percent = candidate.code*100/max;
	        		
	        		var name;
	        		
	        		if(type == 'person'){
	        			name = $scope.persons[candidate.person].name;
	        		}
	        		if(type == 'party'){
	        			name = $scope.parties[candidate.party].name;
	        		}
	        		
		        	option.series.push(
	        			{
	        				name:name,
		                    type: 'bar',
		                    stack:'rate',
		                    label: {
		                        normal: {
		                            show: false
		                        },
		                        emphasis: {
		                            show: false
		                        }
		                    },
		                    cursor:'default',
		                    itemStyle:{
			        			color:$scope.parties[candidate.party].color,
			        		    emphasis: {
			        		        barBorderWidth: 1,
			        		        shadowBlur: 10,
			        		        shadowOffsetX: 0,
			        		        shadowOffsetY: 0,
			        		        shadowColor: 'rgba(0,0,0,0.5)'
			        		    }

			        		},
							data:[{value:candidate.code,percent:candidate.percent}]
		                });
	        	}
	        });
	        
	        setTimeout(function(){
		        var myChart = echarts.init(main);
		        myChart.setOption(option);
	        	
	        },700);
						
			
	        clearInterval(intvId);
		},50);
	
	}
	$scope.drawPie = function(id,candidates){
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null || candidates == null) return;
			if(main == null || angular.equals({}, $scope.items) ) return;
			var myChart = echarts.init(main);

			  var total = 0;
		        var max = 0;
		        angular.forEach($scope.items,function(candidate){
		        	if(candidate.type == '당선' || candidate.type == '낙선'){

			        	candidate.code = parseInt(candidate.code);
			        	total += candidate.code;
			        	if(candidate.code > max){
			        		max = candidate.code;
			        	}
		        	}
		        });

	        var option = {
	        		grid:{
	        			left:'0',
	        			right:'10',
	        			top:'0'

	        		},
	        	    tooltip : {
	        	        trigger: 'item',
	        	        extraCssText:'border-radius:0px;'
// 	        	        formatter: function (params, ticket, callback) {
// 	        	        	var value = $filter('number')(params.value);
// 	        	            return params.name+" : " + value + " ("+params.percent+"%)";
// 	        	        }
	        	    },
	        	    yAxis : [
	        	        {
	        	        	show:false,
	        	            type : 'category',
	        	            data : [],
	        	            axisTick: {
	        	                show:false
	        	            }
	        	        }
	        	    ],
	        	    xAxis : [
	        	        {
	        	        	max:total,
	        	        	show:false,
	        	            type : 'value'
	        	        }
	        	    ],
	        	    legend: {
// 	        	        orient: 'vertical',
// 	        	        x: 'left',
	        	        data:[]
	        	    },
	            series: [
	                {
	                    type: 'bar',
// 	                    hoverAnimation :false,
// 	                    radius: ['35%', '90%'],
// 	                    label: {
// 	                        normal: {
// 	                            show: false
// 	                        },
// 	                        emphasis: {
// 	                            show: false
// 	                        }
// 	                    },
// 	                    silent:true,
	                    cursor:'default',
// 	                    animation:false,
						itemStyle:{
							opacity :0.5
						},
						data:[]
	                }
	            ]
	        };
	        
	      
	        
	        angular.forEach($scope.items,function(candidate){
	        	if(candidate.type == '당선' || candidate.type == '낙선'){
		        	option.series[0].data.push({
		        		value:candidate.code,
		        		name:$scope.persons[candidate.person].name,
		        		itemStyle:{
		        			color:$scope.parties[candidate.party].color,
		        			opacity :'0.5'
		        		}
		        	});
		        	
		        	option.yAxis[0].data.push(
		        		$scope.persons[candidate.person].name
		        	);
		        	
		        	candidate.percent = candidate.code * 100 / total;
		        	
		        	option.legend.data.push($scope.persons[candidate.person].name);
	        	}
	        });
	        
	        myChart.setOption(option);
						
			
	        clearInterval(intvId);
		},50);
	
	}
	
	$scope.drawRate = function(id,candidates,barWidth){
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null || candidates.length==0) return;
			var myChart = echarts.init(main);

			
	        var max = 0;
	        candidates.forEach(function(candidate){
	        	max+= candidate.rate;
	        });


	        var option = {
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: function (params, ticket, callback) {
        	        	var value = $filter('number')(params.value);

        	        	var ret = params.seriesName+" : " + value + " ("+$filter('number')(params.data.percent,2)+"%)";
        	            
        	        	if($scope.persons[params.data.person] !=undefined && $scope.persons[params.data.person].photo == true){
            	            return "<img src='portrait/"+params.data.person+".jpg' style='width:30px;height:40px;margin-right:5px;'/>"+ret;
        	        	}else{
            	            return ret;					            	        		
        	        	}


        	        
        	        },
        	        extraCssText:'border-radius:0px;'
        	    },
        	    grid: {
//         	    	bottom:'0',
        	        left: '0',
        	        right:'0'
        	    },
        	    xAxis:  {
        	    	show:false,
        	    	 splitLine: {
        	                show: false
        	            },
        	            max:max,
        	        type: 'value'
        	    },
        	    yAxis: {
        	    	show:false,
        	        type: 'category',        	       	
        	        data: ['rate']
        	    },
        	    animation : false,
	            series: [
	                
	            ]
	        };
	        
	        	
	        candidates.forEach(function(candidate){	        	
	        	if(candidate.txt == '당선' || candidate.txt == '낙선'){
	        		candidate.percent = candidate.rate*100/max;
		        	option.series.push(
	        			{
	        				name:$scope.persons[candidate.person].name,
		                    type: 'bar',
		                    stack:'rate',
		                    label: {
		                        normal: {
		                            show: false
		                        },
		                        emphasis: {
		                            show: false
		                        }
		                    },
		                    cursor:'default',
		                    itemStyle:{
			        			color:$scope.parties[candidate.party].color,
			        		    emphasis: {
			        		        barBorderWidth: 1,
			        		        shadowBlur: 5,
			        		        shadowOffsetX: 0,
			        		        shadowOffsetY: 0,
			        		        shadowColor: 'rgba(0,0,0,0.5)'
			        		    }
			        		},
			        		barWidth:barWidth,
							data:[{
								value:candidate.rate,
								percent:candidate.rate*100/max,
			                    person:candidate.person
							}]
		                });
	        	}
	        });
	        
	        myChart.setOption(option);
						
			
	        clearInterval(intvId);
		},50);
	
	}
	$scope.drawMember = function(id,candidates,barWidth,rate){
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
			if(main == null || candidates.length==0) return;
			var myChart = echarts.init(main);

			
	        var max = 0;
	        candidates.forEach(function(candidate){
	        	max+= candidate.count;
	        });

	        
	        var formatter = function (params, ticket, callback) {
	        	var value = $filter('number')(params.value);
	            return params.seriesName+" : " + value;
	        };
	        if(rate == true){
		        formatter =   function (params, ticket, callback) {
		        	var value = $filter('number')(params.value);
		            return params.seriesName+" : " + value + " ("+$filter('number')(params.data.percent,2)+"%)";
		        };
	        }


	        var option = {
	        	grid: {
        	        left: '0',
        	        right:'0'
        	    },
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: formatter,
        	        extraCssText:'border-radius:0px;'
        	    },
        	    xAxis:  {
        	    	 splitLine: {
        	                show: false
        	            },
        	            max:max,
        	        type: 'value'
        	    },
        	    yAxis: {
        	    	show:false,
        	        type: 'category',        	       	
        	        data: ['의원수']
        	    },
	            series: [
	                
	            ]
	        };
	        
	        	
	        candidates.forEach(function(candidate){	        	
		        	option.series.push(
	        			{
	        				name:$scope.parties[candidate.party].name,
		                    type: 'bar',
		                    stack:'rate',
		                    label: {
		                        normal: {
		                            show: false
		                        },
		                        emphasis: {
		                            show: false
		                        }
		                    },
		                    cursor:'default',
		                    itemStyle:{
			        			color:$scope.parties[candidate.party].color,
			        		    emphasis: {
			        		        barBorderWidth: 1,
			        		        shadowBlur: 5,
			        		        shadowOffsetX: 0,
			        		        shadowOffsetY: 0,
			        		        shadowColor: 'rgba(0,0,0,0.5)'
			        		    }

			        		},
			        		barWidth:barWidth,
							data:[{value:candidate.count,percent:candidate.count*100/max}]
		                });
	        });
	        
	        myChart.setOption(option);
						
			
	        clearInterval(intvId);
		},50);
	
	}
	
	$scope.drawRatePie = function(param){
		var intvId = setInterval(function(){
			
			var count = 0;
			var main =document.getElementById(param.id);
// 			if(main == null || rates.length==0) return;
			if(main == null || $scope.loading == true){ return};
 			if (param.rates.length==0 && count<100){
 				count++;
				return;
			}

			var myChart = echarts.init(main);


	        var option = {
	        	    tooltip : {
	        	        trigger: 'item',
	        	        position:'top',
	        	        formatter: function (params, ticket, callback) {
	        	        	var value = $filter('number')(params.value);
	        	        	
	        	        	
	        	        	var ret;
	        	        	if(param.showRate==false){ ret = params.name+" : " + value;
	        	        	}else ret=params.name+" : " + value + " ("+params.percent+"%)";
	        	            
            	        	if($scope.persons[params.data.person] !=undefined && $scope.persons[params.data.person].photo == true){
	            	            return "<img src='portrait/"+params.data.person+".jpg' style='width:30px;height:40px;margin-right:5px;'/>"+ret;
            	        	}else{
	            	            return ret;					            	        		
            	        	}

	        	        },
	        	        extraCssText:'border-radius:0px;'
	        	    },
	            series: [
	                {
	                	
	                    type: 'pie',
	                    hoverAnimation :false,
	                    radius: ['40%', '90%'],
	                    label: {
	                        normal: {
	                            show: false
	                        },
	                        emphasis: {
	                            show: false
	                        }
	                    },
// 	                    silent:true,
						animation:false,
	                    cursor:'default',
						data:[]
	                }
	            ]
	        };
	        
	        var rose = false;
	        param.rates.forEach(function(rate){
	        	
	        	if(rate.count !=0 || rate.rate != 0){
		        	var value =rate.count;
		        	var name = $scope.parties[rate.party].name;
		        	if(param.candidate == true){
		        		value = rate.rate;
		        		name = $scope.persons[rate.person].name;
		        	}
		        	
		        	var color = $scope.parties[rate.party].color;
		        	
		        	if(rate.party ==0){
//		        		option.series[0].roseType= 'radius';
		        		rose = true;

		        	}
		        	option.series[0].data.push({
		        		value:value,
		        		name:name,
		        		person:rate.person,
		        		itemStyle:{
		        			color:color,
		        		    emphasis: {
		        		    	borderWidth:0,
		        		        shadowBlur: 10,
		        		        shadowOffsetX: 0,
		        		        shadowOffsetY: 0,
		        		        shadowColor: 'rgba(0,0,0,0.5)'
		        		    }
	
		        		}
		        	});
	        	}
	        });
	        
	        if(rose){
//	        	option.series[0].data = option.series[0].data.sort(function (a, b) { return a.value - b.value; });
	        	option.series[0].itemStyle = {
        			normal:{
        				borderWidth:1,
        		        borderColor: '#e9ecef'
        			}
	        	}
	        }
	        
		        myChart.setOption(option);
	        
						
			
	        clearInterval(intvId);
		},50);
	
	}
	$scope.getCouncilArray = function(councils) {
		
		var ret = [];
		angular.forEach(councils,function(council){
			var i;
			for(i=0;i<council.count;i++){
				ret.push(council.party);
			}			
		});
	    return ret;   
	}
	
	$scope.getCouncilWidth = function(total){
		
		if(total<=16) return 60;
		if(total<=25) return 75;
		if(total<=36) return 90;

		
		var max = $window.innerWidth - 150;
		var width = total*17/6;
		var min = 60;
		if(width<min) return min;
		if(width >= max) return "";
		return width;
	}
	
	$scope.getCouncilPadding=function(total){
		if(total<=20) return 20;
		if(total<=30) return 15;
		return 5;
	}
	
	$scope.drawHistory = function(id,history){
		
		var intvId = setInterval(function(){
			
			var main =document.getElementById(id);
// 			if(main == null || rates.length==0) return;
			if(main == null ) return;

			history = $filter('orderBy')(history,'-date');
			
	        var option = {
	        	    tooltip : {
	        	        trigger: 'item',
	        	        formatter: function (params, ticket, callback) {
	        	        	if(params.componentType == "markPoint") return "";
	        	        	var value = $filter('number')(params.value,2);
	        	            return params.name+" : " + value + "%" ;
	        	        },
	        	        extraCssText:'border-radius:0px;'
	        	    },
	        	    grid: {
	        	    	top:'10',
	        	    	bottom:'10',

	        	    	left: '10',
	        	        right:'10'
	        	    },
	        	    yAxis : [
	        	        {
	        	        	show:false,
	        	            type : 'category',
	        	            axisTick: {
	        	                show:false
	        	            },

	        	            data : []
	        	        }
	        	    ],
	        	    xAxis : [
	        	        {
		        	    	show:false,
	        	            type : 'value'
	        	        }
	        	    ],
	            series: [
	                {
	                    type: 'bar',
	                    cursor:'default',
	                    markPoint: {
	                    	symbolOffset:[0,-30],

	                    	symbol:'circle',
	                    	symbolSize:5,
	                        data: [
	                        ]
	                    },
	                    
						data:[]
	                }
	            ]
	        };
	        
        	var index = 0;

        	var max = 0;
	        history.forEach(function(item){
	        	if(item.rate > 0){
					if(max<(item.rate*100/item.total)){
						max = item.rate*100/item.total;
					}
	        	}
	        });
	        
	        history.forEach(function(item){
	        	if(item.rate > 0){

		        	option.yAxis[0].data.push(item.electionName);
	
		        	var position = 'insideRight';
		        	var color = $scope.parties[item.party].textColor;

		        	if(item.rate*100/item.total < max/10){
		        		position = 'right';
		        		color = $scope.parties[item.party].color;
		        	}
		        	option.series[0].data.push({
		        		value:item.rate*100/item.total,
		        		name:item.electionName,
		        		itemStyle:{
		        			color:$scope.parties[item.party].color,
		        		    emphasis: {
		        		        barBorderWidth: 1,
		        		        shadowBlur: 10,
		        		        shadowOffsetX: 0,
		        		        shadowOffsetY: 0,
		        		        shadowColor: 'rgba(0,0,0,0.5)'
		        		    }
	
		        		},
		        		label: {
	                        normal: {
	                            show: true,
	                            color:color,
	                            position: position,
		                        formatter:function (params, ticket, callback) {
			        	        	var value = $filter('number')(params.value,2);
			        	            return value + "%" ;
			        	        }

	                        }
	                    }
		        	});	        	
	        	}
	        });
	        
	        
	        
	        setTimeout(function(){
				var myChart = echarts.init(main);

		        myChart.setOption(option);
	        	
	        },300);

						
			
	        clearInterval(intvId);
		},50);
	
	}
	
	
	$scope.positiveRate = function(item){
		if(item.rate > 0) return true;
		else return false;
	}
//     $(".modal").modal();
});
</script>

</body>
</html>