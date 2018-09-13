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
	<script src="js/echarts.min.js"></script>	
	
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

	 <div id="main" style="width: 600px;height:50px;"\></div>
 	
 	<br>
</div>
 <script>
var app = angular.module('myApp', ['angular-toArrayFilter']);
app.controller('myCtrl', function($scope,$http) {
	
	 var myChart = echarts.init(document.getElementById('main'));
	 
	$http.get("json/Seoul.json")
    .then(function(response) {
        var geoJson= response.data;        
		
        echarts.registerMap('SEOUL', geoJson);

        myChart.setOption(option = {
           
            series: [
                {
                    type: 'map',
                    mapType: 'SEOUL', // 自定义扩展图表类型
                    aspectScale:1,
                    // 自定义名称映射
                    cursor:'default',
                    itemStyle: {
                        normal: {
                            borderColor: '#f00',
                            areaColor: '#f00',
                            borderWidth: 0
                        },
                        emphasis: {
                            areaColor: '#f00',
                            borderWidth: 0
                        }
                    },
                }
            ]
        });
    });
});
</script>

</body>
</html>