<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html >
<html lang="en">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="" />
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/glyphicon.css">

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

  <script type="text/javascript" src="js/Detector.js"></script>
<!--   <script type="text/javascript" src="js/three.min.js"></script> -->
  <script type="text/javascript" src="js/Tween.js"></script>
  <script type="text/javascript" src="js/threeGeoJson.js"></script>

  <script type="text/javascript" src="js/earcut.js"></script>

  <script type="text/javascript" src="js/globe.js"></script>
  <script type="text/javascript" src="js/city.js"></script>

  <script type="text/javascript" src="js/topojson-client.js"></script>
  <script type="text/javascript" src="js/d3-array.min.js"></script>
  <script type="text/javascript" src="js/d3-collection.min.js"></script>
  <script type="text/javascript" src="js/d3-dispatch.min.js"></script>
  <script type="text/javascript" src="js/d3-request.js"></script>
  <script type="text/javascript" src="js/d3-timer.min.js"></script>



<style>
 html {
        height: 100%;
      }
body { 
	margin: 0;
	overflow-y:hidden;
    overflow-x: hidden;
}
//	canvas { width: 100%; height: 100% }

.others .operate{display:none;}

#currentInfo {
   width: 300px;
   position: absolute;
   left: 20px;
   top: 0px;

   background-color: rgba(0,0,0,0.2);

   border-top: 1px solid rgba(255,255,255,0.4);
   padding: 10px;
   height:99%;
 }
 
 #currentInfo .list-group{
	 height: 100%;
    overflow-y: auto;
 }

 .year {
   font: 16px Georgia;
   line-height: 26px;
   height: 30px;
   text-align: center;
   float: left;
   width: 90px;
   color: rgba(255, 255, 255, 0.4);

   cursor: pointer;
   -webkit-transition: all 0.1s ease-out;
 }

 .year:hover, .year.active {
   font-size: 23px;
   color: #fff;
 }
 
 .row+.row {
	margin-top: 0.2rem;
}


.btn-xs, .btn-group-xs > .btn {
    padding: 0.2rem 0.38rem;
    font-size: 0.7203125rem;
    line-height: 1.5;
    border-radius: 0;
}

.mt-10 {
  margin-top: 10px !important;
}

.ml--5{
  margin-left: -5px !important;

}
.text-label {
    font-family: "Segoe UI", "Source Sans Pro", Calibri, Candara, Arial, sans-serif;
  color: #fff;
  margin: 10px 0 0 -50px;
  pointer-events:none;
   text-shadow: 1px 1px #000000;
	width:100px;
	
	text-align:center;
	line-height:12px;
}

.text-detail{
	 font-family: "Segoe UI", "Source Sans Pro", Calibri, Candara, Arial, sans-serif;
	// background-color: rgba(0,0,0,0.5);
	z-index:10;
	  color: #fff;
  margin: -50px 0 0 15px;
	
	
	padding:10px;
	border:1px solid #111111;
}
.text-hide{
	visibility: hidden;	 
}
.label-top{
 	margin: -25px 0 0 -50px;
}

</style>


</head>
<body>

	<script src="js/three.js"></script>

	<div ng-app="myApp" class="wrapper" ng-controller="myCtrl"
		style="overflow-x: hidden;">
		
		<div id="container"></div>
		  <div id="currentInfo">
		  	<div class="form-check">
		  		<input type="checkbox" class="form-check-input"  ng-model="showUnuse" ng-click="changeShowUnuse()">
		  	</div>
		  	<span ng-hide="newGame">
			  	<button class="btn btn-sm" ng-hide="timer==null" ng-click="pause()" title="Pause"><span class="glyphicon glyphicon-pause"></span></button>
			  	<button class="btn btn-sm" ng-show="timer==null" ng-click="play()"  title="Resume"><span class="glyphicon glyphicon-play"></span></button>
		  	</span>
		  	<br/>

			<div class="list-group">
			  <a href="#" class="list-group-item" ng-class="{'active':scenario.id==selectedScenario.id}" ng-repeat="scenario in scenarios | filter:{yn:true}| orderBy:'-year'" ng-click="selectScenario(scenario)">{{scenario.name}}</a>
			</div>

		  </div>


		<div class="modal fade" id="city" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title"><input ng-model="selected.name" ng-change="changeSnapshot(selected)"/> </h4>
						<h5 class="modal-title">
							 <table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
							 	<tr>
							 		<td ng-repeat="col in selected.nameImage" style="text-align:center;padding:0px;line-height:10px;">
										 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{selected.name}}" style="max-width: 70%; max-height: 70%;margin:0px;"
										 	ng-class="{'ml--5':$index==1}">
										 <br ng-if="$index==0" ng-repeat-end/>
							 		</td>
							 	</tr>
							 </table>
						</h5>
						<h5 class="modal-title" style="margin-left:3px;">
							 <strong><small class="text-secondary" title="{{selected.name}}">{{selected.originalName}}</small></strong>
							 <span style="">
								<span class="badge ng-binding" ng-style="{'color':'white','background-color': factions[selected.faction].color}" title="Faction">
									{{factions[selected.faction].name}}
								</span>
								
								
								<small class="text-muted" title="Population"> <small><span class="glyphicon glyphicon-user"> </span></small> {{selected.population|number}}</small>
								<small class="text-muted" title="Loyalty"> <small><span class="glyphicon glyphicon-heart"> </span></small> {{selected.loyalty|number:0}}</small>
							</span>

						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" ng-class="{'others':selected.faction!=faction.id}">
						<div id="city-body" class="carousel slide" data-interval="false">
							<div class="carousel-inner">
							    <div class="carousel-item active">
									<div class="container">
										<div class="row">
											<div class="col-sm">
												{{selected.cityName}}<br/>
												<input ng-model="factionName"/>	
												<select ng-change="changeSnapshot(selected)" ng-model="selected.faction" 
													ng-options="faction.id as faction.name for faction in factions | toArray:false  | filter : {'name':factionName}">
												</select> 
											
												<input ng-change="changeCity(selected)" ng-model="selected.cityType"/>
												<select ng-change="changeCity(selected)" ng-model="selected.labelPosition"><option>bottom</option><option>top</option></select>
												<input ng-change="changeCity(selected)" ng-model="selected.latitude"/> <input ng-change="changeCity(selected)" ng-model="selected.longitude"/>
											</div>
										</div>
										<div class="row">
											<div class="col-sm">	
												 <div class="form-check">
													 <input type="checkbox" class="form-check-input" id="useCheck" ng-model="selected.yn" ng-click="setUse(selected)">
													  <label class="form-check-label" for="useCheck">Use</label>
													  
													  {{selected.id}} {{selected.snapshot}} {{selected.year}}  
													<button class="btn btn-primary btn-xs" ng-show="selected.year != selectedScenario.year" ng-click="addSnapshot(selected)">Add</button>

												  </div>

												<span class="glyphicon glyphicon-bookmark text-primary" title="{{trait.name}}" ng-repeat="trait in selected.traits"> </span>		
											</div>
										</div>	
										<div class="row">
											<div class="col-sm">    												
												<button class="btn btn-primary btn-xs" ng-click="addHero(selected)">Add Hero</button>
											</div>
										</div>
										<div class="row" ng-repeat="sub in selected.heroes">
											<div class="col-sm">    
												<input ng-model="sub.heroName"/>
												<select ng-change="changeScenarioCitySub(sub)" ng-model="sub.hero" ng-options="hero.id as hero.name for hero in heroes | toArray:false  | filter : {'name':sub.heroName} "></select> 
													{{sub.hero}}
													<span class="badge badge-danger" title="Valor">
														{{heroes[sub.hero].valor}}
													</span>
										  			<span class="badge badge-primary"  title="Wisdom">
														{{heroes[sub.hero].wisdom}}
													</span>
										  			<span class="badge badge-warning"  title="Authority">
														{{heroes[sub.hero].authority}}
													</span>
													<img ng-src="{{heroes[sub.hero].portrait}}" style="height: 100px;"/>
												<button class="btn btn-primary btn-xs" ng-click="removeScenarioCitySub(sub)">Remove</button>

											</div>
										</div>
										<div class="row">
											<div class="col-sm-6">							    
												<span class="text-muted"><span class="glyphicon glyphicon-record" title="Silver"> </span> <span title="Silver">{{selected.silver|number}}</span> </span>
												<span class="text-muted"><span class="glyphicon glyphicon-apple" title="Food"> </span> <span title="Food">{{selected.food|number}}</span> </span>
										    	<span class="text-muted"><span class="glyphicon glyphicon-tower" title="Wall"> </span> <span title="Wall">{{selected.buildings.wall.amount*100000/selected.population|number:0}}%</span> </span>

											</div>
											<div class="col-sm">	    
												<div class="d-flex justify-content-between">
													<div>

													</div>
													<div>
														<button class="btn btn-primary btn-xs" title="Heroes" href="#city-body"  data-slide="next" ng-click="stat='heroes';" ng-show="(selected.heroes|toArray).length>0">
															<span class="glyphicon glyphicon-star"></span></button>
														<button class="btn btn-primary btn-xs" title="Special Buildings" href="#city-body"  data-slide="next" ng-click="stat='unique';">
															<span class="glyphicon glyphicon-home"></span></button>

													</div>
												</div>
											</div>

								    	</div>
								    	<div class="row">
											<div class="col-sm">	    
												<div ng-repeat="destiny in selected.destinies">
												{{destiny.road.id}} {{destiny.road.destinies[0].city.name}} - {{destiny.road.destinies[1].city.name}} 
												
												<select ng-model="destiny.road.type" ng-change="changeRoad(destiny.road)"><option>normal</option><option>water</option><option>high</option></select>
												<input ng-model="destiny.road.waypoint" ng-change="changeRoad(destiny.road)"/>
												<button class="btn btn-primary btn-xs" ng-click="removeRoad(destiny)">Remove</button>
												<button class="btn btn-primary btn-xs" ng-click="addUnit(destiny)">Add Unit</button>
												</div>
												<input ng-model="cityName"/>
												<select ng-model="cityId"
													ng-options="city.id as city.name for city in cities  | toArray:false  | filter : {'name':cityName}">
												</select>
												
												<button class="btn btn-primary btn-xs"  ng-click="addRoad(selected,cityId)">Add Road</button>												
											</div>
								    	</div>
								    	<hr/>
										<div class="row">
											<div class="col-sm">		
								    			<span class="text-muted"><span class="glyphicon glyphicon-user" title="Potential Mans"> </span> <span title="Potential Mans">{{selected.mans|number}}</span> </span>
								    		</div>
								    	</div>
										<div class="row">
											<div class="col-sm-3">
									

												<span class="text-muted"><span class="glyphicon glyphicon-pawn" title="Recruited"> </span> <span title="Garrison">{{selected.garrison|number}}</span> </span>
											</div>
											<div class="col-sm">

<!-- 												<span ng-show="selected.faction == faction.id"> -->
												<span>
													<button class="btn btn-primary btn-sm" title="Cancel Recruiting" ng-show="selected.recruiting > 0" ng-click="cancelRecruit(selected)"><span class="glyphicon glyphicon-remove"></span></button>			
													<button class="btn btn-primary btn-sm" title="Recruit" href="#city-body" ng-hide="selected.recruiting > 0" ng-disabled="selected.checkRecruit('soldier') " data-slide="next" ng-click="stat='recruit';recruited=selected.getRecruitMax();recruitType='soldier'"><span class="glyphicon glyphicon-plus"></span></button>
													<button class="btn btn-primary btn-sm" title="Dismiss" href="#city-body" ng-disabled="selected.garrison<=0 " data-slide="next" ng-click="stat='dismiss';dismissed=selected.garrison;recruitType='soldier';"><span class="glyphicon glyphicon-minus"></span></button>			
													<button class="btn btn-primary btn-sm" title="Organize" href="#city-body" data-slide="next" ng-click="stat='organize';"><span class="glyphicon glyphicon-pawn"></span></button>
													<button class="btn btn-primary btn-sm" title="Muster" href="#city-body" ng-disabled="selected.garrison<50 " data-slide="next" ng-click="stat='muster';mustered = selected.garrison;"><span class="glyphicon glyphicon-bell"></span></button>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-3">
							    	
										    	<span class="text-muted"><span class="glyphicon glyphicon-wrench" title="Workers"> </span> <span title="Idle Workers">{{selected.idle|number}}</span> / <span title="Workers">{{selected.workers|number}}</span></span>
											</div>
											<div class="col-sm">

