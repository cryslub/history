<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html >
<html lang="en">
<head>
  <title>선거 데이터 센트럴 조감도</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="그것은 알기 싫다 선거 데이터 센트럴 조감도" />
  <link rel="stylesheet" href="css/bootstrap.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://bootswatch.com/_vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
		 <script src="js/toArrayFilter.js"></script>	
	
	<style>
	.card{
		border-color:silver;
		border:0px;
		border-left:3px solid;
		margin-left: 20px;
    	width: 200px;
	}
	.card-header{
		padding: 0.55rem 1.25rem;
		border-top: 1px solid rgba(0, 0, 0, 0.125);		
		border-bottom: 1px solid rgba(0, 0, 0, 0.125);		
		border-right: 1px solid rgba(0, 0, 0, 0.125);		
    	white-space: nowrap;		
	}
	.card-body{
		padding: 0.55rem 1.25rem;
		border-bottom: 1px solid rgba(0, 0, 0, 0.125);		
		border-right: 1px solid rgba(0, 0, 0, 0.125);		
    	font-size : 0.8rem
	}
	.badge{
		white-space:normal;
	}
	</style>
	
</head>
<body>


  
<div ng-app="myApp" ng-controller="myCtrl" style="overflow-x:hidden;">
	<a class="btn" ng-click="saveJSON()" ng-href="{{ url }}">Export to JSON</a>
	<br>
	<textarea ng-model="txt"></textarea>
 	
 	<br>
</div>
 <script>
var app = angular.module('myApp', ['angular-toArrayFilter']);
app.controller('myCtrl', function($scope,$http) {
	$http.get("json/TL_SCCO_EMD.json")
    .then(function(response) {
        $scope.file = response.data;        
        
        $scope.txt = "";
        $scope.file.features.forEach(function(feature){
        	var fileName = feature.properties.EMD_CD;
        	var name = feature.properties.EMD_ENG_NM;
        	var data = {
        		features:[],
        		type:"FeatureCollection"
        	}
        	
        	
        	data.features.push(feature);
        	$scope.txt += fileName+" "+ name +"\n";
        	
//        	console.log(fileName, name);
        	
        	$scope.saveJSON(fileName,data)
        });
    });
	
	$scope.saveJSON = function (fileName,data) {
		$scope.toJSON = '';
		$scope.toJSON = angular.toJson(data);
		var blob = new Blob([$scope.toJSON], { type:"application/json;charset=utf-8;" });			
		var downloadLink = angular.element('<a></a>');
                    downloadLink.attr('href',window.URL.createObjectURL(blob));
                    downloadLink.attr('download', fileName+'.json');
		downloadLink[0].click();
	};
	
});
</script>

</body>
</html>