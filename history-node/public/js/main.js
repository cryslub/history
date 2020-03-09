

class Main{
	constructor($http,$filter,option){
		
	

		
	var self = this;


	
	self. $http = $http;
	self. $filter = $filter;
	
	self. roads;
	self. cities ={};
	self. showUnuse = false;
	self. factions = {0:{name:'None',id:0}};
	self. activeFactions = {};
	self.region = {};

	 
	 self. objectMap = {};
	 self. objects =[];
	 
	 self. citiesArray = Object.values(self.cities);
	 self. cityMap = {};
	 self. snapshotMap = {};
	 self. roadMap = {};
	 self.era = {ancient:[],classical:[],medieval:[],renaissance:[]};
	 

	 self. lineCoord = [];
	 
		self. data = [];
		
		
	 self. globe = DAT.Globe(document.getElementById('container'), {
		 colorFn:function(label) {
		    return new THREE.Color([][label]);
		  },  
	 	onClick: function(event,camera,scene){
	 		option.onClick(event,camera,scene,self);
	 		
	 	  },
	 	  
	 	 onMouseover : function(mouse,camera,scene){

		 		option.onMouseover(mouse,camera,scene,self);

	 	 }
			
	 });
	 

	 $('body').popover({
		    selector: "[data-toggle='popover']",
		    trigger: 'hover',
		    html: true
		});
		
	 
	 

		self.getFaction(function(){
			self.getScenario();
		});
		

		//self.moveCameraTo(34,40);
		
		self.globe.animate();

		
		
		
	    document.body.style.backgroundImage = 'none'; // remove loading
	    
	    self.refreshTargets = true;
	    
	}

	  getSelected(mouse,camera,scene,callback){
		 
		  var self = this;
		  
		  var raycaster = new THREE.Raycaster();
		  raycaster.setFromCamera( mouse, camera );
		  
		  var intersects = raycaster.intersectObjects( self.objects );
		
		 self.clicked = [];
	// console.log(intersects.length);
		 intersects.forEach( function(intersect){
		 	if(self.objectMap[intersect.object.id] != undefined){
		 		self.clicked.push(self.objectMap[intersect.object.id]);
		 	}
		 });
		 
		 
		 if(self.clicked.length>0){
			 
			 callback(self.clicked,self.objectMap[intersects[0].object.id]);
			 
			 return true;
		 }
		 
		 return false;
	 }
	 

	 getScenario(){
		  var self = this;
		  

			self.startLoading();
			
			this.$http.get("data/scenario")
		    .then(function(response) {
		    	
		    	self.scenarios = response.data;
		    	
		    	self.selectScenario(self.scenarios[0]);
		    	
		    	self.scenarios.forEach(function(scenario){
		    		if(scenario.yn){
			    		var era = "";
			    		if(scenario.year <=-500){
			    			era ="ancient";
			    		}else if(scenario.year > -500 && scenario.year <= 500){
			    			era ="classical";		    			
			    		}else if(scenario.year > 500 && scenario.year <= 1400){
			    			era ="medieval";		    			
			    		}else if(scenario.year > 1400){
			    			era ="renaissance";		    			
			    		}
			    		
		    			self.era[era].push(scenario);
		    		}

		    	})
		    	
		    });
			
		}


		
		getRoad (scenario){
			var self = this;
			self.$http.get("data/road/scenario/"+scenario)
		    .then(function(response) {
		    	
		    	self.roadMap = {};
		    	
		    	var lines = response.data;
				angular.forEach(lines,function(line){
					
					self.roadMap[line.road] = line;
			 	});
				
				
				self.getRoadSubs ();
		    	
		    });
			
		}
		
