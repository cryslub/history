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
  <script type="text/javascript" src="js/globe.js"></script>


<style>
 html {
        height: 100%;
      }
	body { margin: 0; }
//	canvas { width: 100%; height: 100% }

	    #currentInfo {
        width: 270px;
        position: absolute;
        left: 20px;
        top: 63px;

        background-color: rgba(0,0,0,0.2);

        border-top: 1px solid rgba(255,255,255,0.4);
        padding: 10px;
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
</style>


</head>
<body>

	<script src="js/three.js"></script>

	<div ng-app="myApp" class="wrapper" ng-controller="myCtrl"
		style="overflow-x: hidden;">
		
		<div id="container"></div>
		  <div id="currentInfo">
		  	<label style="color:white;">{{yearString}}.{{dateString}}</label> 
		  	<button class="btn btn-sm" ng-click="pause()"><span class="glyphicon glyphicon-pause"></span></button>
		  	<button class="btn btn-sm" ng-click="play()"><span class="glyphicon glyphicon-play"></span></button>
		  </div>

		<div class="modal fade" id="city" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">{{selected.name}} 
								<span class="badge ng-binding" ng-style="{'color':'white','background-color': factions[selected.faction].color}">
									{{factions[selected.faction].name}}
								</span>
								<small  style="color:silver;"> <small><span class="glyphicon glyphicon-user"> </span></small> {{selected.population|number}}</small>
						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="city-body" class="carousel slide" data-interval="false">
							<div class="carousel-inner">
							    <div class="carousel-item active">
									<span style="color:silver;"><span class="glyphicon glyphicon-pawn" title="Soldiers"> </span> <strong title="Garrison">{{selected.garrison|number}}</strong> / <label title="Total">{{selected.soldiers|number}}</label> / <label title="Potential">{{(selected.mans)|number:0}}</label></span>
									<span ng-show="selected.faction == faction.id">
										<button class="btn btn-primary btn-sm" title="Cancel Recruiting" ng-show="selected.recruiting > 0" ng-click="cancelRecruit(selected)"><span class="glyphicon glyphicon-remove"></span></button>
										<button class="btn btn-primary btn-sm" title="Recruit" href="#city-body" ng-hide="selected.recruiting > 0" ng-disabled="selected.mans==0 || selected.population<100 " data-slide="next" ng-click="stat='recruit';recruited=getRecruitMax(selected)"><span class="glyphicon glyphicon-bullhorn"></span></button>
										<button class="btn btn-primary btn-sm" title="Muster" href="#city-body" ng-disabled="selected.garrison<50 " data-slide="next" ng-click="stat='muster';mustered = selected.garrison;"><span class="glyphicon glyphicon-bell"></span></button>
									</span>
							    </div>
							    <div class="carousel-item">
								    <form class="form-inline">
								    	<div class="form-group">
										    <button class="btn btn-primary btn-sm mb-2 mr-sm-2" title="Go Back" href="#city-body" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></button>
											<span ng-show="stat=='muster'">
											    <input class="form-control mb-2 mr-sm-2" type="number" max="{{selected.garrison}}" min="50" ng-model="mustered"></input>								    
											    <button class="btn btn-primary btn-sm mb-2""  data-dismiss="modal" title="Muster" ng-click="muster(selected,mustered)" ng-disabled="mustered== undefined">
											    	<span class="glyphicon glyphicon-ok"></span>
											    </button>
										    </span>										    
											<span  ng-show="stat=='recruit'">
											    <input class="form-control mb-2 mr-sm-2" type="number" max="{{getRecruitMax(selected)}}" min="0" ng-model="recruited"></input>								    
											    <button class="btn btn-primary btn-sm mb-2""  href="#city-body" data-slide="prev" title="Reruit" ng-click="recruit(selected,recruited)" ng-disabled="recruited== undefined || recruited==0">
											    	<span class="glyphicon glyphicon-ok"></span>
											    </button>
										    </span>										    
										    
									    </div>
									</form>
							    </div>
							    <div class="carousel-item">
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
						<h5 class="modal-title">{{selected.name}} 
								<span class="badge ng-binding" ng-style="{'color':'white','background-color': factions[selected.faction].color}">
									{{factions[selected.faction].name}}
								</span>
								<small  style="color:silver;"> <small><span class="glyphicon glyphicon-user"> </span></small> {{selected.soldiers|number}}</small>
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
							    	<span ng-show="selected.faction == faction.id">
										<button class="btn btn-primary btn-sm" ng-hide="selected.origin.id!=selected.position.id"  title="Break Up" data-dismiss="modal"  ng-click="breakUp(selected)"><span class="glyphicon glyphicon-home"></span></button>
										<button class="btn btn-primary btn-sm" ng-hide="selected.annexing" title="Move" href="#force-body"  data-slide="next" ng-click=""><span class="glyphicon glyphicon-road"></span></button>
										<button class="btn btn-primary btn-sm" ng-hide="selected.state!='move'" title="Pause"  ng-click="selected.state='pause'"><span class="glyphicon glyphicon-pause"></span></button>
										<button class="btn btn-primary btn-sm" ng-hide="selected.state!='pause'" title="Resume"  ng-click="selected.state='move'"><span class="glyphicon glyphicon-play"></span></button>
										<button class="btn btn-primary btn-sm" title="Cancel Annexing" ng-show="selected.annexing" ng-click="cancelAnnex(selected)"><span class="glyphicon glyphicon-remove"></span></button>
										<button class="btn btn-primary btn-sm" ng-hide="checkAnnex(selected) || selected.annexing" title="Annex"  ng-click="annex(selected)"><span class="glyphicon glyphicon-flag"></span></button>
									</span>
							    </div>
							    <div class="carousel-item">
									<button class="btn btn-primary btn-sm mb-2 mr-sm-2" title="Go Back" href="#force-body" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></button>

							    	<div class="list-group">
									  	<a href="#" class="list-group-item" ng-repeat="destiny in selected.position.destinies" ng-click="move(selected,destiny)" data-dismiss="modal" >{{destiny.name}}</a>
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
	</div>

	<script>

	
 window.mobileAndTabletcheck = function() {
  var check = false;
  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
  return check;
};
	
