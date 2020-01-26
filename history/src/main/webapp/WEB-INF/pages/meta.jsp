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
		<h6>City</h6>
		<input ng-model="city.name"/><input ng-model="city.latitude"/><input ng-model="city.longitude"/>
		<select ng-model="city.type">
			<option>city</option>
			<option>waypoint</option>
		</select>
		<button ng-click="addCity(city)">add city</button>	
		</br>
		
		<input ng-model="cityName"/>
		<select ng-model="cityId" ng-change="getSnapshot()">
			<option value="{{city.id}}" ng-repeat="city in cities | toArray:false  | filter : {'name':cityName}">{{city.id}}{{city.name}}</option>
		</select>
		
		<button ng-click="getSnapshot(cityId)">snapshot</button>	
		<button ng-click="addSnapshot(cityId)">add snapshot</button>	
				
		<button ng-click="unuse(cityId)">unuse</button>	
		<br/>
		<div ng-repeat="snapshot in snapshots | toArray:false  | orderBy : 'year'">
			<input ng-model="snapshot.year" ng-change="changeSnapshot(snapshot)"/> {{snapshot.faction}} <input ng-model="snapshot.population" ng-change="changeSnapshot(snapshot)"/>
			<input ng-model="snapshot.name" ng-change="changeSnapshot(snapshot)"/>
		</div>		
		
		<input ng-model="type"/>
		<input ng-model="value1"/>		
		<input ng-model="value2"/>		
		<button ng-click="sub(cityId,type,value1,value2)">Sub</button>	
		
		<hr/>
		
		<h6>Faction</h6>
		<input ng-model="factionName"/>
		<select ng-model="factionId" ">
			<option value="{{faction.id}}" ng-repeat="faction in factions | toArray:false  | filter : {'name':factionName}">{{faction.id}}{{faction.name}}</option>
		</select>
		<br/>
		<input ng-model="factions[factionId].name" ng-change="editFaction(factions[factionId])"/><input ng-model="factions[factionId].color"  ng-change="editFaction(factions[factionId])"/>
		<input ng-model="factions[factionId].region" ng-change="editFaction(factions[factionId])"/>
		<input ng-model="factions[factionId].area" ng-change="editFaction(factions[factionId])"/>

		<br/>
		<input ng-model="name"/><input ng-model="color"/>
		<button ng-click="addFaction(name,color)">add faction</button>	
		
		<hr/>
		<h6>Scenario</h6>
		
		<input ng-model="name"/><input ng-model="year"/>
		<button ng-click="addScenario(name,year)">new scenario</button>	
		<br/>
		<select ng-model="selectedScenario" ng-options="scenario as scenario.name for scenario in scenarios">
		</select> 
		<br/>
		
		<input ng-model="selectedScenario.name" ng-change="editScenario(selectedScenario)"/> 		
		<input ng-model="selectedScenario.age" ng-change="editScenario(selectedScenario)"/> 		
		<input type="checkbox" ng-model="selectedScenario.yn" ng-change="editScenario(selectedScenario)"/> <br/>
		<textarea ng-model="selectedScenario.description" ng-change="editScenario(selectedScenario)" style="width:500px;">

		</textarea>

		<hr/>
		
		<h6>Hero</h6>
		<input ng-model="name"/>
		<input ng-model="birth"/>
		<input ng-model="valor"/>
		<input ng-model="wisdom"/>
		<input ng-model="authority"/>
		<button ng-click="add(name,birth,valor,wisdom,authority)">Add Hero</button>	
		<br/>
		
		<br/>
		
		<input ng-model="heroName"/>
		<select ng-model="heroId" ">
			<option value="{{hero.id}}" ng-repeat="hero in heroes | toArray:false  | filter : {'name':heroName}">{{hero.id}}{{hero.name}}</option>
		</select>
		<br/>
		<input ng-model="heroes[heroId].name" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].birth" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].valor" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].wisdom" ng-change="editHero(heroes[heroId])"/>
		<input ng-model="heroes[heroId].authority" ng-change="editHero(heroes[heroId])"/>		

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

	$scope.unuse = function(id){
		$http.put("data/unuse.do",id)
	    .then(function(response) {
	    });
		
	}
	
	$scope.sub = function(id,type,value1,value2){
		$http.post("data/city/sub.do",{city:id,type:type,value1:value1,value2:value2})
	    .then(function(response) {
	    });		
	}

	
	$scope.add = function(name,birth,valor,wisdom,authority){
		$http.post("data/hero.do",{
			name:name,
			birth:birth,
			valor:valor,
			wisdom:wisdom,
			authority:authority
		}).then(function(response) {
	    });		
	}

	
	$scope.getCities = function(){
		$http.get("data/cities.do")
	    .then(function(response) {
	    	$scope.cities = {};
	        response.data.forEach(function(city) {
	        	$scope.cities[city.id] = city
	        });
	    });
	}
	

	$scope.getSnapshot = function(id){
		$http.get("data/city/snapshot.do?city="+id)
	    .then(function(response) {
	    	
	    	var list = response.data;
			$scope.snapshots = list;
	//		$scope.getHeroSubs();
	    	
	    });
		
	}
	
	$scope.getFaction = function(){
		$http.get("data/faction.do")
	    .then(function(response) {
	    	var list = response.data;
			angular.forEach(list,function(faction){
				
				
				$scope.factions[faction.id] = faction;
		 	});
			
//			$scope.getSnapshot();
	    	
	    });
		
	}

	$scope.getScenario = function(){
		$http.get("data/scenario.do")
	    .then(function(response) {
	    	var list = response.data;
	    	$scope.scenarios = list;
	    	
	    });
		
	}
	
	$scope.addFaction = function(name,color){
		$http.post("data/faction.do",{
			name:name,
			color:color
		})
	    .then(function(response) {
	    	
	    });
		
	}
	$scope.editFaction = function(faction){
		$http.put("data/faction.do",{
			name:faction.name,
			color:faction.color,
			id:faction.id,
			region:faction.region,
			area:faction.area			
		})
	    .then(function(response) {
	    	
	    });
		
	}
	
	$scope.editScenario = function(scenario){
		$http.put("data/scenario.do",{
			id:scenario.id,
			name:scenario.name,
			age:scenario.age,
			yn:scenario.yn,
			description:scenario.description
		})
	    .then(function(response) {
	    	
	    });
		
	}

	$scope.editHero = function(hero){
		$http.put("data/hero.do",{
			id:hero.id,
			name:hero.name,
			birth:hero.birth,
			valor:hero.valor,
			wisdom:hero.wisdom,
			authority:hero.authority
		})
	    .then(function(response) {
	    	
	    });
		
	}
	
	
	$scope.getParties = function(){

		$http.get("data/parties.do")
	    .then(function(response) {
	    	$scope.parties = {};
	        response.data.forEach(function(party) {
	        	$scope.parties[party.id] = party;
	        });
	
	    });
	
	}
	
	$scope.getItems = function(state) {
		$http.get("data/items.do?state="+state)
	    .then(function(response) {
	        $scope.items = response.data;
	        
	        $scope.items.forEach(function(item) {
	        	$scope.getCandidates(state,item);
        	});
	    });

    };
    
    $scope.getCandidates = function(state,item){
    	$http.get("data/candidates.do?state="+state+"&item="+item.id)
	    .then(function(response) {
	    	item.candidates = response.data;
	    });	  
    };
    
    $scope.addPerson = function(name) {
		$http.post("data/person.do",{name:name})
	    .then(function(response) {
	    	 $scope.getPersons();
	    });		
	};

    $scope.addParty = function(party) {
		$http.post("data/party.do",party)
	    .then(function(response) {
	    	 $scope.getParties();
	    });		
	};
    $scope.addZone = function(party) {
		$http.post("data/zone.do",party)
	    .then(function(response) {
	    });		
	};

	$scope.copy = function(inspection){
    	$http.post("data/copy.do",inspection)
	    .then(function(response) {
	    	$scope.getInspections();
//	    	 $scope.getParties();
	    });		
		
	}
    $scope.addInspection = function() {
    	$http.post("data/inspection.do")
	    .then(function(response) {
	    	$scope.getInspections();
//	    	 $scope.getParties();
	    });		
	};

	
	$scope.addItem = function() {
		var state = $scope.currentState;
		$http.post("data/item.do",state)
	    .then(function(response) {
	    	 $scope.getItems(state.id);
	    });		
	};

	$scope.editItem = function(item) {
		$http.put("data/item.do",item)
	    .then(function(response) {
	    });
	};

	$scope.addCandidate = function(state,item) {
		$http.post("data/candidate.do",item)
	    .then(function(response) {
	    	$scope.getCandidates(item.state,item);
	    });		
	};
	
	$scope.editCandidate = function(candidate) {
		$http.put("data/candidate.do",candidate)
	    .then(function(response) {
	    });
	};
	
	$scope.editInspection = function(inspection) {
		$http.put("data/inspection.do",inspection)
	    .then(function(response) {
	    });
	};

	$scope.changeSnapshot = function(selected){
		$http.put("data/snapshot.do",{
			snapshot:selected.id,
			id:selected.city,
			year:selected.year,
			faction:selected.faction,
			population:selected.population,
			name:selected.name
		}).then(function(){
			
		})		
	}


	$scope.addCity = function(city){
		$http.post("data/city.do",city).then(function(response) {
	    });		
	}

	$scope.addScenario = function(name,year){
		$http.post("data/scenario.do",{
			name:name,
			year:year
		}).then(function(response) {
	    });		
	}

	
	$scope.addSnapshot = function(id){
		$http.post("data/snapshot.do",{
			id:id,
			population:0,
			year:0
		}).then(function(){
			
		})		
	}

	
	$scope.getCities();
	$scope.getHeroes();
	$scope.getFaction();
	$scope.getScenario();
//	$scope.getParties();
// 	$scope.getInspections();

});
</script>

</body>
</html>