		getRoadSubs(){
			var self = this;

			self.$http.get("data/road/sub")
		    .then(function(response) {
		    	var list = response.data;
				angular.forEach(list,function(sub){
					
					var road = roadMap[sub.road];
					if(sub.type == 'waypoint'){
					// road.
					}
			 	});
				
				
				self.lineCoord = [];
				angular.forEach(self.roadMap,function(line){
					
					if(line.waypoint != ""){
						var a = 0;
					}
					if(self.cities[line.start] != undefined && self.cities[line.end] != undefined){

						if(self.cities[line.start].yn && self.cities[line.end].yn){
// line.type ='road';
							line.destinies = [{road:line,city:self.cities[line.start]},{road:line,city:self.cities[line.end]}];
							line.forces = [];
							
							self.cities[line.start].destinies.push({road:line,city:self.cities[line.end]});
							self.cities[line.end].destinies.push({road:line,city:self.cities[line.start]});

							self.lineCoord.push({start:self.cities[line.start],end:self.cities[line.end],waypoint:line.waypoint,type:line.type});
							
						}
					}
			 	});
				
				self.roads = self.globe.addLines(self.lineCoord);

				var interval = setInterval(function(){ 
					if(self.globe.loaded){
						self.closeLoading();					
						 clearInterval(interval);
					}
				}, 1000);
				
		    });		
		}

		
		
		
		getFaction(fn){
			var self = this;
			
			self.$http.get("data/faction")
		    .then(function(response) {
		    	var list = response.data;
				angular.forEach(list,function(faction){
					
					faction.cities = [];
					faction.forces = [];
					faction.targeted = [];
					
					self.factions[faction.id] = faction;
			 	});
				
				fn();
				
// self.getSnapshot();
		    	
		    });
			
		}
		
		
		
		selectScenario (scenario){
			var self = this;
			
			self.selectedScenario=scenario;
			
			self.cities = {};
			
			self.cityMap = {};
			self.snapshotMap = {};
			self.cities = {};
			self.selectedFaction = 0;
			
			
			
			self.startLoading();
			
			self.$http.get("data/scenarioCities/"+scenario.id)
		    .then(function(response) {
		    	
		    	var list = response.data;
		    	self.data = [];
		    	self.activeFactions = {};
		    	self.region = {};
		    	
			 	angular.forEach(list,function(city){
			 		
			 		var c = new City(city,self);
			 		
			 		self.cities[city.id] = c;
			 		
			 		
			 		self.data.push(c)
			 		
			 		self.cityMap[city.id] = c;
			 		self.snapshotMap[city.snapshot] = c;
			 		

			 		if(self.activeFactions[city.faction] == undefined && city.yn && city.faction !=0){
				 		self.activeFactions[city.faction] = self.factions[city.faction];	
				 		self.activeFactions[city.faction].cities = [];
					}
			 		if(self.activeFactions[city.faction] != undefined && city.yn ){
			 			self.activeFactions[city.faction].cities.push(c);
			 		}
			 	});
			 	
			 	
			 	angular.forEach(self.activeFactions,function(faction){
			 		if(faction.region != null){
			 			if(self.region[faction.region] == undefined){
			 				self.region[faction.region] = {};
			 			}
			 			if(self.region[faction.region][faction.area] == undefined){
			 				self.region[faction.region][faction.area] = [];
			 			}
			 			self.region[faction.region][faction.area].push(faction);
			 		}
			 	});
			 	
		       window.data = self.data;
		       
		       
		       
		       
		       self.addData(scenario);
		       
		       

		       self.citiesArray = Object.values(self.cities);

			  	
		       
			  	
			  	
		       	setTimeout(function(){
		       		$('#faction li:first-child a').tab('show');
		       	},100);
			  	
			  	 
		    });
			
		}
		
		addData(scenario){
		
			var self = this;
			
			var data = [];

			if(self.roads != undefined){
				self.globe.remove(self.roads);						
			}
			angular.forEach(self.objectMap,function(city){
				self.globe.remove(city.object);			
			});
			
			window.data.forEach(function(city){
				
				if(self.showUnuse || city.yn){
					data.push(city);
				}	
			});
			
			self.globe.addData(data, {format: 'legend'});
			
			self.objects = [];
	       data.forEach(function(city){
	    	   if(city.object != undefined){
	    		   self.objectMap[city.object.id] = city;	    		   
		    	   self.objects.push(city.object);
	    	   }
	       });
	       self.getRoad(scenario.id);
	       
			
		}
		
		selectDialogFaction (faction){
			this.selectedFaction=faction.id;
		}
		
		
		setPopover (id){
			

		}

		moveCameraTo(city){
			this.globe.moveCameraTo(city.latitude,city.longitude);
		}
	    
	 init(){
		 
	 }
	 
	 startLoading(){
		 $('#loading').modal();
	 }
	 
	 closeLoading(){
		 $('#loading').modal('hide');
	 }
}