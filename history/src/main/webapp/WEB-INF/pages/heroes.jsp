<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html >
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://bootswatch.com/4/cosmo/bootstrap.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://bootswatch.com/_vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
		 <script src="js/toArrayFilter.js"></script>	
	
	<style>
	
	
	</style>
	
</head>
<body>


  
<div ng-app="myApp" ng-controller="myCtrl">
	
	<div ng-if="!logged">
		<input></input>
		<input></input>
		<button ng-click="login()">login</button>
	</div>
	<div ng-if="logged">
		

		<h6>Hero</h6>
		Name: <input ng-model="name"/>
		Life:<input ng-model="birth"/>
		~<input ng-model="death"/>
		Valor:<input ng-model="valor"/>
		Wisdom:<input ng-model="wisdom"/>
		Authority:<input ng-model="authority"/>
		Portrait:<input ng-model="portrait"/>

		<button ng-click="add(name,birth,death,valor,wisdom,authority,portrait)">Add Hero</button>	
		<br/>
		
		<br/>
		
		<input ng-model="heroName"/>
		<select ng-model="heroId" ">
			<option value="{{hero.id}}" ng-repeat="hero in heroes | toArray:false  | filter : {'name':heroName}">{{hero.id}}{{hero.name}}</option>
		</select>
		<br/>
		<input ng-model="heroes[heroId].name" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].birth" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].death" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].valor" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].wisdom" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].authority" ng-change="editHero(heroes[heroId])"/>		
		<input ng-model="heroes[heroId].portrait" ng-change="editHero(heroes[heroId])"/>		


<hr/>
		<select ng-model="selectedScenario" ng-options="scenario as scenario.name for scenario in scenarios" ng-change="selectScenario(selectedScenario)">
		</select> 

		<input ng-model="year"  type="number"/> 
		<select ng-model="sort">
			<option value="-valor"> valor</option>
			<option value="-wisdom"> wisdom</option>
			<option value="-authority"> authority</option>
		</select>
		<div ng-repeat="hero in heroes| toArray:false | orderBy:sort" ng-if="hero.birth <= selectedScenario.year && selectedScenario.year <= hero.death">
			<input ng-model="hero.name" ng-change="editHero(hero)"/>
			<input ng-model="hero.birth" type="number" ng-change="editHero(hero)"/>
			<input ng-model="hero.death" type="number" ng-change="editHero(hero)"/>
			<input ng-model="hero.valor" type="number" ng-change="editHero(hero)"/>
			<input ng-model="hero.wisdom" type="number" ng-change="editHero(hero)"/>
			<input ng-model="hero.authority" type="number" ng-change="editHero(hero)"/>		
			<input ng-model="hero.portrait" ng-change="editHero(hero)"/>		
			{{hero.city}}
		</div>

	</div>
	
 </div>
 
 <script>
var app = angular.module('myApp', ['angular-toArrayFilter']);
app.controller('myCtrl', function($scope,$http) {
	
	$scope.party = {};
	$scope.zone = {};
	$scope.heroes={};
	$scope.snapshots=[];
	$scope.factions={};
	
	$scope.city={
		name:'',
		type:'city',
		latitude:0,
		longitude:0			
	}
	
	$http.get("data/elections.do")
    .then(function(response) {
        $scope.elections = response.data;
    });
	

	$scope.getHeroes = function(){
		$http.get("data/hero.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(hero){
				
				hero.sub = [];
				hero.nameImage = {};
				$scope.heroes[hero.id] = hero;
		 	});
			
	//		$scope.getHeroSubs();
	    	
	    });
		
	}

	
	
	
	
	if(window.location.href.indexOf("localhost")>0){
		$scope.logged = true;
	}else{
// 		window.location.href = "http://cryslub1.cafe24.com/dclink/";
	}

	$scope.login = function(){
		$scope.logged=true;
	}

	$scope.add = function(name,birth,death,valor,wisdom,authority,portrait){
		$http.post("data/hero.do",{
			name:name,
			birth:birth,
			death:death,
			valor:valor,
			wisdom:wisdom,
			authority:authority,
			portrait:portrait			
		}).then(function(response) {
	    });		
	}

	$scope.selectScenario = function(selectedScenario){
		$scope.getScenarioCitySub(selectedScenario);
	}

	$scope.getScenario = function(){
		$http.get("data/scenario.do")
	    .then(function(response) {
	    	var list = response.data;
	    	$scope.scenarios = list;
	    	
	    });
		
	}

	$scope.getScenarioCitySub = function(selectedScenario){
		$http.get("data/scenario/city/sub.do?scenario="+selectedScenario.id)
	    .then(function(response) {
	    	
	    	var list = response.data;
			angular.forEach(list,function(sub){
					if($scope.heroes[sub.hero] == undefined) console.log(sub.hero)
					else $scope.heroes[sub.hero].city = sub.city;
			
			});

	    });
		
	}

	
	
	$scope.editHero = function(hero){
		$http.put("data/hero.do",{
			id:hero.id,
			name:hero.name,
			birth:hero.birth,
			death:hero.death,
			valor:hero.valor,
			wisdom:hero.wisdom,
			authority:hero.authority,
			portrait:hero.portrait			
		})
	    .then(function(response) {
	    	
	    });
		
	}
	
	
	$scope.getHeroes();
	$scope.getScenario();
//	$scope.getParties();
// 	$scope.getInspections();

});
</script>

</body>
</html>