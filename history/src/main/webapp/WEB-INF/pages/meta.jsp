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
		<select ng-model="personId" >
			<option value="{{person.id}}" ng-repeat="person in persons | toArray:false  | orderBy:ord">{{person.id}}{{person.name}}</option>
		</select>
		<select ng-model="ord"> 
			<option>name</option>
			<option>-id</option>
		</select>
		<input ng-model="personName"/>
		<select ng-model="personId" >
			<option value="{{person.id}}" ng-repeat="person in persons | toArray:false  | filter : {'name':personName}">{{person.id}}{{person.name}}</option>
		</select>
		
	  	<button class="btn-primary" ng-click="addPerson(personName)">Add Person</button>
	  	<button class="btn-primary" ng-click="setPhoto(personId)">Set Photo</button>
	  	
	  	<br>
	  	<br>
		<input ng-model="party.name"/>
		<input ng-model="party.color"/>
		<input ng-model="party.textColor"/>
	  	<button class="btn-primary" ng-click="addParty(party)">Add Party</button>
	  	<br>
	  	<input ng-model="zone.name"/>
		<input ng-model="zone.code"/>
	  	<button class="btn-primary" ng-click="addZone(zone)">Add Zone</button>
	  	<br>
	  	
<!-- 	  	<button class="btn-primary" ng-click="addInspection()">Add Inspection</button> -->
	  	
	  	
	  	<pre>
	  	
	  	
	  	</pre>
	</div>
	
 </div>
 
 <script>
var app = angular.module('myApp', ['angular-toArrayFilter']);
app.controller('myCtrl', function($scope,$http) {
	
	$scope.party = {};
	$scope.zone = {};
	
	$http.get("data/elections.do")
    .then(function(response) {
        $scope.elections = response.data;
    });
	


	
	
	if(window.location.href.indexOf("localhost")>0){
		$scope.logged = true;
	}else{
// 		window.location.href = "http://cryslub1.cafe24.com/dclink/";
	}

	$scope.login = function(){
		$scope.logged=true;
	}

	$scope.setPhoto = function(id){
		$http.put("data/photo.do",id)
	    .then(function(response) {
	    });
		
	}
	

	$scope.getPersons = function(){
		$http.get("data/persons.do")
	    .then(function(response) {
	    	$scope.persons = {};
	        response.data.forEach(function(person) {
	        	$scope.persons[person.id] = person
	        });
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


	$scope.getPersons();
	$scope.getParties();
// 	$scope.getInspections();

});
</script>

</body>
</html>