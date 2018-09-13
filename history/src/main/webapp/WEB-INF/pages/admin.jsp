<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html >
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/glyphicon.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
  <script src="js/ui-bootstrap-tpls-2.5.0.min.js"></script>

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
	<div class="navbar navbar-expand-lg  navbar-dark bg-primary">
		      <div class="container">
		      <a class="navbar-brand" href="http://xsfm.co.kr/" target="xsfm">XSFM 그것은 알기 싫다 <small> 선거 데이터 센트럴 정리 </small></a> 
		      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation" style="">
		                  <span class="navbar-toggler-icon"></span>
		                </button>
				 <div class="collapse navbar-collapse" id="navbarColor01">
		                  <ul class="navbar-nav mr-auto">
		                   <li class="nav-item dropdown">
		              <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="download" aria-expanded="false">선거분류 <span class="caret"></span></a>
		              <div class="dropdown-menu" aria-labelledby="download">
		                <a class="dropdown-item" href="#" ng-repeat="election in elections" ng-click="selectElection(election)">{{election.name}}</a>
		              </div>
		            </li>
		                    
		                  </ul>
		
		                </div>               
		     </div>
		   </div>
		    
		<div id="myTabContent" class="tab-content" style=" width: 98%;">
		  <div class="tab-pane fade show active" id="home">
			
			
		<br>
			
			<div class="row">
			  <div class="col-sm-2">
			  	<ul class="nav nav-pills  flex-column">
				  <li class="nav-item" ng-repeat="state in states">
				  	<a href="#"   data-toggle="tab"  class="nav-link" ng-class="{active:$first}" ng-click="selectState(state)">{{state.name}}</a>
				  </li>
			
				</ul>
			  </div>
			  <div class="col-sm-10">
	
			  
			  	<button class="btn-primary" ng-click="addItem(state.id)">Add Item</button>
			  	
				  	<div ng-repeat="item in items">
				  		<input ng-model="item.name" ng-blur="editItem(item)"></input> 
				  		<input ng-model="item.title" ng-blur="editItem(item)" size="6"></input> 				  		
				  		<input ng-model="item.link" ng-blur="editItem(item)"></input>
				  		<input ng-model="item.code" ng-blur="editItem(item)"></input> 
				  		<input ng-model="item.zone" ng-blur="editItem(item)"></input> 
				  		<input ng-model="item.type" ng-blur="editItem(item)"></input> 

						<select ng-change="editItem(item)" ng-model="item.person" ng-options="person.id as person.name for person in persons | toArray:false  | orderBy:'-id'"></select> 
			  			<select ng-change="editItem(item)" ng-model="item.party" ng-options="party.id as party.name for party in parties"></select> 
				  		<input ng-model="item.x" ng-blur="editItem(item)" size="3"></input> 
				  		<input ng-model="item.y" ng-blur="editItem(item)" size="3"></input> 
				  			
							<button class="btn-primary" ng-click="addCandidate(state.id,item)">Add</button>	
				    	<br>
				    	
					  	  <div class="row">
							<div class="col-sm-3" ng-repeat="candidate in item.candidates">
							   <div class="card mb-3" style="max-width: 20rem;border-color:{{parties[candidate.party].color}} !important" >
								  <div class="card-header">
<!-- 								  	<select ng-change="editCandidate(candidate)" ng-model="candidate.person" ng-options="person.id as person.name for person in persons | toArray:false  | orderBy:'-id'"></select>  -->
									<input style="width:50px;" size=5 type="number" ng-blur="editCandidate(candidate)" ng-model="candidate.person"/> {{persons[candidate.person].name}}
								  	<select ng-change="editCandidate(candidate)" ng-model="candidate.party" ng-options="party.id as party.name for party in parties"></select> 
	
						  			<input ng-model="candidate.link" ng-blur="editCandidate(candidate)"></input>
						  			<input  ng-model="candidate.txt" ng-blur="editCandidate(candidate)"></input>
						  			<input  ng-model="candidate.rate" type="number" ng-blur="editCandidate(candidate)"></input>

										<button   class="btn-primary" ng-click="addSub(candidate);">Add Sub</button>
								  </div>
								  <div class="card-body" ng-if="candidate.count>0">
									<div ng-repeat="sub in candidate.subs">
								  		<input ng-model="sub.txt" ng-blur="editSub(sub)"></input> 
							  			<input ng-model="sub.link" ng-blur="editSub(sub)"></input>
									</div>
								</div>
								</div>
								
					 		</div>							  
				
				 		</div>
				 		
				 		<div ng-if="item.type=='광역'  || item.type=='기초'">
				 			<button class="btn-primary" ng-click="addCouncil(state.id,item)">Add</button>	
			  					
				 				<div class="row">
				 					<div  ng-repeat="council in item.councils">				 						
								  	<select ng-change="editCouncil(council)" ng-model="council.party" ng-options="party.id as party.name for party in parties"></select> <br/>
					 					
						  			<input  ng-model="council.count" type="number"  ng-blur="editCouncil(council)"></input><br/>
						  			<select ng-change="editCouncil(council)" ng-model="council.type" >
						  				<option>metro</option><option>member</option><option>rate</option><option>mrate</option></select> 
						  			
				 					</div>
				 				</div>
		 			
				 		</div>
				  	</div>
				  	
				  
				   
					
				</div>
			  
			  
			  </div>
			</div>
		
		
		
		</div>
	</div>
	
	
	
 </div>
 
 <script>