<!-- 												<span ng-show="selected.faction == faction.id"> -->
												<span>
													<button class="btn btn-primary btn-sm" title="Construct" href="#city-body" data-slide="next" ng-click="stat='build';"><span class="glyphicon glyphicon-wrench"></span></button>
													<button class="btn btn-primary btn-sm" title="Assign" href="#city-body" data-slide="next" ng-click="stat='assign';"><span class="glyphicon glyphicon-log-in"></span></button>
													<button class="btn btn-primary btn-sm" title="Make" href="#city-body" data-slide="next" ng-click="stat='make';"><span class="glyphicon glyphicon-cog"></span></button>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-3">							    	
										    	<span class="text-muted"><span class="glyphicon glyphicon-star" title="Heroes"> </span> <span title="Heroes">{{(selected.heroes|toArray).length|number}}</span> </span>
											</div>
											<div class="col-sm">

												<span ng-show="selected.faction == faction.id">
													<button class="btn btn-primary btn-sm" title="Relocate" href="#city-body" data-slide="next" ng-click="stat='relocate';">
														<span class="glyphicon glyphicon-plane"></span></button>
												</span>
											</div>
										</div>
										<div ng-show="newGame && selected.faction>0" class="d-flex justify-content-between">
											<div>
											</div>
											<div>
												<button class="btn btn-primary btn-sm" title="Choose This Faction"  ng-click="selectFaction(selected)"><span class="glyphicon glyphicon-ok"></span></button>
											</div>
										</div>
																			
									</div>

							    </div>
							    <div class="carousel-item">
								 
						    		<div class="d-flex justify-content-between"">
							    		 <div>
							    		 	<form class="form-inline">
									    		<div class="form-group">
												    <button class="btn btn-primary btn-sm mb-2 mr-sm-2" title="Prev" href="#city-body" data-slide="prev" ng-click="selected.initMustering()"><span class="glyphicon glyphicon-chevron-left"></span></button>
													<span  ng-show="stat=='recruit'">
													    <input class="form-control mb-2 mr-sm-2" type="number" max="{{selected.getRecruitMax()}}" min="0" ng-model="recruited"></input>								    
													    <button class="btn btn-primary btn-sm mb-2"  href="#city-body" data-slide="prev" title="Reruit" ng-click="recruit(selected,recruited,recruitType);" ng-disabled="recruited== undefined || recruited==0">
													    	<span class="glyphicon glyphicon-ok"></span>
													    </button>
												    </span>										    
													<span  ng-show="stat=='dismiss'">
													    <input class="form-control mb-2 mr-sm-2" type="number" max="{{selected.idle}}" min="1" ng-model="dismissed"></input>								    
													    <button class="btn btn-primary btn-sm mb-2"  href="#city-body" data-slide="prev" title="Dismiss" ng-click="dismiss(selected,recruitType,dismissed);" ng-disabled="dismissed== undefined || dismissed==0">
													    	<span class="glyphicon glyphicon-ok"></span>
													    </button>
												    </span>	
										    	</div>
										    </form>
								        </div>
								        <div>
									

											<span  ng-show="stat=='muster'">
												<button class="btn btn-primary btn-sm mb-2" data-dismiss="modal" title="Muster" ng-click="muster(selected,0,true);" 
											    	ng-disabled="selected.checkMuster()">
											    	<span class="glyphicon glyphicon-ok"></span>
											    </button>

										    </span>										    

																			    
										    
										    
										    <span class="text-muted" ng-show="stat=='build'" >
												<span class="text-muted"><span class="glyphicon glyphicon-record" title="Silver"> </span> <span title="Silver"> {{selected.silver|number}} </span> </span>
										    	<span class="glyphicon glyphicon-wrench" title="Workers"> </span> <span title="Idle Workers"> {{selected.idle|number}}</span>/<span title="Total Workers">{{selected.workers|number}}</span>
										    	<span class="glyphicon glyphicon-th" title="Building space"> </span> <span title="Total building space">{{selected.totalBuildingSize|number}}</span>/<span title="Max building space">{{selected.maxBuildingSize|number:0}} </span>
										    </span>
										    <span class="text-muted" ng-show="stat=='assign'" >
										    	<span class="glyphicon glyphicon-wrench" title="Workers"> </span> <span title="Idle Workers"> {{selected.idle|number}}</span>/<span title="Total Workers">{{selected.workers|number}}</span>										    
										    </span>
										    <span class="text-muted" ng-show="stat=='make'" >
												<span class="text-muted"><span class="glyphicon glyphicon-record" title="Silver"> </span> <span title="Silver"> {{selected.silver|number}} </span> </span>
										    	<span class="glyphicon glyphicon-pawn" title="Armoury"> </span> <span title="Used Space"> {{selected.usedArmoury|number}}</span>/<span title="Total Space">{{selected.armoury|number}}</span>	 
										    	<span class="glyphicon glyphicon-knight" title="Stables"> </span> <span title="Used Space"> {{selected.usedStable|number}}</span>/<span title="Total Space">{{selected.stable|number}}</span>	 

										    </span>
										    <span class="text-muted" ng-show="stat=='organize'" >
										    	<span class="glyphicon glyphicon-pawn" title="Soldiers"> </span> <span title="Unassigned"> {{selected.militia|number}}</span>/<span title="Garrison">{{selected.garrison|number}}</span>
										    </span>
										    
										    <button class="btn btn-primary btn-sm mb-2 mr-sm-2" ng-show="stat=='relocate'" title="Next" href="#city-body" data-slide="next" 
										    	ng-disabled="(selected.mustering.heroes|toArray|filter:{selected:true}).length==0">
										    	<span class="glyphicon glyphicon-chevron-right"></span></button>
										    
								    	 </div>
									</div>
									<div ng-show="stat=='road'">
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="city in cities" ng-if="city.yn" ng-click="addRoad(selected,city)">
												  		{{city.name}}
													</li>
												</ul>
											</div>
										</div>										
									</div>
									<div ng-show="stat=='heroes'">
											
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="hero in selected.heroes">
												  		<span>
													  		{{heroes[hero.id].name}}																			  		
													  		<span title="{{heroes[hero.id].name}}">
														  		{{heroes[hero.id].originalName}}																			  		
													  		</span>
													  		<table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
															 	<tr>
															 		<td ng-repeat="col in heroes[hero.id].nameImage" style="text-align:center;padding:0px;line-height:8px;">
																		 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{heroes[hero.id].name}}" 
																		 	ng-class="{'ml--5':$index==1}" style="max-width: 60%; max-height: 60%;margin:0px;">
																		 <br ng-if="$index==0" ng-repeat-end/>
															 		</td>
															 	</tr>
															 </table>


												  			<span class="badge badge-danger" title="Valor">
																{{heroes[hero.id].valor}}
															</span>
												  			<span class="badge badge-primary"  title="Wisdom">
																{{heroes[hero.id].wisdom}}
															</span>
												  			<span class="badge badge-warning"  title="Authority">
																{{heroes[hero.id].authority}}
															</span>

																			  		
													  		<span  ng-repeat="sub in heroes[hero.id].sub" ng-if="sub.type=='trait'" > 
													  			<a ng-href=""
													  			class="popover-trigger"
																id="heroTrait{{$parent.$parent.$index}}{{$index}}" data-html="true"
																data-toggle="popover"
																data-content=" {{traits[sub.value].description}}"
																title="{{traits[sub.value].name}}"
																ng-init=""
																data-placement="bottom"> 
																
																<span class="glyphicon glyphicon-bookmark text-primary"></span> 
							
															</a>
															</span>												  														  		

												  		</span>
												  		<span>
															<span class="glyphicon glyphicon-bell text-primary" title="Dispatched" ng-if="hero.state=='departed'"></span>					
												  		</span>
												  		
												  	</li>
												</ul>
										   	</div>
										   								    
									    </div>
								    </div>
									<div ng-show="stat=='governer'">
											
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="hero in selected.heroes"
												  		ng-if="hero.id != selected.governer">
												  		<span>
													  		{{heroes[hero.id].name}}																			  		
													  		<span title="{{heroes[hero.id].name}}">
														  		{{heroes[hero.id].originalName}}																			  		
													  		</span>
													  		<table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
															 	<tr>
															 		<td ng-repeat="col in heroes[hero.id].nameImage" style="text-align:center;padding:0px;line-height:8px;">
																		 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{heroes[hero.id].name}}" 
																		 	ng-class="{'ml--5':$index==1}" style="max-width: 60%; max-height: 60%;margin:0px;">
																		 <br ng-if="$index==0" ng-repeat-end/>
															 		</td>
															 	</tr>
															 </table>


												  			<span class="badge badge-danger" title="Valor">
																{{heroes[hero.id].valor}}
															</span>
												  			<span class="badge badge-primary"  title="Wisdom">
																{{heroes[hero.id].wisdom}}
															</span>
												  			<span class="badge badge-warning"  title="Authority">
																{{heroes[hero.id].authority}}
															</span>

												  		</span>
												  		<span>
																			  		
													  		<span  ng-repeat="sub in heroes[hero.id].sub" ng-if="sub.type=='trait'" > 
													  			<a ng-href=""
													  			class="popover-trigger"
																id="heroTrait{{$parent.$parent.$index}}{{$index}}" data-html="true"
																data-toggle="popover"
																data-content=" {{traits[sub.value].description}}"
																title="{{traits[sub.value].name}}"
																ng-init=""
																data-placement="bottom"> 
																
																<span class="glyphicon glyphicon-bookmark text-primary"></span> 
							
															</a>
															</span>
															<button class="btn btn-sm btn-primary"  title="Appoint" ng-click="selected.governer=hero.id"  href="#city-body" data-slide="prev">
													  			<span class="glyphicon glyphicon-ok"></span>
													  		</button>												  														  		
												  		</span>
												  		
												  	</li>
												</ul>
										   	</div>
										   								    
									    </div>
								    </div>

									<div ng-show="stat=='unique'">
											
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, building) in selected.buildings" title="{{buildings[type].description}}"
												  		ng-if="buildings[type].category=='unique' && building.amount > 0">
												  		<span>
													  		{{buildings[type].name}}
													  		<span title="{{buildings[type].name}}">{{buildings[type].originalName}}</span>
												  		
													  		<table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
															 	<tr>
															 		<td ng-repeat="col in buildings[type].nameImage" style="text-align:center;padding:0px;line-height:8px;">
																		 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{buildings[type].name}}" 
																		 	ng-class="{'ml--5':$index==1}" style="max-width: 60%; max-height: 60%;margin:0px;">
																		 <br ng-if="$index==0" ng-repeat-end/>
															 		</td>
															 	</tr>
															 </table>
																			  		
												  		</span>
												  		
												  	</li>
												</ul>
										   	</div>
										   								    
									    </div>
								    </div>
		
									<div ng-show="stat=='build'">
									    <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="nav nav-pills">
													  <li class="nav-item" ng-repeat="category in buildingCategory" ng-click="selectBuildingCategory(category);" title="{{category.name}}">
													    <a class="nav-link" ng-class="{'active':$first}" data-toggle="tab" href="#"><span class="glyphicon {{category.icon}}" > </span></a>
													  </li>
												</ul>
											</div>
										</div>
											
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, building) in selected.buildings" title="{{buildings[type].description}}"
												  		ng-if="selectedCategory==buildings[type].group">
												  		<span>
													  		{{buildings[type].name}}
													  		<span title="{{buildings[type].name}}">{{buildings[type].originalName}}</span>
													  		<table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
															 	<tr>
															 		<td ng-repeat="col in buildings[type].nameImage" style="text-align:center;padding:0px;line-height:8px;">
																		 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{buildings[type].name}}" 
																		 	ng-class="{'ml--5':$index==1}"
																		 	style="max-width: 60%; max-height: 60%;margin:0px;">
																		 <br ng-if="$index==0" ng-repeat-end/>
															 		</td>
															 	</tr>
															 </table>
													  		
													  		
												  		</span>
												  		<span>
													  		<span title="Maintenance {{buildings[type].maintenance*building.amount}} Silver, Total space {{buildings[type].size*building.amount}}">{{building.amount|number:0}}</span> 
													  		<span ng-show="building.jobs.length>0"> +{{building.jobs.length}}</span>
													  		<button class="btn btn-primary btn-sm" title="Cancel"  ng-show="building.jobs.length>0" ng-click="cancelBuild(selected,type);"><span class="glyphicon glyphicon-remove"></span></button>
													  		<button class="btn btn-primary btn-sm" title="{{buildings[type].silver}} Silver {{buildings[type].builders}} Workers {{building.delay/3}} Days {{buildings[type].size}} Space required"
													  			 ng-disabled="checkBuilding(selected,type) "  ng-hide="buildings[type].category=='unique' && (building.amount >=1 || building.jobs.length>0)" ng-click="build(selected,type);">
													  			<span class="glyphicon glyphicon-plus"></span>
													  		</button>
												  		</span>
												  	</li>
												</ul>
										   	</div>
										   								    
									    </div>
								    </div>
									 <div class="row" ng-show="stat=='assign'">
								    
								    	<div class="col-sm">
								    	
									    	<ul class="list-group">
											  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, building) in selected.buildings " ng-if="building.amount>0&&buildings[type].workers>0" title="{{buildings[type].description}}">
											  		{{buildings[type].name}} 
											  		
											  		<span>
												  		<span title="Assigned Workers">{{building.workers|number:0}}/</span><span title="Required Workers">{{buildings[type].workers*building.amount}}</span> 
												  		<button class="btn btn-primary btn-sm" title="Unassign"  ng-show="building.workers>0" ng-click="unassign(selected,type);"><span class="glyphicon glyphicon-log-out"></span></button>
												  		<button class="btn btn-primary btn-sm" title="Assign" ng-show="building.workers<buildings[type].workers*building.amount"
												  			 ng-disabled="selected.idle == 0 "  ng-click="assign(selected,type);">
												  			<span class="glyphicon glyphicon-log-in"></span>
												  		</button>
											  		</span>
											  	</li>
											</ul>
									   	</div>
									   								    
								    </div>
									 <div class="row" ng-show="stat=='make'">
								    
								    	<div class="col-sm">
								    	
								    		<div  ng-repeat="(type, building) in selected.buildings" class="row mt-10"  ng-if="(buildings[type].sub | filter:{'type':'craft'}).length>0 && building.amount>0">
												<div class="col-sm">
												
													  {{buildings[type].name}} 
												  	<span class="text-muted"><span class="glyphicon glyphicon-wrench" title="Assigned Workers"> </span> <span title="Assigned Workers"> {{building.workers|number}}</span></span>
									    	
											    	<ul class="list-group">
													  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="item in buildings[type].sub" ng-if="item.type=='craft'">
													  		<span >{{weapons[item.value].name}}</span> 
													  		<span>
														  		<span title="">{{selected.weapons[item.value].amount|number:0}}</span> 
														  		<span ng-show="selected.weapons[item.value].making>0"> +{{selected.weapons[item.value].making}}</span>
														  		<button class="btn btn-primary btn-sm" 
														  			title="Make {{weapons[item.value].unit}} Cost {{weapons[item.value].cost*weapons[item.value].unit}} Silvers {{weapons[item.value].delay/(3*building.workers)| number:0}} Days" 
														  			ng-click="make(selected,building,item.value)" 
														  			ng-disabled="selected.checkMake(building,item.value) ">
														  			<span class="glyphicon glyphicon-cog"></span>
														  		</button>
													  		</span>
													  	</li>
													</ul>
												</div>
											</div>
									   	</div>
									   								    
								    </div>
								     <div class="row" ng-show="stat=='organize'">
								    
								    	<div class="col-sm">
								    	
									    	<ul class="list-group">
											  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, soldierClass) in soldierClasses ">
											  		
											  		
											  		<span>
											  		{{soldierClass.name}} 
											  		
												  		
												  		<span ng-repeat="sub in soldierClass.sub" ng-if="sub.type=='weapon' && selected.soldierClasses[type].garrison>0"> 
												  			<span class="glyphicon glyphicon-alert " ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
												  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.weapons[sub.value].amount}} / {{selected.soldierClasses[type].garrison}}" 
												  				ng-if="selected.soldierClasses[type].garrison > selected.weapons[sub.value].amount"> </span> 
												  			<span class="glyphicon glyphicon-ok" ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
												  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.weapons[sub.value].amount}} / {{selected.soldierClasses[type].garrison}}"
												  				ng-if="selected.soldierClasses[type].garrison <= selected.weapons[sub.value].amount"> </span> 
												  		</span> 
											  		</span>
											  		
											  		<span>											  			
											  			<button class="btn btn-primary btn-sm" title="Unassign  {{soldierClass.unit}}"  
											  				ng-show="type=='worker'?selected.idle>0:selected.soldierClasses[type].garrison>0" 
												  			ng-click="selected.unassignClass(type,stat)"  >
												  				<span class="glyphicon glyphicon-minus"></span>
												  		</button>
											  		
											  			<span ng-if="type=='worker'" title="Idle Worker">{{selected.idle}} / </span>
											  			{{selected.soldierClasses[type].garrison}}
												  		<button class="btn btn-primary btn-sm" title="Assign {{soldierClass.unit}}" 
												  			 ng-disabled="!(selected.militia >= 0)"  
												  			 ng-click="selected.assignClass(type,stat)">
												  			<span class="glyphicon glyphicon-plus"></span>
												  		</button>
											  		</span>
											  	</li>
											</ul>
									   	</div>
									   								    
								    </div>
								    <div ng-show="stat=='muster'">
								    	<div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="nav nav-pills">
													<li class="nav-item" title="Main">
													   <a class="nav-link active" data-toggle="tab" href="#main"><span class="glyphicon glyphicon-pawn" > </span></a>
													</li>
													<li class="nav-item" title="Heroes">
													   <a class="nav-link" data-toggle="tab" href="#heroes"><span class="glyphicon glyphicon-star" > </span></a>
													</li>

												</ul>
											</div>
										</div>
								    	<div id="myTabContent" class=" row tab-content">
  											<div class="col-sm tab-pane fade active show" id="main">
										    	<div class=" row">
													<div class="col-sm">							    
														<div class=" d-flex justify-content-between">
															<div >
																<span class="text-muted" title="Capacity"><span class="glyphicon glyphicon-th" > </span> {{selected.mustering.capacity}}</span>
															</div>
															<div>
															
																<span class="text-muted"><span class="glyphicon glyphicon-record" title="Silver"> </span> </span>
																<button class="btn btn-secondary btn-xs" title="-100" ng-disabled="selected.mustering.silver<=0" ng-click="selected.subMusterSilver(100)">
																	<span class="glyphicon glyphicon-minus"></span>
																</button>
																<span  title="Silver">{{selected.mustering.silver}}</span>
																<button class="btn btn-secondary btn-xs" title="+100" 
																	ng-disabled="selected.mustering.silver>=selected.silver || selected.mustering.silver+100>selected.mustering.capacity" 
																	ng-click="selected.addMusterSilver(100)">
																	<span class="glyphicon glyphicon-plus"></span>
																</button>
																										
																<span class="text-muted"><span class="glyphicon glyphicon-apple" title="Food"> </span> </span>
																<span  title="Food">{{selected.mustering.food}}</span>
				
				
																<small class="text-muted">{{selected.mustering.days | number:0}} Days</small>
															</div>
														</div>
		
													</div>
		
												</div>
													
											  <div class="row" >										    
										    	<div class="col-sm">										    	
											    	<ul class="list-group">
													  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, soldierClass) in soldierClasses" 
													  		ng-if="selected.soldierClasses[type].garrison>0 || selected.mustering.soldierClasses[type].amount >0">													  													  		
													  		<span>
														  		{{soldierClass.name}} 														  		
														  		<span ng-repeat="sub in soldierClass.sub" ng-if="sub.type=='weapon' && selected.mustering.soldierClasses[type].amount>0"> 
														  			<span class="glyphicon glyphicon-alert " ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
														  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.mustering.soldierClasses[type].weapons[sub.value].amount}} / {{selected.mustering.soldierClasses[type].amount}}" 
														  				ng-if="selected.mustering.soldierClasses[type].amount > selected.weapons[sub.value].amount"> </span> 
														  			<span class="glyphicon glyphicon-ok" ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
														  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.mustering.soldierClasses[type].weapons[sub.value].amount}} / {{selected.mustering.soldierClasses[type].amount}}"
														  				ng-if="selected.mustering.soldierClasses[type].amount <= selected.weapons[sub.value].amount"> </span> 
														  		</span> 														  		
													  		</span>
													  		
													  		<span>											  			
													  			<button class="btn btn-primary btn-sm" title="Undo  {{soldierClass.unit}}"  ng-show="selected.mustering.soldierClasses[type].amount>0" 
														  			ng-click="selected.unassignClass(type)">
														  				<span class="glyphicon glyphicon-minus"></span>
														  		</button>
													  		
													  			<span title="Muster">{{selected.mustering.soldierClasses[type].amount==undefined?0:selected.mustering.soldierClasses[type].amount}}</span> / 
													  			<span title="Garrison">{{type=='worker'?selected.idle:selected.soldierClasses[type].garrison}}</span>
														  		<button class="btn btn-primary btn-sm" title="Muster {{soldierClass.unit}}" 
														  			 ng-disabled="checkClassMuster(selected,type)" 
														  			 ng-click="selected.assignClass(type)">
														  			<span class="glyphicon glyphicon-plus"></span>
														  		</button>
													  		</span>
													  	</li>													  																						  	
													</ul>
																			
											   		</div>
											   </div>	

  											</div>
  											<div class="col-sm tab-pane fade" id="heroes">
  												<ul class="list-group">
												  	<li style="cursor: pointer;" class="list-group-item d-flex justify-content-between align-items-center" 
												  		ng-class="{'list-group-item-primary':selected.mustering.heroes[hero.id].selected}" 
												  		ng-repeat="hero in selected.heroes" 
												  		ng-if="hero.state=='garrisoned'"
												  		ng-click="selected.mustering.heroes[hero.id].selected = selected.mustering.heroes[hero.id]==undefined?true:!selected.mustering.heroes[hero.id].selected;">
												  		<span>
													  		{{heroes[hero.id].name}}																			  		
													  		<span title="{{heroes[hero.id].name}}">
														  		{{heroes[hero.id].originalName}}																			  		
													  		</span>

												  			<span class="badge badge-danger" title="Valor">
																{{heroes[hero.id].valor}}
															</span>
												  			<span class="badge badge-primary"  title="Wisdom">
																{{heroes[hero.id].wisdom}}
															</span>
												  			<span class="badge badge-warning"  title="Authority">
																{{heroes[hero.id].authority}}
															</span>

												  		</span>
												  		<span>
																			  		
													  		<span  ng-repeat="sub in heroes[hero.id].sub" ng-if="sub.type=='trait'" > 
													  			<a ng-href=""
													  			class="popover-trigger"
																id="musterHeroTrait{{$parent.$parent.$index}}{{$index}}" data-html="true"
																data-toggle="popover"
																data-content=" {{traits[sub.value].description}}"
																title="{{traits[sub.value].name}}"
																ng-init=""
																data-placement="bottom"> 
																	<span 
																	class="glyphicon glyphicon-bookmark text-primary"></span> 
							
															</a>
															</span>
												  		
												  		
												  		</span>
												  		
												  	</li>
												</ul>
  											</div>
											
  										</div>
								    
									   
									   
											
																    
								    </div>
								    
								    <div  ng-show="stat=='relocate'">
								    
								   		<ul class="list-group">
										  	<li style="cursor: pointer;" class="list-group-item d-flex justify-content-between align-items-center" 
										  		ng-class="{'list-group-item-primary':selected.mustering.heroes[hero.id].selected}" 
										  		ng-repeat="hero in selected.heroes" 
										  		ng-if="hero.state=='garrisoned'"
										  		ng-click="selected.mustering.heroes[hero.id].selected = selected.mustering.heroes[hero.id]==undefined?true:!selected.mustering.heroes[hero.id].selected;">
										  		<span>
											  		{{heroes[hero.id].name}}																			  		
											  		<span title="{{heroes[hero.id].name}}">
												  		{{heroes[hero.id].originalName}}																			  		
											  		</span>

										  			<span class="badge badge-danger" title="Valor">
														{{heroes[hero.id].valor}}
													</span>
										  			<span class="badge badge-primary"  title="Wisdom">
														{{heroes[hero.id].wisdom}}
													</span>
										  			<span class="badge badge-warning"  title="Authority">
														{{heroes[hero.id].authority}}
													</span>

										  		</span>
										  		<span>
																	  		
											  		<span  ng-repeat="sub in heroes[hero.id].sub" ng-if="sub.type=='trait'" > 
											  			<a ng-href=""
											  			class="popover-trigger"
														id="musterHeroTrait{{$parent.$parent.$index}}{{$index}}" data-html="true"
														data-toggle="popover"
														data-content=" {{traits[sub.value].description}}"
														title="{{traits[sub.value].name}}"
														ng-init=""
														data-placement="bottom"> 
															<span 
															class="glyphicon glyphicon-bookmark text-primary"></span> 
					
													</a>
													</span>
										  		
										  		
										  		</span>
										  		
										  	</li>
										</ul>
										
									</div>
											
											
							    </div>
							   <div class="carousel-item">
							   		<div class="d-flex justify-content-between"">
							    		 <div>
											 <button class="btn btn-primary btn-sm mb-2 mr-sm-2" title="Prev" href="#city-body" data-slide="prev" ><span class="glyphicon glyphicon-chevron-left"></span></button>
										</div>												
							    		 <div>
										</div>												

							   		</div>
									<ul class="list-group">
									  	<li style="cursor: pointer;" class="list-group-item d-flex justify-content-between align-items-center" 
									  		ng-repeat="city in faction.cities" 
									  		ng-if="city.id != selected.id"
									  		ng-click=""
									  		data-target="#city-body" data-slide-to="0">
									  		{{city.name}}
									  	</li>
									  </ul>
										  
						    	</div>
						  </div>
						</div>
					</div>

				</div>
			</div>
		</div>
		
		
		
		
		<div class="modal fade" id="force" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title"><input ng-model="selected.name" ng-change="changeUnit(selected)"/> 
								<span class="badge ng-binding" ng-style="{'color':'white','background-color': factions[selected.faction].color}">
									{{factions[selected.faction].name}}
								</span>
								<small class="text-muted" title="Population"> <small><span class="glyphicon glyphicon-user"> </span></small> <input ng-model="selected.population" ng-change="changeUnit(selected)"/></small>
								<small class="text-muted" title="Morale"> <small><span class="glyphicon glyphicon-heart"> </span></small> {{selected.morale|number:0}}</small>
						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="force-body" class="carousel slide" data-interval="false">
							<div class="carousel-inner">
							    <div class="carousel-item active">

						    		<div class="row">
										<div class="col-sm-12">							    
										    <input ng-model="factionName"/>	
											<select ng-change="changeUnit(selected)" ng-model="selected.faction" 
												ng-options="faction.id as faction.name for faction in factions | toArray:false  | filter : {'name':factionName}">
											</select> 
											<button class="btn btn-primary btn-sm"  
												  			ng-click="removeUnit(selected)"  >
											Remove	  				
											</button>


							    		</div>
							    	</div>
							    
						    		<div class="row">
										<div class="col-sm-3">							    
											<span class="text-muted"><span class="glyphicon glyphicon-record" title="Silver"> </span> <span title="Silver">{{selected.silver|number}}</span> </span>
										</div>
										<div class="col-sm">
										
											<span class="text-muted"><span class="glyphicon glyphicon-apple" title="Food"> </span> <span title="Food">{{selected.food|number:0}}</span>  <small>{{selected.food*10/selected.soldiers|number:0}} Days</small> </span>
										</div>
									</div>
							    
							    	 <div class="row" >								    
								    	<div class="col-sm">
									    	<span ng-show="selected.faction == faction.id">
												<button class="btn btn-primary btn-sm" ng-show="selected.origin.id==selected.position.id"  title="Break Up" data-dismiss="modal"  ng-click="breakUp(selected)"><span class="glyphicon glyphicon-home"></span></button>
												<button class="btn btn-primary btn-sm" ng-hide="selected.annexing" title="Move" href="#force-body"  data-slide="next" ng-click="stat='move';"><span class="glyphicon glyphicon-road"></span></button>
												<button class="btn btn-primary btn-sm" ng-hide="selected.state!='move'" title="Pause"  ng-click="selected.state='pause'"><span class="glyphicon glyphicon-pause"></span></button>
												<button class="btn btn-primary btn-sm" ng-hide="selected.state!='pause'" title="Resume"  ng-click="selected.state='move'"><span class="glyphicon glyphicon-play"></span></button>
												<button class="btn btn-primary btn-sm" title="Cancel Annexing" ng-show="selected.annexing" ng-click="cancelAnnex(selected)"><span class="glyphicon glyphicon-remove"></span></button>
												<button class="btn btn-primary btn-sm" ng-hide="checkAnnex(selected) || selected.annexing" title="Annex"  ng-click="annex(selected)"><span class="glyphicon glyphicon-flag"></span></button>
												<button class="btn btn-primary btn-sm" ng-show="selected.faction==selected.position.faction"  title="Get Supply"   ng-click="getSupply(selected)"><span class="glyphicon glyphicon-apple"></span></button>
												<button class="btn btn-primary btn-sm" ng-show="checkAssistBuild(selected)"  title="Construct"   href="#force-body" data-slide="next" ng-click="stat='build';"><span class="glyphicon glyphicon-wrench"></span></button>

											</span>
										</div>
									</div>
									<div class="row" ng-show="selected.heroes.length>0">								    
								    	<div class="col-sm">																
											<span class="text-muted"><span class="glyphicon glyphicon-star" title="Heroes"> </span></span>
								    	
									    	<ul class="list-group">
											  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="hero in selected.heroes">
											  		<span>
												  		{{heroes[hero.id].name}}																			  		
												  		<span title="{{heroes[hero.id].name}}">
													  		{{heroes[hero.id].originalName}}																			  		
												  		</span>

											  			<span class="badge badge-danger" title="Valor">
															{{heroes[hero.id].valor}}
														</span>
											  			<span class="badge badge-primary"  title="Wisdom">
															{{heroes[hero.id].wisdom}}
														</span>
											  			<span class="badge badge-warning"  title="Authority">
															{{heroes[hero.id].authority}}
														</span>

											  		</span>
											  		<span>
																		  		
												  		<span  ng-repeat="sub in heroes[hero.id].sub" ng-if="sub.type=='trait'" > 
												  			<a ng-href=""
												  			class="popover-trigger"
															id="forceHeroTrait{{$parent.$parent.$index}}{{$index}}" data-html="true"
															data-toggle="popover"
															data-content=" {{traits[sub.value].description}}"
															title="{{traits[sub.value].name}}"
															ng-init=""
															data-placement="bottom"> 
															
																<span class="glyphicon glyphicon-bookmark text-primary"></span> 
						
															</a>
														</span>												  														  		
											  		</span>
											  		
											  	</li>
											</ul>
									   	</div>
									   								    
								    </div>
									<div class="row" >								    
								    	<div class="col-sm">								
											<span class="text-muted"><span class="glyphicon glyphicon-pawn" title="Soldiers"> </span></span>
									    
								    	
								    	
									    	<ul class="list-group">
											  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, soldierClass) in soldierClasses" 
											  		ng-if="selected.soldierClasses[type].muster>0">
											  													  		
											  		<span>
												  		{{soldierClass.name}} 
												  														  		
												  		
												  		<span ng-repeat="sub in soldierClass.sub" ng-if="sub.type=='weapon' && selected.soldierClasses[type].muster>0"> 
												  			<span class="glyphicon glyphicon-alert " ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
												  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.soldierClasses[type].weapons[sub.value].amount}} / {{selected.soldierClasses[type].muster}}" 
												  				ng-if="selected.soldierClasses[type].weapons[sub.value].amount < selected.soldierClasses[type].muster"> </span> 
												  			<span class="glyphicon glyphicon-ok" ng-class="{'text-primary':sub.value1=='primary','text-muted':sub.value1!='primary'}" 
												  				title="{{sub.value1=='primary'?'Primary':'Optional'}} Equipment : {{weapons[sub.value].name}} {{selected.soldierClasses[type].weapons[sub.value].amount}} / {{selected.soldierClasses[type].muster}}"
												  				ng-if="selected.soldierClasses[type].weapons[sub.value].amount >= selected.soldierClasses[type].muster"> </span> 
												  		</span> 
												  		
											  		</span>
											  		
											  		<span>											  			
											  			
											  			<span >{{selected.soldierClasses[type].muster}}</span>
											  		</span>
											  	</li>
											  	
																			  	
											</ul>
										
											
									   		</div>
									   </div>	
									   
							    </div>
							    <div class="carousel-item">
									<button class="btn btn-primary btn-sm mb-2 mr-sm-2" title="Prev" href="#force-body" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></button>

									<div ng-show="stat=='move'">
								    	<div class="list-group">
										  	<a href="#" class="list-group-item" ng-repeat="destiny in selected.position.destinies" ng-click="move(selected,destiny.city,destiny.road)" data-dismiss="modal" >{{destiny.city.name}}</a>
										</div>
									</div>
									<div ng-show="stat=='build'">

										<div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="nav nav-pills">
													  <li class="nav-item" ng-repeat="category in buildingCategory" ng-click="selectBuildingCategory(category);" title="{{category.name}}">
													    <a class="nav-link" ng-class="{'active':$first}" data-toggle="tab" href="#"><span class="glyphicon {{category.icon}}" > </span></a>
													  </li>
												</ul>
											</div>
										</div>
											
									     <div class="row" >
									    
									    	<div class="col-sm">
									    	
										    	<ul class="list-group">
												  	<li class="list-group-item d-flex justify-content-between align-items-center" ng-repeat="(type, building) in selected.position.buildings" title="{{buildings[type].description}}"
												  		ng-if="selectedCategory==buildings[type].group">
												  		<span>
													  		{{buildings[type].name}}
													  		<span title="{{buildings[type].name}}">{{buildings[type].originalName}}</span>
													  		<table style="display:inline-block;margin-left:3px;    border-spacing: 0;">
															 	<tr>
															 		<td ng-repeat="col in buildings[type].nameImage" style="text-align:center;padding:0px;line-height:8px;">
																		 <img ng-repeat-start="image in col track by $index" ng-src="{{image}}" title="{{buildings[type].name}}" 
																		 	ng-class="{'ml--5':$index==1}"
																		 	style="max-width: 60%; max-height: 60%;margin:0px;">
																		 <br ng-if="$index==0" ng-repeat-end/>
															 		</td>
															 	</tr>
															 </table>
													  		
													  		
												  		</span>
												  		<span>
													  		<span title="Maintenance {{buildings[type].maintenance*building.amount}} Silver, Total space {{buildings[type].size*building.amount}}">{{building.amount|number:0}}</span> 
													  		<span ng-show="building.jobs.length>0"> +{{building.jobs.length}}</span>
													  		<button class="btn btn-primary btn-sm" title="Cancel"  ng-show="building.jobs.length>0&&selected.building==type" ng-click="cancelBuild(selected.position,type,selected);"><span class="glyphicon glyphicon-remove"></span></button>
													  		<button class="btn btn-primary btn-sm" title="{{buildings[type].silver}} Silver {{buildings[type].builders}} Workers {{building.delay/3}} Days {{buildings[type].size}} Space required"
													  			 ng-disabled="checkBuilding(selected.position,type,selected) "  ng-hide="buildings[type].category=='unique' && (building.amount >=1 || building.jobs.length>0)" ng-click="build(selected.position,type,selected);">
													  			<span class="glyphicon glyphicon-plus"></span>
													  		</button>
												  		</span>
												  	</li>
												</ul>
										   	</div>
										   								    
									    </div>
									</div>

							    </div>
							    <div class="carousel-item">
						    	</div>
						  </div>
						</div>
					</div>

				</div>
			</div>
		</div>


		<div class="modal fade" id="multi" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							Select Object
						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					
						<div class="list-group">
						  <a href="#" class="list-group-item" ng-repeat="object in clicked" ng-click="select(object)" data-dismiss="modal" data-toggle="modal" data-target="{{object.type=='force'?'#force':'#city'}}">{{object.name}}</a>
						</div>
						
					</div>

				</div>
			</div>
		</div>

		<div class="modal fade" id="start" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							New Game
						</h5>
					</div>
					<div class="modal-body">
						Select your faction
						<div class="list-group">
						  <a href="#" class="list-group-item" ng-repeat="faction in factions" ng-click="start(faction);" data-dismiss="modal">{{faction.name}}</a>
						</div>
						
					</div>

				</div>
			</div>
		</div>
		
		<div class="modal fade" id="scenario" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							Select Scenario
						</h5>
					</div>
					<div class="modal-body">
						<div class="list-group">
						  <a href="#" class="list-group-item" ng-repeat="scenario in scenarios" ng-click="selectScenario(scenario)">{{scenario.name}}</a>
						</div>
						
					</div>

				</div>
			</div>
		</div>
		
	</div>

	<script>

	
 window.mobileAndTabletcheck = function() {
  var check = false;
  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
  return check;
};