var app = angular.module('myApp', ['angular-toArrayFilter','ui.bootstrap']);
app.controller('myCtrl', function($scope,$http,$filter,$window,$sce,$interval) {


	 var cities = {};
	$scope.factions = {};
	 
	var jobs = [];
	
	 var lines = [{
		start:'Uruk',
		end: 'Ur'
	 }]
	 
	 var objectMap = {};
	 var forceMap = {};
	 
	 var citiesArray = Object.values(cities);
	 
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
//	 		  console.log(event);

	 		  
	 		  var mouse = new THREE.Vector2();
	 		  
	 		  mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
	 		  mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
	 		  
	 		  var raycaster = new THREE.Raycaster();
	 		  raycaster.setFromCamera( mouse, camera );
	 		  var intersects = raycaster.intersectObjects( scene.children );
	 		
	 		 $scope.clicked = [];
	 		 intersects.forEach( function(intersect){
	 		 	if(objectMap[intersect.object.id] != undefined){
	 		 		$scope.clicked.push(objectMap[intersect.object.id]);
	 		 	}
	 		 });
	 		 
	 		 
	 		 if($scope.clicked.length>0){
	 			 
	 			 $('#city-body').carousel(0);
	 			 $('#force-body').carousel(0);

	 			if($scope.clicked.length==1){
	 				$scope.selected =objectMap[intersects[0].object.id];
	 				
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
	 		 }
	 	  }
			
	 });

	 var lineCoord = [];
	 
		var data = [];
		
	$scope.getSnapshot = function(){
		
			$http.get("data/scenarioSnapshot.do")
		    .then(function(response) {
		    	
		    	list = response.data;
		    	data = [];
			 	angular.forEach(list,function(city){
			 		cities[city.id] = city;
			 		city.type = 'city';
			 		city.mans = Math.floor(city.population/10);
			 		city.garrison = city.soldiers;
			 		city.destinies = [];
			 		data.push(city)
//					data = data.concat([city.latitude,city.longitude,city.population,city.faction]);
			 	});
			 	
		       window.data = data;
		       globe.addData(data, {format: 'legend'});
		       
		       data.forEach(function(city){
		    	   objectMap[city.object.id] = city;
		       });
		       
		       globe.createPoints();
			   	globe.animate();

			  	 citiesArray = Object.values(list);

			  	$scope.getRoad();
			  	 
		    });
	};
	
	$scope.getRoad = function(){
		$http.get("data/road.do?year="+$scope.year)
	    .then(function(response) {
	    	var lines = response.data;
	    	lineCoord = [];
			angular.forEach(lines,function(line){
				if(cities[line.start] != undefined && cities[line.end] != undefined){

					line.type ='road';
					cities[line.start].destinies.push(cities[line.end]);
					cities[line.end].destinies.push(cities[line.start]);

					lineCoord.push({start:cities[line.start],end:cities[line.end]});
				}
		 	});
			       globe.addLines(lineCoord);
	    	
	    });
		
	}
	
	$scope.getFaction = function(){
		$http.get("data/faction.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(faction){
				$scope.factions[faction.id] = faction;
		 	});
	    	
	    });
		
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

	$scope.startMuster = function(city){
		$scope.mustered = city.garrison;
	}
	
	$scope.muster = function(city){
		
		city.garrison -= $scope.mustered;
		$('#city').modal('toggle');
		
		var force = angular.copy(city);
		force.type = 'force';
		force.soldiers = $scope.mustered;
		force.name = city.name+' Force';
		force.origin = city;
		force.position = city;
		
		var object = globe.addForce(force,$scope.mustered);
		force.object = object;
		objectMap[object.id] = force;
		
		forceMap[object.id] = force;
		
		$scope.selected = force;
		
		$('#force').modal('toggle');
		
		
//		globe.animate();
	}
	
	$scope.recruit = function(city){
		
		city.recruiting = $scope.recruited;
		
		var delay = Math.floor(city.recruiting*30/(city.population/100)) + 1;
		
		city.recruitJob = {
			fn:function(){
				city.mans -= city.recruiting;
				city.garrison += city.recruiting;
				city.soldiers += city.recruiting;			
				city.recruiting = 0;
			},
			delay:delay
		};
		
		jobs.push(city.recruitJob);
		

	}
	
	$scope.cancelRecruit = function(city){
		
		jobs.splice(jobs.indexOf(city.recruitJob),1);

		city.recruiting = 0;
		
	}
	
	$scope.breakUp = function(force){
		var city = force.origin;
		city.garrison += force.soldiers;
		
		globe.remove(force.object);
		delete force;		
	}
	
	$scope.move = function(force,destiny){
		force.destiny = destiny;
		force.position = {destinies:[force.position,destiny]};
		force.state = 'move';
		
	}
	
	$scope.checkAnnex = function(force){
		
		if(force!= undefined && force.position != undefined){
			if(force.faction != force.position.faction){
				if(force.position.population/20 <= force.soldiers){
					return false;
				}
			}
		}
		
		return true;
	}
	
	$scope.annex = function(force){
		
		force.annexing = true;
		
		var target = force.position;
				
		var delay = Math.floor((target.population/20 ) *30 /force.soldiers) + 1;
		
		force.annexJob = {
			fn:function(){
				target.faction = force.faction;
				target.garrison = 0;
				target.soldiers = 0;
				
				globe.changeColor(target.object,$scope.factions[force.faction].color);

				force.annexing = false;

			},
			delay:delay
		};
		
		jobs.push(force.annexJob);
		
	}
	
	$scope.cancelAnnex = function(force){
		jobs.splice(jobs.indexOf(force.annexJob),1);

		force.annexing = false;
		
	}
	
	$scope.getRecruitMax = function(city){
		if(city != undefined){
			return Math.floor(city.population/100) < city.mans - city.soldiers?Math.floor(city.population/100):city.mans - city.soldiers;
		}
		
		return 0;
	}
	
	
	$scope.start = function(faction){
		$scope.faction = faction;
		$scope.play();
	}
	
	function startTimer(){
		var count = 0;
		$scope.timer = $interval(function(){
			
			if(count%3 == 0){
				if($scope.date.getMonth() == 11 && $scope.date.getDate() == 31){
					$scope.year++;
					if($scope.date.getYear() == 2199){
						$scope.date.setYear(1999);
					}
				}
				$scope.date.setDate($scope.date.getDate()+1);
				
				setTimeString();
			}
			
			moveForces();
			
			jobs.slice(0).forEach(function(job){
				if(--job.delay == 0){
					job.fn();
					jobs.splice(jobs.indexOf(job),1);
				}
			});
			
			count++;
			
		},1000);	
	}
	
	
	
	function moveForces(){
		
		angular.forEach(forceMap,function(force){
			if(force.state == 'move'){
				
				
				var destiny = force.destiny;
				
				if(!globe.move(force.object,destiny.object)){
					force.position = destiny;
					force.state='stop';
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
	
	$scope.getFaction();
	globe.animate();

	$scope.getSnapshot();
	
	initTime();

    document.body.style.backgroundImage = 'none'; // remove loading
    
	$('#start').modal({ backdrop: 'static',   keyboard: false});

});

</script>

	

</body>
</html>