var app = angular.module('myApp', ['angular-toArrayFilter']);
app.controller('myCtrl', function($scope,$http) {
	
	
	$http.get("data/elections.do")
    .then(function(response) {
        $scope.elections = response.data;
        $scope.getStates($scope.elections[0].id);
        $scope.currentElection = $scope.elections[0];
    });

	
	
	$scope.getStates = function(election){
		$http.get("data/states.do?election="+election)
	    .then(function(response) {
	        $scope.states = response.data;       
	        $scope.getItems($scope.states[0].id);
	        $scope.currentState = $scope.states[0];

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
	
	$scope.selectElection =function(election){
        $scope.currentElection = election;
		 $scope.getStates(election.id);
	}

	$scope.selectState =function(state){
		 $scope.currentState = state;

		 $scope.getItems(state.id);
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
	    	
	    	$scope.items = {};
	    	
	    	response.data.forEach(function(item){
	    		item.candidates = [];
	    		item.councils = [];

	    		$scope.items[item.id] = item;
	    		
	    	});

    		$http.get("data/candidates.do?state="+state)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(candidate) {
    	    		
    	    		$scope.items[candidate.item].candidates.push(candidate);
    	        	$scope.getSubs(candidate);
            	});

    	    });

    		$http.get("data/councils.do?state="+state)
    	    .then(function(response) {
    	    	
    	    	response.data.forEach(function(council) {
    	    		
    	    		$scope.items[council.item].councils.push(council);
            	});

    	    });

	    });

    };
    
    
    $scope.getCandidates = function(state,item){
    	$http.get("data/candidates.do?state="+state+"&item="+item.id)
	    .then(function(response) {
	    	item.candidates = response.data;
	        
	    	item.candidates.forEach(function(candidate) {
	        	$scope.getSubs(candidate);
        	});
	    });	  
    };
    
    $scope.addPerson = function(name) {
		$http.post("data/person.do",{name:name})
	    .then(function(response) {
	    	 $scope.getPersons();
	    });		
	};

    $scope.addParty = function(name) {
		$http.post("data/party.do",{name:name})
	    .then(function(response) {
	    	 $scope.getParties();
	    });		
	};
	
	$scope.addItem = function() {
		var state = $scope.currentState;
		state.election = $scope.currentElection.id;
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
		var state = $scope.currentState;
		

		$http.post("data/candidate.do",item)
	    .then(function(response) {
	    	 $scope.getItems(state.id);
	    });		
	};
	
	$scope.addCouncil = function(state,item) {
		var state = $scope.currentState;

		$http.post("data/council.do",item)
	    .then(function(response) {
	    	 $scope.getItems(state.id);
	    });		
	};

	
	$scope.editCandidate = function(candidate) {


		$http.put("data/candidate.do",candidate)
	    .then(function(response) {
	    });
	};

	$scope.editCouncil = function(council) {
		$http.put("data/council.do",council)
	    .then(function(response) {
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
	
	$scope.addSub = function(candidate) {
		$http.post("data/sub.do",candidate)
	    .then(function(response) {
	    	candidate.count++;
	    	$scope.editCandidate(candidate);
	    	$scope.getSubs(candidate);
	    });		
	};
	
	$scope.editSub = function(sub) {
		$http.put("data/sub.do",sub)
	    .then(function(response) {
	    });
	};

	$scope.getPersons();
	$scope.getParties();

});
</script>

</body>
</html>