var movingSpeed = 0.1;

class Building {

  constructor(amount,proto) {
    this.amount = Math.floor(amount);
    this.proto = proto;
    this.jobs = [];
    this.makeJobs = [];
    this.delay = this.proto.delay;
    this.workers = 0;
    this.sub = [];
  }

}

class Weapon {

  constructor(amount,proto) {
    this.amount = Math.floor(amount);
    
    this.making = 0;
    this.proto = proto;
    this.delay = this.proto.delay;
  }
}

class SoldierClass{
	
	constructor(city,type){
		
		this.city = city;
		this.scope = city.scope;
		this.amount = 0;
		this.weapons = {};
		this.type;
		
		this.data = this.scope.soldierClasses[type];
	}
	
	assignClass(type,garrison){
		
		var self = this;
		
		var add = Math.min(garrison - this.amount,this.data.unit);
		this.amount += add;		
		
		this.data.sub.forEach(function(sub){
			if(sub.type=='weapon'){

				if(self.weapons[sub.value] == undefined){
					self.weapons[sub.value] = {amount:0} 
				}

				var amount = Math.min( self.city.weapons[sub.value].amount - self.weapons[sub.value].amount,self.data.unit);
				//self.weapons[sub.value].amount -= amount;
				
				self.weapons[sub.value].amount += amount;
				
			}
		});
	}
	
