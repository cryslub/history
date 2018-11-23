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
		    <input ng-model="year" ng-change="getSnapshot()"/>
		  </div>

		<div class="modal fade" id="city" tabindex="-1" role="dialog">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" style="padding-left: 10px;">{{selected.name}} 
								<span class="badge ng-binding" ng-style="{'color':'white','background-color': factions[selected.faction].color}">
									{{factions[selected.faction].name}}
								</span>
								<small  style="margin-left:3px;color:silver;top: 2px; position: relative;"> 
								<small><span class="glyphicon glyphicon-user"> </span></small> {{selected.population|number}}</small>
						</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-right: 0px;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="padding-left: 10px;">


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
app.controller('myCtrl', function($scope,$http,$filter,$window,$sce) {


	 var cities = {};
	$scope.factions = {};
	 
	 var lines = [{
		start:'Uruk',
		end: 'Ur'
	 }]
	 
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
	 		
	 		  if ( intersects.length >= 3 ) {
				if(intersects[0].faceIndex != null){
//	 			  console.log(intersects);
		 			  
		 			  var index = intersects[0].faceIndex/12;
		 			  index = Math.floor(index);
		 			  console.log(index);
		 			 $('#city').modal();
		 			 
		 			 
		 			 
		 			 $scope.selected = citiesArray[index];
		 			 $scope.$apply();
				}
	 		  }
	 	  }
			
	 });

	 var lineCoord = [];
	 
		var data = [];
		
	$scope.getSnapshot = function(){
		
		var year = parseInt($scope.year);
		if(Number.isInteger(year)){
			$http.get("data/snapshot.do?year="+$scope.year)
		    .then(function(response) {
		    	
		    	list = response.data;
		    	data = [];
			 	angular.forEach(list,function(city){
			 		cities[city.id] = city;
			 		data.push(city)
//					data = data.concat([city.latitude,city.longitude,city.population,city.faction]);
			 	});
			 	
		       window.data = data;
		       globe.addData(data, {format: 'legend'});
		       globe.createPoints();
			   	globe.animate();

			  	 citiesArray = Object.values(list);

			  	$scope.getRoad();
			  	 
		    });
		}	
	};
	
	$scope.getRoad = function(){
		$http.get("data/road.do?year="+$scope.year)
	    .then(function(response) {
	    	var lines = response.data;
	    	lineCoord = [];
			angular.forEach(lines,function(line){
				if(cities[line.start] != undefined && cities[line.end] != undefined){
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
	
	$scope.getFaction();
	globe.animate();
 	
       document.body.style.backgroundImage = 'none'; // remove loading
});

</script>

	

</body>
</html>