	unassignClass(type){
		
		var self = this;
		
		var sub = Math.min(this.amount,this.data.unit);
		this.amount -= sub;

		this.data.sub.forEach(function(sub){
			if(sub.type=='weapon'){
				
				if(self.weapons[sub.value].amount > self.amount){
					var amount =  self.weapons[sub.value].amount - self.amount;
					self.weapons[sub.value].amount = self.amount;			
				}
				
			}
		});

	}
}

class Mustering {
	
	constructor(city){
		
		this.city = city;
		this.scope = city.scope;
		this.food = 0;
		this.silver = 0;
		this.days = 0;
		this.capacity=0;
		this.usedCapaicty =0;
		this.soldierClasses = {};
		this.heroes = {};
		
 	}
	
	
	assignClass(type,garrison){
		
		var self = this;
				
		if(this.soldierClasses[type] == undefined){
			this.soldierClasses[type] = new SoldierClass(this.city,type);
		}
		
		this.soldierClasses[type].assignClass(type,garrison);
		
		this.calculateMuster();
	}

	unassignClass(type){

		
		this.soldierClasses[type].unassignClass(type);
		
		
		this.calculateMuster();	
	}
	
	
	calculateMuster(){
		var self = this;
		
		this.capacity = 0;
		
		angular.forEach(this.soldierClasses,function(soldierClass){
			
			self.capacity += soldierClass.amount;

			angular.forEach(soldierClass.weapons,function(weapon,type){
				self.scope.weapons[type].sub.forEach(function(sub){
					if(sub.type == 'capacity'){
						self.capacity += parseInt(sub.value) * weapon.amount;
					}
				});
			});
			
		});
		
		
		this.food = Math.min(this.city.food,self.capacity - self.silver);
		this.days = this.food*10 / this.getMusterSoldiers();
		
	}

	getMusterSoldiers(){
		var amount = 0;
		angular.forEach(this.soldierClasses,function(soldierClass){
			amount += soldierClass.amount;
		})
		
		return amount;
	}

}


var app = angular.module('myApp', ['angular-toArrayFilter','ui.bootstrap']);
app.controller('myCtrl', function($scope,$http,$filter,$window,$sce,$interval) {


	var roads;
	
	$scope.cities = {};
	$scope.stat='default';

	$scope.showUnuse = false;
	
	$scope.factions = {0:{name:'None',id:0}};
	$scope.buildings = {};
	$scope.weapons = {};
	$scope.traits = {};
	$scope.soldierClasses = {};
	$scope.heroes={};
	$scope.buildingCategory = [{
		name:'Capacity',
		id:'capacity',
		icon:'glyphicon-th'
	},{
		name:'Resource',
		id:'resource',
		icon:'glyphicon-apple'
	},{
		name:'Production',
		id:'production',
		icon:'glyphicon-cog'
	},{
		name:'Religion',
		id:'religion',
		icon:'glyphicon-bishop'
	},{
		name:'Etc',
		id:'etc',
		icon:'glyphicon-wrench'
	}];
	
	$scope.selectedCategory = 'capacity';
	
	$scope.$watchCollection('selected', function(n, o) {
		if(n!=undefined){
			$scope.setPopover();						
		}
	});
	
	$scope.jobs = [];
	
	 var lines = [{
		start:'Uruk',
		end: 'Ur'
	 }]
	 
	 var objectMap = {};
	 var objects =[];
	 var forceMap = {};
	 
	 var citiesArray = Object.values($scope.cities);
	 var cityMap = {};
	 var snapshotMap = {};
	 var roadMap = {};
	 
	 var globe = DAT.Globe(document.getElementById('container'), {
		 colorFn:function(label) {
		    return new THREE.Color([
		      0xd9d9d9, 0xb6b4b5, 0x9966cc, 0x15adff, 0x3e66a3,
		      0x216288, 0xff7e7e, 0xff1f13, 0xc0120b, 0x5a1301, 0xffcc02,
		      0xedb113, 0x9fce66, 0x0c9a39,
		      0xfe9872, 0x7f3f98, 0xf26522, 0x2bb673, 0xd7df23,
		      0xe6b23a, 0x7ed3f7][label]);
		  },  
	 	onClick: function(event,camera,scene){
	 		 
	 		var mouse = new THREE.Vector2();
			  
			  mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
			  mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
			  
	 		getSelected(mouse,camera,scene,function(clicked,selected){
	 			 $('#city-body').carousel(0);
	 			 $('#force-body').carousel(0);

	 			if(clicked.length==1){
	 				$scope.selected =selected;
	 				
	 				if($scope.selected != undefined){

						if($scope.selected.type=='city'){
			 			 $('#city').modal();
						}else{
				 			 $('#force').modal();												
						}
			 			 
			 			 
			 			 
			 			 $scope.$apply();
	 				}
	 				
	 			} else{
	 				 $('#multi').modal();
	 				 
	 				$scope.$apply();
	 			}
	 			
	 		});
	 	  },
	 	  
	 	 onMouseover : function(mouse,camera,scene){
	 		var ret = getSelected(mouse,camera,scene,function(clicked,selected){
	 			globe.detail(selected,$filter);
	 		});
	 		if(ret == false){
	 			globe.detail();
	 		}
	 	 }
			
	 });
	 
	 
	 function getSelected(mouse,camera,scene,callback){
		 
		  
		  var raycaster = new THREE.Raycaster();
		  raycaster.setFromCamera( mouse, camera );
		  
		  var intersects = raycaster.intersectObjects( objects );
		
		 $scope.clicked = [];
	//	 console.log(intersects.length);
		 intersects.forEach( function(intersect){
		 	if(objectMap[intersect.object.id] != undefined){
		 		$scope.clicked.push(objectMap[intersect.object.id]);
		 	}
		 });
		 
		 
		 if($scope.clicked.length>0){
			 
			 callback($scope.clicked,objectMap[intersects[0].object.id]);
			 
			 return true;
		 }
		 
		 return false;
	 }

	 var lineCoord = [];
	 
		var data = [];
		
		
	$scope.addRoad = function(selected,city){
		$http.post("data/road.do",{
			start:selected.id,
			end:city,
			scenario:$scope.selectedScenario.id
		}).then(function(response) {
	//    	$scope.addScenarioRoad();
//	    	$("#scenario").modal();
	    });
	}


	$scope.removeRoad = function(destiny){
		$http.delete("data/scenario/road.do?id="+destiny.road.id).then(function(response) {
	//    	$scope.addScenarioRoad();
//	    	$("#scenario").modal();
	    });
	}
	
	$scope.addUnit = function(destiny){
		$http.post("data/unit.do",
			{
				road:destiny.road.road,
				scenario:$scope.selectedScenario.id
			}).then(function(response) {
	//    	$scope.addScenarioRoad();
//	    	$("#scenario").modal();
	    });
	}
	
	$scope.removeUnit = function(selected){
		$http.delete("data/unit.do?id="+selected.id).then(function(response) {
		});		
	}
	
	$scope.selectFaction = function(selected){
		
		$scope.faction=$scope.factions[selected.faction];
		$scope.newGame=false;
		//$scope.play();
		
	}	
	
	$scope.getScenario = function(){
		$http.get("data/scenario.do")
	    .then(function(response) {
	    	
	    	$scope.scenarios = response.data;
	    	
	    	$scope.selectScenario($scope.scenarios[0]);
	    	
//	    	$("#scenario").modal();
	    });
		
	}
	
	$scope.setUse = function(selected){

		$http.put("data/use.do",{
			scenario:selected.scenario,
			id:selected.id,
			yn:selected.yn
		}).then(function(){
			
		});
		
	}
	
	$scope.changeSnapshot = function(selected){
		$http.put("data/snapshot.do",{
			faction:selected.faction,
			snapshot:selected.snapshot,
			year:selected.year,
			population:selected.population,
			name:selected.name
		}).then(function(){
			
		})		
	}

	$scope.changeUnit = function(selected){
		$http.put("data/unit.do",{
			id:selected.id,
			name:selected.name,
			faction:selected.faction,
			population:selected.population
		}).then(function(){
			
		})		
	}

	
	$scope.changeCity = function(selected){
		$http.put("data/city.do",{
			id:selected.id,
			longitude:selected.longitude,
			latitude:selected.latitude,
			type:selected.cityType,
			labelPosition:selected.labelPosition
		}).then(function(){
			
		})		
	}

	$scope.changeRoad = function(road){
		$http.put("data/road.do",{
			id:road.road,
			waypoint:road.waypoint,
			type:road.type
		}).then(function(){
			
		})		
	}

	
	$scope.changeSnapshotSub = function(sub){
		$http.put("data/snapshot/sub.do",{
			id:sub.id,
			type:sub.type,
			value:sub.value
		}).then(function(){
			
		})		
	}

	$scope.changeScenarioCitySub = function(sub){
		
		if(sub.hero == 0 || sub.hero == null) return;

		$http.put("data/scenario/city/sub.do",{
			id:sub.id,
			hero:sub.hero
		}).then(function(){
			
		})		
	}

	
	$scope.removeSnapshotSub = function(sub){
		$http.delete("data/snapshot/sub.do?id="+sub.id,{
			id:sub.id,
			type:sub.type,
			value:sub.value
		}).then(function(){
			
		})		
	}

	
	$scope.removeScenarioCitySub = function(sub){
		$http.delete("data/scenario/city/sub.do?id="+sub.id,{
			id:sub.id,
			type:sub.type,
			value:sub.value
		}).then(function(){
			
		})		
	}
	
	$scope.addSnapshot = function(selected){
		$http.post("data/snapshot.do",{
			id:selected.id,
			population:selected.population,
			year:$scope.selectedScenario.year,
			name:selected.name
		}).then(function(){
			
		})		
	}

	$scope.addSnapshotSub = function(selected){
		$http.post("data/snapshot/sub.do",{
			snapshot:selected.snapshot
		}).then(function(){
			
		})		
	}
	
	$scope.addHero = function(selected){
		$http.post("data/scenario/hero.do",{
			scenario:$scope.selectedScenario.id,
			city:selected.id
		}).then(function(){
			
		})		
	}
	
	
	$scope.getScenarioCitySub = function(){
		$http.get("data/scenario/city/sub.do?scenario="+$scope.selectedScenario.id)
	    .then(function(response) {
	    	
	    	var list = response.data;
			angular.forEach(list,function(sub){

				var city = cityMap[sub.city];
				if(city !=undefined){
					 city.heroes.push(sub);
				}
			
			});

	    });
		
	}


	
	$scope.changeShowUnuse = function(){
		 $scope.addData($scope.selectedScenario);
	}
	
	$scope.getSnapshot = function(){
		
			$http.get("data/scenarioSnapshot.do")
		    .then(function(response) {
		    	
		    	list = response.data;
		    	data = [];
			 	angular.forEach(list,function(city){
			 		
			 		var c = new City(city,$scope);
			 		
			 		$scope.cities[city.id] = c;
			 		
			 		
			 		data.push(c)
			 		
			 		cityMap[city.id] = c;
			 		snapshotMap[city.snapshot] = c;
			 		
			 		if($scope.factions[city.faction] != undefined && city.faction != 0){			 			
			 			$scope.factions[city.faction].cities.push(c);
			 		}
//					data = data.concat([city.latitude,city.longitude,city.population,city.faction]);
			 	});
			 	
		       window.data = data;
		       globe.addData(data, {format: 'legend'});
		       
		       data.forEach(function(city){
		    	   objectMap[city.object.id] = city;
		       });
		       
		       
		       
		    //   globe.createPoints();

			  	citiesArray = Object.values($scope.cities);

			  	
			  	$scope.getCitySubs();
			  	$scope.getSnapshotSubs();
			  	$scope.getRoad();
			  	
			  	
			  	 
		    });
	};
	
	$scope.getRoad = function(scenario){
		$http.get("data/road.do?scenario="+scenario)
	    .then(function(response) {
	    	
	    	roadMap = {};
	    	
	    	var lines = response.data;
			angular.forEach(lines,function(line){
				
				roadMap[line.road] = line;
		 	});
			
			
			$scope.getRoadSubs ();
		 	$scope.getUnit();
	    	
	    });
		
	}
	
	$scope.getRoadSubs = function(){
		$http.get("data/road/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				var road = roadMap[sub.road];
				if(sub.type == 'waypoint'){
				//	road.
				}
		 	});
			
			
	    	lineCoord = [];
			angular.forEach(roadMap,function(line){
				
				if(line.waypoint != ""){
					var a = 0;
				}
				if($scope.cities[line.start] != undefined && $scope.cities[line.end] != undefined){

					if($scope.cities[line.start].yn && $scope.cities[line.end].yn){
//						line.type ='road';
						line.destinies = [{road:line,city:$scope.cities[line.start]},{road:line,city:$scope.cities[line.end]}];
						line.forces = [];
						
						$scope.cities[line.start].destinies.push({road:line,city:$scope.cities[line.end]});
						$scope.cities[line.end].destinies.push({road:line,city:$scope.cities[line.start]});

						lineCoord.push({start:$scope.cities[line.start],end:$scope.cities[line.end],waypoint:line.waypoint,type:line.type});
						
					}
				}
		 	});
			
			roads = globe.addLines(lineCoord);

	    	
	    });		
	}

	
	$scope.getUnit = function(scenario){
		$http.get("data/unit.do?scenario="+$scope.selectedScenario.id)
	    .then(function(response) {
	    	
	    	response.data.forEach(function(unit){
	    		
	    		var line = roadMap[unit.road];
	    		
	    		if(line !=undefined){
	    		
					if($scope.cities[line.start] != undefined && $scope.cities[line.end] != undefined){
	
						if($scope.cities[line.start].yn && $scope.cities[line.end].yn){
	//						line.forces = [];
							
							var latitude;
							var longitude;
							
							if(line.waypoint != "" && line.waypoint != null){
	
								var waypoint = JSON.parse(line.waypoint);
								var half = Math.floor(waypoint.length/2);
								var point = waypoint[half];
								latitude = point[1];
								longitude = point[0];
								
							}else{
								latitude = ($scope.cities[line.start].latitude + $scope.cities[line.end].latitude)/2;
								longitude = ($scope.cities[line.start].longitude + $scope.cities[line.end].longitude)/2;
														
									
								
							}
	
							
							var object = globe.addUnit(latitude,longitude,unit.population,$scope.factions[unit.faction].color);
							objectMap[object.id] = unit;
							unit.object = object;
					    	objects.push(object);
					    	
					    	unit.factionData = $scope.factions[unit.faction];

							
						}
					}
				
	    		}

				
	    	});
	    	
	    });
		
	}

	
	
	
	$scope.getFaction = function(){
		$http.get("data/faction.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(faction){
				
				faction.cities = [];
				faction.forces = [];
				faction.targeted = [];
				
				$scope.factions[faction.id] = faction;
		 	});
			
//			$scope.getSnapshot();
	    	
	    });
		
	}
	
	
	$scope.getBuildings = function(){
		$http.get("data/building.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(building){
				
				building.sub = [];
				building.nameImage = {};
				$scope.buildings[building.type] = building;
		 	});
			
			$scope.getBuildingSubs();
	    	
	    });
		
	}
	
	$scope.getHeroes = function(){
		
		$scope.heroes = {};
		
		$http.get("data/hero.do?year="+$scope.selectedScenario.year)
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(hero){
				
				hero.sub = [];
				hero.nameImage = {};
				$scope.heroes[hero.id] = hero;
		 	});
			
//			$scope.getHeroSubs();
	    	
	    });
		
	}
	
	$scope.getHeroSubs = function(){
		$http.get("data/hero/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
								
				var hero= $scope.heroes[sub.hero];
				
				if(sub.type == 'name'){
					if(hero.nameImage[sub.value1] == undefined){
						hero.nameImage[sub.value1] = [];
					}
					hero.nameImage[sub.value1].push(sub.value);
				}else if(sub.type == 'city'){
					
				}else{
					hero.sub.push(sub);
				}
		 	});
	    	
	    });		
	}


	
	$scope.getWeapons = function(){
		$http.get("data/weapon.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(weapon){
				
				weapon.sub = [];
				$scope.weapons[weapon.type] = weapon;
		 	});
			
			$scope.getWeaponSub();
	    	
	    });
		
	}
	
	
	$scope.getWeaponSub = function(){
		$http.get("data/weapon/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				$scope.weapons[sub.weapon].sub.push(sub);
		 	});
	    	
	    });
		
	}

	$scope.getSoldierClass = function(){
		$http.get("data/soldierClass.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(soldierClass){
				
				soldierClass.sub = [];
				$scope.soldierClasses[soldierClass.type] = soldierClass;
				
		 	});
	    	
			$scope.getSoldierClassSub();
	    });
		
	}
	
	$scope.getSoldierClassSub = function(){
		$http.get("data/soldierClassSub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				$scope.soldierClasses[sub.soldier].sub.push(sub);
		 	});
	    	
	    });
		
	}


	$scope.getTraits = function(){
		$http.get("data/trait.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(trait){
				
				$scope.traits[trait.type] = trait;
		 	});
	    	
	    });		
	}
	
	$scope.getCitySubs = function(){
		$http.get("data/city/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				var city = cityMap[sub.city];
				if(sub.type == 'building'){
//					city.traits.push($scope.traits[sub.value]);
					city.buildings[sub.value1] = new Building(parseInt(sub.value2),$scope.buildings[sub.value1]);
					city.calculateBuildingBonus();
				}
				if(sub.type == 'name'){
					if(city.nameImage[sub.value2] == undefined){
						city.nameImage[sub.value2] = [];
					}
					city.nameImage[sub.value2].push(sub.value1);
				}
				
//				$scope.traits[trait.type] = trait;
		 	});
	    	
	    });		
	}

	$scope.getSnapshotSubs = function(){
		$http.get("data/snapshot/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				var city = snapshotMap[sub.snapshot];
				if(city !=undefined){
					city.sub.push(sub);
					
					if(sub.type == 'governer'){
						sub.value = parseInt(sub.value);

						city.governer = sub.value;
					}
				}
		 	});
	    	
	    });		
	}

	
	$scope.getBuildingSubs = function(){
		$http.get("data/building/sub.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(sub){
				
				var building = $scope.buildings[sub.building];
				if(sub.type=='name'){
					if(building.nameImage[sub.value1] == undefined){
						building.nameImage[sub.value1] = [];
					}
					building.nameImage[sub.value1].push(sub.value);
					
				}else{
					building.sub.push(sub);
				}
				
//				$scope.traits[trait.type] = trait;
		 	});
	    	
	    });		
	}

	
	$scope.selectScenario = function(scenario){
		$scope.selectedScenario=scenario;
		
		$scope.cities = {};
		
		cityMap = {};
		snapshotMap = {};
		$scope.cities = {};
		
		$http.get("data/allScenarioSnapshot.do?scenario="+scenario.id)
	    .then(function(response) {
	    	
	    	list = response.data;
	    	data = [];
		 	angular.forEach(list,function(city){
		 		
		 		var c = new City(city,$scope);
		 		
		 		$scope.cities[city.id] = c;
		 		
		 		
		 		data.push(c)
		 		
		 		cityMap[city.id] = c;
		 		snapshotMap[city.snapshot] = c;
		 		
		 		if($scope.factions[city.faction] != undefined && city.faction != 0){
		 			$scope.factions[city.faction].cities.push(c);
		 		}
//				data = data.concat([city.latitude,city.longitude,city.population,city.faction]);
		 	});
		 	
	       window.data = data;
	       
	       
	       
	       
	       $scope.addData(scenario);
	       
	       
	       
	//       globe.createPoints();

		  	citiesArray = Object.values($scope.cities);

		  	
		  	
		  	
		  	//$scope.getCitySubs();
		  	$scope.getHeroes();

		  	$scope.getSnapshotSubs();
		  	$scope.getScenarioCitySub();
		  	//$scope.getRoad();
		  	

		  	
		  	 
	    });
		
	}
	
	$scope.addData = function(scenario){
	
		var data = [];

		if(roads != undefined){
			globe.remove(roads);						
		}
		angular.forEach(objectMap,function(city){
			globe.remove(city.object);			
		});
		
		window.data.forEach(function(city){
			
			if($scope.showUnuse || city.yn){
				data.push(city);
			}	
		});
		
		globe.addData(data, {format: 'legend'});
		
		objects = [];
       data.forEach(function(city){
    	   if(city.object != undefined){
	    	   objectMap[city.object.id] = city;	    		   
	    	   objects.push(city.object);
    	   }
       });
       $scope.getRoad(scenario.id);
       
		
	}
	
	$scope.pause = function(){
		$interval.cancel($scope.timer);
		$scope.timer = null;
	}

	$scope.play = function(){
		if($scope.timer == null){
			startTimer();
		}
	}
	
	$scope.select = function(object){
		$scope.selected = object;
	}

	$scope.dismiss = function(selected,recruitType,dismissed){
		if(recruitType == 'worker'){
			selected.idle=selected.idle-dismissed;
			selected.workers=selected.workers-dismissed;
			selected.mans=selected.mans+dismissed;
		}else{
			selected.garrison=selected.garrison-dismissed;
			selected.mans=selected.mans+dismissed;
		}
	}
	
	$scope.startMuster = function(city){
		$scope.mustered = city.garrison;
	}
	
	$scope.muster = function(city,mustered,openDialog){
		
		var force = city.muster(mustered);

		
		var object = globe.addForce(force,mustered,$scope.factions[force.faction].color);
		force.object = object;
		objectMap[object.id] = force;
		
		forceMap[object.id] = force;

		if(openDialog){

			$('#city').modal('toggle');

			$scope.selected = force;

			$('#force').modal('toggle');

		}

		
		$scope.factions[force.faction].forces.push(force);
		
		return force;
//		globe.animate();
	}
	
	$scope.checkRecruit = function(city){
		
		if(city == undefined) return true;
		
		if(city.food <=0){
			return true;
		}
		
		if(city.forces == undefined){
			return true;
		}
		
		var ret = false;
		city.forces.forEach(function(force){
			if(force.faction != city.faction){
				ret = true;
			}
		});
		
		return ret || city.mans==0 || city.population<100;
		
	}
	
	$scope.recruit = function(city,recruited,recruitType){
		
		city.recruiting = recruited;
		
		
		var max = city.population/100;
		max = city.getRecruitMax();

		var delay = Math.floor(city.recruiting*90/(max)) + 1;
		
		city.recruitJob = {
			fn:function(){
				city.mans -= city.recruiting;
				if(recruitType=='worker'){
					city.idle += city.recruiting;					
					city.workers += city.recruiting;					
				}else{
					city.militia += city.recruiting;

					city.garrison += city.recruiting;
					city.soldiers += city.recruiting;
				}
				city.recruiting = 0;
			},
			delay:delay
		};
		
		$scope.jobs.push(city.recruitJob);

	}
	
	$scope.selectBuildingCategory = function(category){
		$scope.selectedCategory = category.id;
	}
	$scope.checkBuilding = function(city,type,force){
		if(force==undefined){
			return !(city.idle>=$scope.buildings[type].builders && city.silver>=$scope.buildings[type].silver && city.maxBuildingSize >= ($scope.buildings[type].size + city.totalBuildingSize));
		}else{
			
			if(force.building != undefined) return true;
			
			var workers  =0;
			if(force.soldierClasses['worker'] != undefined){
				 workers = force.soldierClasses['worker'].muster;				
			}
			return !(workers>=$scope.buildings[type].builders && force.silver+ city.silver>=$scope.buildings[type].silver && city.maxBuildingSize >= ($scope.buildings[type].size + city.totalBuildingSize));
			
		}
	}
	
	$scope.build = function(city,type,force){
				
		var job;
		if(force == undefined){
			
			job = city.build(type);
			
		}else{
			
			var self = city;
			
			force.building = type;
			var cost = $scope.buildings[type].silver;
			force.silver -= cost;
			if(force.silver<0){
				force.position.silver += force.silver;
				force.silver = 0;
			}

			city.buildings[type].building = true;
			
			var job =  {
				fn:function(){
					self.buildings[type].amount ++;
					self.buildings[type].building = false;
				
					self.buildings[type].jobs.shift();
					
					self.calculateBuildingBonus();
					
					force.building = undefined;

				},
				delay:self.buildings[type].delay,
				force:force
			};

			city.totalBuildingSize += $scope.buildings[type].size;
			
			city.buildings[type].jobs.push(job);
			
		}
		
		$scope.jobs.push(job);
		
	}
	
	$scope.cancelRecruit = function(city){
		
		$scope.jobs.splice($scope.jobs.indexOf(city.recruitJob),1);

		city.recruiting = 0;
		
	}
	
	$scope.cancelBuild = function(city,type,force){
		
		var job = city.buildings[type].jobs.pop();
		$scope.jobs.splice($scope.jobs.indexOf(job),1);
		
		force = job.force;

		if(force == undefined){

			city.idle += $scope.buildings[type].builders;
		}else{
			force.building = undefined;
			
		}

 		city.totalBuildingSize -= $scope.buildings[type].size;

 		if(city.buildings[type].jobs.length == 0)
			city.buildings[type].building = false;
		
	}
	
	$scope.assign = function(city,type){
		var amount = (city.buildings[type].amount * $scope.buildings[type].workers) - city.buildings[type].workers;
		if(city.idle >= amount){
			city.idle -= amount;
			city.buildings[type].workers = (city.buildings[type].amount * $scope.buildings[type].workers);
		}else{
			city.idle = 0;
			city.buildings[type].workers +=city.idle;
		} 		  
	}
	
	$scope.unassign = function(city,type){
		
		city.idle += city.buildings[type].workers;
		city.buildings[type].workers = 0;

	}
	
	$scope.make = function(city,building,type){

		var job = city.make(building,type);
		
		if(job != undefined){			
			$scope.jobs.push(job);
		}

		
	}

	
	$scope.breakUp = function(force){
		var city = force.origin;
		city.garrison += force.soldiers;
		
		angular.forEach(force.soldierClasses,function(soldierClass,type){
			
			city.soldierClasses[type].garrison += soldierClass.muster;
			if(type=='worker'){
				city.idle += soldierClass.muster;
				city.workers += soldierClass.muster;

			}
			angular.forEach(soldierClass.weapons,function(weapon,type){
				city.weapons[type].amount += weapon.amount;
			});
		});
		
		angular.forEach(force.heroes,function(hero,id){
			city.heroes[id].state = 'garrisoned';
		});


		disband(force);

	}
	
	$scope.move = function(force,destiny,road){
		

		if(force.building != undefined){
			cancelBuild(force.position,force.building,force);
		}

		if(force.position ===road){
			
		}else{
			var forces = force.position.forces;
			forces.splice(forces.indexOf(force),1);
			force.position = road;
			
			force.position.forces.push(force);
			
		}
		
		
		force.destiny = destiny;
		force.state = 'move';
		
	}
	
	$scope.checkAnnex = function(force){
		
		if(force!= undefined && force.destiny != undefined){
			if(force.destiny.type=='city' && force.faction != force.destiny.faction){
				if(near(force,force.destiny) ){

				
				//if(force.position.population/20 <= force.soldiers){
					
					var check = false;
					force.destiny.forces.forEach(function(f){
						if(f.faction != force.faction){
							check = true;
						}
					});
					
					
					if(check) return true;
					
					return false;
				//}
				}
			}
		}
		
		return true;
	}
	
	$scope.annex = function(force){
		
		force.annexing = true;
		
		var target = force.destiny;
				
		var delay = Math.floor((target.population/20 ) *30 /force.soldiers) + 1;
		
		
		if(target.recruiting > 0){
			$scope.cancelRecruit(target);
		}
		
		force.annexJob = {
			fn:function(){
				
				if($scope.factions[target.faction] != undefined){
					var cities = $scope.factions[target.faction].cities;
					cities.splice(cities.indexOf(target),1);
				}
							
				target.faction = force.faction;
				
				$scope.factions[target.faction].cities.push(target);
				
				target.loyalty = 10;
				target.garrison = 0;
				target.soldiers = 0;
				
				globe.changeColor(target.object,$scope.factions[force.faction].color);

				force.annexing = false;
				
				$scope.refreshTargets  = true;
				
				var targeted = $scope.factions[force.faction].targeted;
				targeted.splice(targeted.indexOf(target.id),1);
				
				target.population = Math.floor(target.population*0.9);
				target.mans = Math.floor(target.mans*0.9);

			},
			delay:delay
		};
		
		$scope.jobs.push(force.annexJob);
		

	}
	
	$scope.cancelAnnex = function(force){
		$scope.jobs.splice($scope.jobs.indexOf(force.annexJob),1);

		force.annexing = false;
		
	}
	
	$scope.checkMuster = function(city){
		
		if(city == undefined) return true;
		
		var amount = 0;
		angular.forEach(city.soldierClasses,function(soldierClass){
			amount += soldierClass.muster;
		})
		
		
		return amount == 0;
	}
	
	$scope.checkClassMuster = function(city,type){
		
		if(city == undefined) return true;
		if(city.weapons == undefined) return true;

		if(city.mustering.soldierClasses[type] != undefined){
			if(city.soldierClasses[type].garrison <= city.mustering.soldierClasses[type].amount) return true;
		}
		
		var ret =  false;
		
		var soldierClass = $scope.soldierClasses[type];
		
		var add = Math.min(city.soldierClasses[type].garrison,soldierClass.unit);
		angular.forEach(soldierClass.sub,function(sub){
			if(sub.type=='weapon' && sub.value1 =='primary'){
				if( city.weapons[sub.value].amount < city.soldierClasses[type].muster + add){
					ret = true;
					return false;					
				}
			}
		})
		
		
		return ret ;
	}

	
	
	$scope.getRecruitMax = function(city){
		if(city != undefined){
			var max = city.population/100;
			max = Math.floor(max*city.loyalty/100);
			return max < (city.mans - city.soldiers)?max:(city.mans - city.soldiers);
		}
		
		return 0;
	}
	
	 $('body').popover({
	    selector: "[data-toggle='popover']",
	    trigger: 'hover',
	    html: true
	});
	
	$scope.setPopover = function(id){
		

	}

	
	$scope.start = function(faction){
		$scope.faction = faction;
		$scope.play();
		
	}
	
	
	$scope.getBlockSize = function(city){
		var size = 0;
		angular.forEach(city.buildings,function(building,type){
			size += $scope.buildings[type].size * building.amount;
		});
		
		
		return size;
	}
	
	$scope.getMaxBlockSize = function(city){
 		return Math.floor(Math.sqrt(city.population)*2);
		// 		return Math.pow(Math.floor(Math.sqrt(city.population)/10),2) + 10;
	}
	
	$scope.assignClass = function(city,type,stat){
		var soldierClass = $scope.soldierClasses[type];
		
		if(stat == 'organize'){
			var add = Math.min(city.militia,soldierClass.unit);
			city.soldierClasses[type].garrison += add;
			city.militia -=add;
			
		}else{
			var add = Math.min(city.soldierClasses[type].garrison - city.soldierClasses[type].muster,soldierClass.unit);
			city.soldierClasses[type].muster += add;
		}
	}

	$scope.unassignClass = function(city,type,stat){
		
		var soldierClass = $scope.soldierClasses[type];

		if(stat == 'organize'){
			var sub = Math.min(city.soldierClasses[type].garrison,soldierClass.unit);
			city.soldierClasses[type].garrison -= sub;
			city.militia +=sub;

		}else{
			var sub = Math.min(city.soldierClasses[type].muster,soldierClass.unit);
			city.soldierClasses[type].muster -= sub;
			
		}
	}

	$scope.checkAssistBuild = function(force){
		if(force == undefined) return false;
		if(force.position == undefined) return false;
		if(force.faction != force.position.faction) return false;
		if(force.soldierClasses['worker'] == undefined) return false;
		
		return force.soldierClasses['worker'].muster > 0;
	}
	
	$scope.getSupply = function(force){
		
		var capacity = 0;
		
		angular.forEach(force.soldierClasses,function(soldierClass){
			
			capacity += soldierClass.muster;

			angular.forEach(soldierClass.weapons,function(weapon,type){
				$scope.weapons[type].sub.forEach(function(sub){
					if(sub.type == 'capacity'){
						capacity += parseInt(sub.value) * weapon.amount;
					}
				});
			});
			
		});
		
		var add = capacity - (force.food - force.silver);
		add = Math.min(add,force.position.food);
		
		force.food += add;
		force.position.food -= add;

	}
	
	function getOptions(city,option){
		var ret = 0;
		angular.forEach(city.buildings,function(building,type){
			if($scope.buildings[type] == undefined) {console.log(type);}
			if(building.amount>0){
				var sub = $filter('filter')($scope.buildings[type].sub,{type:option});
				if(sub.length>0){
					if($scope.buildings[type].workers>0){
						ret += Math.floor((building.workers/($scope.buildings[type].workers * building.amount))*(parseInt(sub[0].value) * building.amount)); 
					}else{
						ret += (parseInt(sub[0].value) * building.amount);
					}
				}
			}
		});
		
		return ret;
	}
	
	function aiAssignBuildingShortage(city,building){
		if(city.ai.buildingShortage == undefined){
			city.ai.buildingShortage = building;
		}
	}
	function aiMakeWeapon(city,type,weapon){
		
		if(city.weapons[weapon].making >0){
			return false;
		}
		
		if($scope.weapons[weapon].category == 'weapon'){
			if( city.usedArmoury+city.scope.weapons[weapon].unit*city.scope.weapons[weapon].space>city.armoury){
				aiAssignBuildingShortage(city,'armoury');				
				return false;
			}					
		}
		if($scope.weapons[weapon].category == 'livestock'){
			if( city.usedStable+city.scope.weapons[weapon].unit*city.scope.weapons[weapon].space>city.stable){
				aiAssignBuildingShortage(city,'stable');				
				return false;
				
			}					
		}

		
		if(city.buildings[type].amount == 0){
			aiAssignBuildingShortage(city,type);				


		}else{
			if(city.buildings[type].workers == 0){
				if(city.buildings[type].amount * $scope.buildings[type].workers > city.idle){
					city.ai.workerShortage = true;
				}
				$scope.assign(city,type);
			}
		}
		
		if(!city.checkMake(city.buildings[type],weapon)){
			$scope.make(city,city.buildings[type],weapon);
		}
		
	}
	
	function aiRecruit(city){
		
		if(!city.checkRecruit() && city.recruiting == 0){
			var recruited = city.getRecruitMax();
			if(recruited>0){
				
				var annualFoodEarning = city.annualFoodEarning();
				var totalForce = city.garrison;
				city.forces.forEach(function(force){
					totalForce += force.solider;
				});
				
				if((totalForce+recruited)/10*200 < annualFoodEarning){
					$scope.recruit(city,recruited,'soldier');					
					city.ai.foodShortage = false;					
					
				}else{
					city.ai.foodShortage = true;
				}				
			}
		}	
		
		
		if(city.weapons['spear'].amount < city.militia){
			aiMakeWeapon(city,'blacksmith','spear');
		}
		
		if(city.ai.oxShortage){
			aiMakeWeapon(city,'breeder','ox');
			city.ai.oxShortage = false;
		}
	}
	
	
	function aiCheckBuild(city,type){
		
		if( city.buildings[type].jobs.length>0){
			return false;
		}
		
		if(city.idle<$scope.buildings[type].builders){
			city.ai.workerShortage = true;
			return false;
		} 
		
		if(city.silver<$scope.buildings[type].silver){
			city.ai.silverShortage = true;
			return false;
		}  
		
		if(city.maxBuildingSize < ($scope.buildings[type].size + city.totalBuildingSize)){
			return false;			
		}
		
		$scope.build(city,type);
		
		return true;
	}
	
	function aiBuild(city){
		
		if(city.population >= city.getOptions('residence') && city.buildings['residence'].jobs.length==0){
			aiCheckBuild(city,'residence');			
		}
		
		if(city.annualFoodEarning() *1.5 >= city.getOptions('granary') && city.buildings['granary'].jobs.length==0){
			aiCheckBuild(city,'granary');
		}
		
		if(city.annualSilverEarning() * 1.5 >= city.getOptions('deposite') && city.buildings['deposite'].jobs.length==0){
			aiCheckBuild(city,'silver');
		}
		
		if(city.buildings['blacksmith'].amount == 0){
			aiCheckBuild(city,'blacksmith');			
		}

		if(city.buildings['breeder'].amount == 0){
			aiCheckBuild(city,'breeder');			
		}
		
		if(city.ai.workerShortage){
			if(city.militia >= 0){
				city.assignClass('worker','organize');
//				if(city.ai.workerShortage<0) city.ai.workerShortage = 0;
				city.ai.workerShortage  = false;

			}
		}
		
		if(city.ai.foodShortage){
			if(city.buildings['irrigation'] != undefined){
				aiCheckBuild(city,'irrigation');				
			}
			city.ai.foodShortage = false;
		}
		
		if(city.ai.buildingShortage !=undefined){ 
			aiCheckBuild(city,city.ai.buildingShortage);				
			city.ai.buildingShortage = undefined;
		}
	}
	
	function makeAiTarget(){
		angular.forEach($scope.factions,function(faction){
			
			faction.targets = [];
			
			faction.cities.forEach(function(city){
				city.destinies.forEach(function(destiny){
					if(destiny.city.faction != city.faction){
						var filtered = $filter('filter')(faction.targeted, destiny.city.id)
						if(filtered.length == 0){
							faction.targets.push(destiny.city);
						}
					}
				});
			});
		});
		
		$scope.refreshTargets = false;
		
	}
	
	
	function aiOrganize(city,targetForce,movingDays){
		
		var workers = targetForce * (movingDays - 10 )/ (130 - movingDays);
		
		if(workers > city.idle){
			city.ai.workerShortage = true;
			return false;
		}
				
		if(targetForce == 0){
			targetForce = city.weapons['spear'].amount;
		}
		for(var i=0;i<targetForce;i+=100){
			city.assignClass('spear','organize');
		}

		if(targetForce == 0){
			while(city.militia>0){
				city.assignClass('worker','organize');
			}

		}
		return true;
	}
	
	function aiMuster(city,targetForce,movingDays){
		var workers = targetForce * (movingDays - 10 )/ (130 - movingDays);
		
		for(i=0;i<workers;i+=100){
			city.assignClass('worker','muster');
		}
				
		if(targetForce == 0){
			targetForce = city.weapons['spear'].amount;
		}
		for(i=0;i<targetForce;i+=100){
			city.assignClass('spear','muster');
		}
		
		if(targetForce == 0){
			if(city.mustering.soldierClasses['worker']==undefined){
				city.assignClass('worker','muster');				
			}
			while(city.mustering.soldierClasses['worker'].amount < city.idle){			
				city.assignClass('worker','muster');
			}			
		}
				
	}	
	
	
	function aiSetTarget(faction){
		var weights = [];
		
		faction.targets.forEach(function(target){												

			var w = 0;
			
			target.destinies.forEach(function(destiny){
				if(destiny.city.faction == faction.id){
					if(target.population/10 + target.garrison*2 <= destiny.city.garrison ){
						
						w +=   (target.population/10 + target.garrison*2 ) *100 / destiny.city.garrison;

						if(target.faction == 0){
							w+=50;
						}
						
					}
					
				}
			});
			
			weights.push({weight:w, city:target});												
			
		});
		
		
		
		weights = $filter('orderBy')(weights, '-weight');
		
		if(weights.length > 0){
			var target = weights[0];
			if(target.weight > 0){
				if(Math.random()<target.weight * 0.0005){
					var city = target.city;
					city.destinies.forEach(function(destiny){
						var c = destiny.city;
						if(c.faction == faction.id){
							
							var targetForce = city.population/10 + city.garrison*2;
							if(c.weapons['spear'].amount > targetForce){
								var spear = c.weapons['spear'].amount;
								var ox = c.weapons['ox'].amount;
								var days = (spear + ox*13 ) * 10/ spear+ox;

								var distance = globe.distanceTo(city.object,destiny.city.object);
								var movingDays = distance/(movingSpeed*3);

								movingDays = movingDays*2+60;
								if(movingDays > days){
									if(c.weapons['ox'].making==0){
										c.ai.oxShortage = true;
									}
								}else{
									
									if(aiOrganize(c,targetForce,movingDays)){
										
										aiMuster(c,targetForce,movingDays);
									
										var force = $scope.muster(c,c.garrison,false);

										force.positions = [];											
										force.positions.push(city);

										$scope.move(force,city,destiny.road);
										
										
										faction.targeted.push(city.id);
										
										faction.targets.splice(faction.targets.indexOf(city),1);
									}
									
								}
								
							}
							
							//if(city.population/10 + city.garrison*2 <= destiny.city.garrison && destiny.city.garrison>=50){

								

					//		}
							
						}
					});								
				}
			}
		}

	}
	
	function aiMoveForces(faction){
		faction.forces.forEach(function(force){
			if(force.state =='stop'){
				
				
				if(!$scope.checkAnnex(force) && !force.annexing){
					$scope.annex(force);
				}else{
					if(force.destiny != undefined){
						if(force.destiny.faction == force.faction && force.destiny.id != force.origin.id){
							force.destiny.destinies.forEach(function(destiny){
								if(destiny.city === force.origin){
									$scope.move(force,force.origin,destiny.road);											
								}
							});
						}
					}
				}

				
				if(force.position.id == force.origin.id){
					
					if(!cityInvading(force.position)){
						$scope.breakUp(force);
						
					}
			
				}
				
				//							$scope.move(force,)
			}
		});			
	}
	
	function cityInvading(city){
		var invading = false;
		city.destinies.forEach(function(destiny){
			destiny.road.forces.forEach(function(force){
				if(force.faction != city.faction){
					invading = true;
				}
			});						
		});
		
		return invading;

	}
	
	function ai(count){
		
		if($scope.refreshTargets){
			makeAiTarget();
		}
		
		angular.forEach($scope.factions,function(faction){
			if(faction.id != $scope.faction.id){
				
				if(faction.cities.length>0){
				
					faction.cities.forEach(function(city){
											
						if(cityInvading(city)){
							if(city.garrison >=50){							
								
								aiOrganize(city,0,0);
								aiMuster(city,0,0);

								var force = $scope.muster(city,city.garrison,false);
								force.state = 'stop';
							}
						}else{
							aiRecruit(city);
							aiBuild(city);
						}
					});
					
					if(count%9==0){
											
						aiSetTarget(faction);
					}	
	
					
					if(count%3==0){
						aiMoveForces(faction);		
					}
				
				}

			}
		});
		
	}
	
	function addDate(){
		if($scope.date.getMonth() == 11 && $scope.date.getDate() == 31){
			$scope.year++;
			if($scope.date.getYear() == 2199){
				$scope.date.setYear(1999);
			}
		}
		$scope.date.setDate($scope.date.getDate()+1);
		
		setTimeString();
	}
	
	function dailyJob(){
		citiesArray.forEach(function(city){
			city.dailyJob();
		});
	}
	

	
	function monthlyJob(count){
		if($scope.date.getDate() == 1 && count >3){
			citiesArray.forEach(function(city){
				
				var grow; 
				
				var add = city.getOptions('population');
				var residence = city.getOptions('residence');
				
				
				if(city.faction ==0){
					grow = Math.floor(city.population*0.002)  +1 + add;
				}else{
					
					
					
					grow = Math.floor(city.population*0.003*(city.loyalty-50)*0.01)  + add;						
					
					if(city.population + grow > residence){
						grow = residence -city.population;
					}					
					
				}
				
				
				if(grow>0){
				
					city.population += grow;
					
					var g = Math.floor(grow*0.1)
					if(g == 0){
						if(Math.random()<0.1){
							g = 1;
						}
					}
					
					city.mans +=g;
					
					if(city.faction ==0){
					
						city.buildings.residence.amount = Math.floor((city.population/1000)+(city.population%1000==0?0:1));
					}
					
			 		city.maxBuildingSize = $scope.getMaxBlockSize(city);

				
				}
				
				var max = city.getOptions('loyalty');
				var loyaltyGrowth = city.getOptions('loyaltyGrowth');
				
				if(city.loyalty<100+max && city.faction !=0){
					city.loyalty+=1+(loyaltyGrowth/city.population);
				}
				
			
				
			});
		}
	}
	
	function annualJob(count){
		if($scope.date.getDate() == 1 && ($scope.date.getMonth() ==0 || $scope.date.getMonth() ==6) && count >3){
			citiesArray.forEach(function(city){

				
				if(city.faction != 0){
					
					city.annualJob();
					
				}
				
			});
		}
		
	}
	
	function startTimer(){
		var count = 1;
		var day = 3;
		$scope.timer = $interval(function(){
			
			if(count%day == 0){
				
				addDate();
				
				dailyJob();
				
				monthlyJob(count);					
			
				annualJob(count);	
			}
			
			moveForces(count);
			
			$scope.jobs.slice(0).forEach(function(job){
				if(job.exec != undefined){
					job.exec();
				}
				if(--job.delay <= 0){
					job.fn();
					$scope.jobs.splice($scope.jobs.indexOf(job),1);
				}
			});
			
			ai(count);
			
			count++;
			
		},1000);	
	}
	
	function disband(force){
		
		globe.remove(force.object);
		
		var forces = $scope.factions[force.faction].forces;
		forces.splice(forces.indexOf(force),1);

		forces = force.position.forces;
		forces.splice(forces.indexOf(force),1);
		
		
		delete forceMap[force.object.id];
		delete force;
		
		console.log($scope.factions[force.faction].forces);

	}

	function checkDisband(force){
		
		if(force.soldiers <= 0){

			disband(force);
			
		}
		
	}
	
	function battle(force,f){
		

		var ra = Math.random();
		var rb = Math.random();
		
		var soldiersA=0,soldiersB=0;
		var baseDamageA=0,baseDamageB=0;
		var typeA,typeB;
		
		if(f.soldierClasses['spear'] != undefined){
			if(f.soldierClasses['spear'].muster > 0){
				soldiersA = f.soldierClasses['spear'].muster;
				baseDamageA = 60;
				typeA = 'spear';
			}
		}
		if(soldiersA == 0){
			soldiersA = f.soldierClasses['worker'].muster;			
			baseDamageA = 30;
			typeA = 'worker';

		}
		
		if(force.soldierClasses['spear'] != undefined){
			if(force.soldierClasses['spear'].muster > 0){
				soldiersB = force.soldierClasses['spear'].muster;
				baseDamageB = 60;
				typeB = 'spear';

			}
		}
		if(soldiersB == 0){
			soldiersB = force.soldierClasses['worker'].muster;			
			baseDamageB = 30;
			typeB = 'worker';

		}
		
			
		var damageA = Math.floor( ra* baseDamageA*(f.morale/100))+1;		
		var damageB = Math.floor( rb* baseDamageB*(force.morale/100))+1;
		
		
		
		var deadA = Math.min(soldiersB,damageA);
		var deadB = Math.min(soldiersA,damageB);   
		
		if(ra>=0.9) {
			f.morale++;
		}		

		if(ra>=0.7) {
			if(force.morale>0) force.morale--;
		}		

		if(ra>=0.9) {
			force.morale++;
		}
		if(ra>=0.7) {
			if(f.morale>0) f.morale--;
		}

		force.soldierClasses[typeB].muster -= deadA;
		f.soldierClasses[typeA].muster -= deadB;

		force.soldiers -= deadA;
		f.soldiers -= deadB;
		
		force.origin.population -= deadA;
		f.origin.population -= deadB;
		
		checkDisband(force);
		checkDisband(f);
	}
	
	function distanceTo(a,b){
		return a.object.position.distanceTo(b.object.position);
	}

	function near(a,b){
		return distanceTo(a,b) <= 0.3;
	}

	function moveForces(count){
		
		angular.forEach(forceMap,function(force){
			
			if(force.state == 'move'){
				
				
				var destiny = force.destiny;
				
				
				var accessable = true;

				if(near(force,destiny)){

					if(destiny.faction != force.faction && destiny.faction != 0){
						accessable = false;
						force.state ='stop';

					}
					
					destiny.forces.forEach(function(f){
						if(f.faction != force.faction){
							accessable = false;					
							force.state ='stop';

						}
					});
					
					
//					if(!$scope.checkAnnex(force)){
//						$scope.annex(force);
//					}
				}

				if(accessable){

					if(!globe.move(force.object,destiny.object,movingSpeed)){
					
					
						
						var forces = force.position.forces;
						forces.splice(forces.indexOf(force),1);
	
						
						force.position = destiny;
						force.state='stop';
						
						
						force.position.forces.push(force);
						
						
					}
				}
				
			
				
			}
			
			force.position.destinies.forEach(function(destiny){
				destiny.road.forces.forEach(function(f){
					if(f.faction != force.faction){
						if(near(force,f) ){
							battle(force,f);
						}
					}

				});						
			});

			
			if(force.annexing){

				var d = Math.min(force.soldiers,force.destiny.garrison,30);


				var a = Math.floor(Math.random() * d);		
				var b = Math.floor(Math.random() * d);

				var ma = Math.min(force.soldiers,a);
				var mb = Math.min(force.destiny.garrison,b);
				
				
				force.soldiers -= ma;
				force.destiny.garrison -=mb;
				
				force.origin.population -= ma;
				force.destiny.population -= mb;
				
				checkDisband(force);
			}
			
			
			if(count%3 ==0){
				
				if(force.position.id != force.origin.id){
					force.morale = force.morale*0.99;
				}

				
				var sub = Math.max(force.soldiers*0.1,1);
				force.food -= sub;
				
				if(force.food <0){
					
					if(force.position.faction == force.faction){
						force.position.food += force.food;
						force.food = 0;
					}else{
					
						force.food = 0;
						force.morale -= 10;
					}
				}

				if(force.morale<0){
					force.morale = 0;
					
					force.soldiers = 0;
					angular.forEach(force.soldierClasses,function(soldierClass){
						soldierClass.muster = Math.floor(soldierClass.muster*0.9);
						force.soldiers += soldierClass.muster;
					});
					
					checkDisband(force);
					
				}
			}
			
		});
		
	}
	
	function setTimeString(){
		if($scope.year < 0){
			$scope.yearString = 'BC ' + (-$scope.year);
		}else{
			$scope.yearString = 'AD ' + $scope.year;
		}
		
		$scope.dateString = ($scope.date.getMonth()+1) + '.'+ $scope.date.getDate() ; 
		

	}
	
	function initTime(){
		$scope.year = -2600;
		
		$scope.adjYear = 2000 + $scope.year%4;
		
		$scope.date = new Date($scope.adjYear+'-01-01');
		
		
		setTimeString();
		
//		startTimer();
	}
	
	$scope.getScenario();
	
	$scope.getBuildings();
	$scope.getWeapons();
	$scope.getSoldierClass();

	$scope.getTraits();
	$scope.getFaction();
	globe.animate();

	
	initTime();

    document.body.style.backgroundImage = 'none'; // remove loading
    
    $scope.newGame = true;
    $scope.refreshTargets = true;
//	$('#start').modal({ backdrop: 'static',   keyboard: false});

});

</script>

	

</body>
</html>