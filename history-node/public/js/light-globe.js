/**
 * dat.globe Javascript WebGL Globe Toolkit
 * https://github.com/dataarts/webgl-globe
 *
 * Copyright 2011 Data Arts Team, Google Creative Lab
 *
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 */

var DAT = DAT || {};

DAT.Globe = function(container, opts) {
  opts = opts || {};
  
  var colorFn = opts.colorFn || function(x) {
    var c = new THREE.Color();
    c.setHSL( ( 0.6 - ( x * 0.5 ) ), 1.0, 0.5 );
    return c;
  };
  var imgDir = opts.imgDir || '/history/';

  
  var Shaders = {
    'earth' : {
      uniforms: {
        'texture': { type: 't', value: null }
      },
      vertexShader: [
        'varying vec3 vNormal;',
        'varying vec2 vUv;',
        'void main() {',
          'gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );',
          'vNormal = normalize( normalMatrix * normal );',
          'vUv = uv;',
        '}'
      ].join('\n'),
      fragmentShader: [
        'uniform sampler2D texture;',
        'varying vec3 vNormal;',
        'varying vec2 vUv;',
        'void main() {',
          'vec3 diffuse = texture2D( texture, vUv ).xyz;',
          'float intensity = 1.05 - dot( vNormal, vec3( 0.0, 0.0, 1.0 ) );',
          'vec3 atmosphere = vec3( 1.0, 1.0, 1.0 ) * pow( intensity, 3.0 );',
          'gl_FragColor = vec4( diffuse + atmosphere, 1.0 );',
        '}'
      ].join('\n')
    },
    'atmosphere' : {
      uniforms: {},
      vertexShader: [
        'varying vec3 vNormal;',
        'void main() {',
          'vNormal = normalize( normalMatrix * normal );',
          'gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );',
        '}'
      ].join('\n'),
      fragmentShader: [
        'varying vec3 vNormal;',
        'void main() {',
          'float intensity = pow( 0.8 - dot( vNormal, vec3( 0, 0, 1.0 ) ), 12.0 );',
          'gl_FragColor = vec4( 1.0, 1.0, 1.0, 1.0 ) * intensity;',
        '}'
      ].join('\n')
    }
  };

  var camera, scene, renderer, w, h;
  var mesh, atmosphere, point;

  var overRenderer;

  var curZoomSpeed = 0;
  var zoomSpeed = 50;

  var mouse = { x: 0, y: 0 }, mouseOnDown = { x: 0, y: 0 };
  var rotation = { x: 0, y: 0 },
      target = { x: Math.PI*3/2, y: Math.PI / 6.0 },
      targetOnDown = { x: 0, y: 0 };

  var distance = 100000, distanceTarget = 100000;
  var padding = 40;
  var PI_HALF = Math.PI / 2;

  var radius = 200;
  
  var textlabels = [];
  var detailHtml;
  
  function init() {

    container.style.color = '#fff';
    container.style.font = '13px/20px Arial, sans-serif';

    var shader, uniforms, material;
    w = container.offsetWidth || window.innerWidth;
    h = container.offsetHeight || window.innerHeight;

    camera = new THREE.PerspectiveCamera(30, w / h, 1, 10000);
    camera.position.z = distance;

    scene = new THREE.Scene();

    var geometry = new THREE.SphereGeometry(200, 40, 30);

    shader = Shaders['earth'];
    uniforms = THREE.UniformsUtils.clone(shader.uniforms);

//    uniforms['texture'].value = THREE.ImageUtils.loadTexture(imgDir+'world.jpg');

    var water =0x4B76C0;
    material =  new THREE.MeshBasicMaterial( {color: 0xAAAAAA} );
//    material = new THREE.ShaderMaterial({
//
//          uniforms: uniforms,
//          vertexShader: shader.vertexShader,
//          fragmentShader: shader.fragmentShader
//
//        });

    mesh = new THREE.Mesh(geometry, material);
    mesh.rotation.y = Math.PI;
    scene.add(mesh);

    shader = Shaders['atmosphere'];
    uniforms = THREE.UniformsUtils.clone(shader.uniforms);

    material = new THREE.ShaderMaterial({

          uniforms: uniforms,
          vertexShader: shader.vertexShader,
          fragmentShader: shader.fragmentShader,
          side: THREE.BackSide,
          blending: THREE.AdditiveBlending,
          transparent: true

        });

    mesh = new THREE.Mesh(geometry, material);
    mesh.scale.set( 1.1, 1.1, 1.1 );
//    scene.add(mesh);

    geometry = new THREE.BoxGeometry(0.75, 0.75, 1);
    geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0,0,-0.5));

    point = new THREE.Mesh(geometry);

    renderer = new THREE.WebGLRenderer({antialias: true});
    renderer.setSize(w, h);

    renderer.domElement.style.position = 'absolute';

    container.appendChild(renderer.domElement);

    container.addEventListener('click', onClick, false);

    container.addEventListener('mousedown', onMouseDown, false);

    container.addEventListener('mousewheel', onMouseWheel, false);

    document.addEventListener('keydown', onDocumentKeyDown, false);

    window.addEventListener('resize', onWindowResize, false);

    window.addEventListener('mousemove', onTouchMove, false);
    
    container.addEventListener('mouseover', function(event) {
      overRenderer = true;
      
    }, false);

    container.addEventListener('mouseout', function() {
      overRenderer = false;
    }, false);
    
    var light = new THREE.PointLight( 0xffffff );
    light.position.z = 300;
    scene.add( light );
    
    
    
    
    var arr = [{
    	file:"json/coastline.json",
    	color:0xffffff,
    	radius:200
    }];
    
    
    arr.forEach(function(item){
        d3.json(item.file, function(error, data) {
        	  if (error) throw error;
//        	  scene.add(graticule = wireframe(graticule10(), new THREE.LineBasicMaterial({color: 0xaaaaaa})));
//        	  scene.add(mesh = wireframe(topojson.mesh(topology, topology), new THREE.LineBasicMaterial({color: 0x4682B4})));

        	  var geo = new THREE.Geometry;

        	  data.geometries.forEach(function(geometry) {
        		  
        		  if(geometry.type == 'LineString'){
        			  drawLines(geo,geometry.coordinates);
        		  }
        		  
        		  if(geometry.type == 'MultiLineString'){
        			geometry.coordinates.forEach(function(coordinates){
          			  drawLines(geo,coordinates);  				
        			});
        		  }
      	  });
      		  
      		  
      		scene.add( new THREE.LineSegments(geo, new THREE.LineBasicMaterial({color: item.color})));

        	});
    });


    
   
    
    

	var materials = [
		  new THREE.MeshBasicMaterial({
		        color: 0x9F907A,
		        morphTargets: false,
		        side: THREE.DoubleSide
		      }),
		      
		new THREE.MeshBasicMaterial({
	        color: 0x0F5C0F,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({  //desert
	        color: 0xFFE99E,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({ //stone
	        color: 0x9F907A,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
    
      new THREE.MeshBasicMaterial({
	        color: 0x297229,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({
	        color: 0x9E8C5B,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({
	        color: 0x665147,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({
	        color: 0xFFE6B3,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({ ////dry grassland
	        color: 0x74896C,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({
	        color: 0xffffff,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      }),
      new THREE.MeshBasicMaterial({ // thick forest
	        color: 0x0D490D,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      })

	]

	var map =[
		0,
		1,
		4,
		6,
		4,
		3,
		1,
		4,
		5,
		5,
		5,
		3,
		4,
		2,
		3
	]
	
   
    
//    $.getJSON("json/ocean.json", function(data) {

//    	drawGeoJson(0x1E90FF,data);
		  
//    });
		
  }
  
  
  function drawLines(geo,coordinates){
	  for(var i = 0 ; i<coordinates.length; i++){
		  if(i>0){
		      geo.vertices.push(vertex(coordinates[i-1]), vertex(coordinates[i]));
		  }  				  
	  }
  }
  
  function drawGeoJson(color,data,radius){

	  var geo = new THREE.Geometry();
		var material =  new THREE.MeshBasicMaterial({
	        color: color,
	        morphTargets: false,
	        side: THREE.DoubleSide
	      });

		
		if(data.type=="GeometryCollection"){
		
		  	data.geometries.forEach(function(geometry){
		  		
		  		if(geometry.type=='MultiPolygon'){
		  			geometry.coordinates.forEach(function(coordinate){
		  				drawCoordinate(geo,coordinate,radius);
		  			});
		  		}else{
		  			
		  			drawCoordinate(geo,geometry.coordinates,radius);
		  		
	
		  		}
		  		
		  	});
		}
		
	
	
	  	var m = new THREE.Mesh( geo, material );
  	
		scene.add(  m);
  }

  
  function drawCoordinate(geo,coordinate,radius,color){
		var d = earcut.flatten(coordinate);
  		var triangles = earcut(d.vertices, d.holes, d.dimensions);
  		
  		
  		var i = 0;

  		for(;i<triangles.length;i+=3){


  			//create a triangular geometry
  			var pointA = new THREE.Vector3(d.vertices[triangles[i]*2],d.vertices[triangles[i]*2+1],0);
  			var pointB = new THREE.Vector3(d.vertices[triangles[i+1]*2],d.vertices[triangles[i+1]*2+1],0);
  			var pointC = new THREE.Vector3(d.vertices[triangles[i+2]*2],d.vertices[triangles[i+2]*2+1]);
  			
  			makeFace(geo,pointA,pointB,pointC,radius,color);
  			
  		}
  		

  }
  
  function makeFace(geo,pointA,pointB,pointC,radius,color){
	  
		var max =2;

		
	   var arr = [{
		   distance:pointA.distanceTo( pointB ),
		   point1:pointA,
		   point2:pointB,
		   point3:pointC		   
	   },{
		   distance:pointA.distanceTo( pointC ),
		   point1:pointA,
		   point2:pointC,
		   point3:pointB		   
	   },{
		   distance:pointB.distanceTo( pointC ),
		   point1:pointB,
		   point2:pointC,
		   point3:pointA		   
	   }]
	  
	   arr.sort(function (a, b) {
		  return b.distance - a.distance;
		});
	   
	   
	   if(arr[0].distance > max){
		   
		   var a = arr[0];
		   
			var dir = new THREE.Vector3();
			
			  dir.subVectors( a.point1, a.point2 ).normalize();
					  
			  dir.multiplyScalar(a.distance/2);
			  
			  var mid = new THREE.Vector3(a.point2.x,a.point2.y,a.point2.z);
			  
			  mid.add(dir);
			  
			  makeFace(geo,a.point1,a.point3,mid,radius,color);
			  makeFace(geo,a.point2,a.point3,mid,radius,color);	
	   }
	   
	   else{
		
		
				
				var a = gpsToVector(pointA.x,pointA.y,radius);
				var b = gpsToVector(pointB.x,pointB.y,radius);
				var c = gpsToVector(pointC.x,pointC.y,radius);
					
				geo.vertices.push(  a);
				geo.vertices.push(  b );
				geo.vertices.push(   c);
		
				var normal = new THREE.Vector3( 0, 1, 0 ); //optional
				var c = new THREE.Color( 0xffaa00 ); //optional
				
				//create a new face using vertices 0, 1, 2
				var face = new THREE.Face3( geo.vertices.length-3,geo.vertices.length-2,geo.vertices.length-1,normal,c,color);
		
			//add the face to the geometry's faces array
				geo.faces.push( face );
		}
	  
  }

  function gpsToVector(lat,long,radius) {
		
	    var phi = (90 - long) * Math.PI / 180;
	    var theta = (180 - lat) * Math.PI / 180;

	    var sphereSize = 200; 
		if(radius != undefined) sphereSize = radius;
		
		  return new THREE.Vector3(
				  sphereSize * Math.sin(phi) * Math.cos(theta),
				  sphereSize * Math.cos(phi),
				  sphereSize * Math.sin(phi) * Math.sin(theta)
		  );		

	}
  
  
	// Converts a point [longitude, latitude] in degrees to a THREE.Vector3.
	function vertex(point,radius) {
		if(point == undefined){
			console.log("point undefined");
			return null;
		}
	    var phi = (90 - point[1]) * Math.PI / 180;
	    var theta = (180 - point[0]) * Math.PI / 180;

	    var sphereSize = 200.1; 
		
	    if(radius != undefined) sphereSize = radius;
	    
		  return new THREE.Vector3(
				  sphereSize * Math.sin(phi) * Math.cos(theta),
				  sphereSize * Math.cos(phi),
				  sphereSize * Math.sin(phi) * Math.sin(theta)
		  );		

	}
	// Converts a GeoJSON MultiLineString in spherical coordinates to a THREE.LineSegments.
	function wireframe(multilinestring, material) {
		
		
		
	  var geometry = new THREE.Geometry;
	  multilinestring.coordinates.forEach(function(line) {
	    d3.pairs(line.map(vertex), function(a, b) {
	      geometry.vertices.push(a, b);
	    });
	  });
	  
	  
	  return new THREE.LineSegments(geometry, material);
	}
	// See https://github.com/d3/d3-geo/issues/95
	

  
  
  function addData(data, opts) {
 
	  
	  textlabels.forEach(function(text){
		 container.removeChild(text.element); 
	  });
	  
	  textlabels = [];
	  
	  if( this._baseGeometry != undefined){
//		  while (scene.children.length>8)
//		  {
//			  scene.remove(scene.children[8]);
//		  }
		  
	  }
	  
	  var lat, lng, size, color, i, step, colorFnWrapper;

    opts.animated = opts.animated || false;
    this.is_animated = opts.animated;
    opts.format = opts.format || 'magnitude'; // other option is 'legend'
    if (opts.format === 'magnitude') {
      step = 3;
      colorFnWrapper = function(data, i) { return colorFn(data[i+2]); }
    } else if (opts.format === 'legend') {
      step = 4;
      colorFnWrapper = function(data, i) { return colorFn(data[i+3]); }
    } else {
      throw('error: format not supported: '+opts.format);
    }

    if (opts.animated) {
      if (this._baseGeometry === undefined) {
        this._baseGeometry = new THREE.Geometry();
        data.forEach(function(city){
            color = colorFnWrapper(data,i);
        	size = 0;
        	addPoint(city, size, color, this._baseGeometry);

        });
      }
      if(this._morphTargetId === undefined) {
        this._morphTargetId = 0;
      } else {
        this._morphTargetId += 1;
      }
      opts.name = opts.name || 'morphTarget'+this._morphTargetId;
    }
    var subgeo = new THREE.Geometry();
    data.forEach(function(city){
        color = colorFnWrapper(data,i);

        if(city.color != null){
        	color = new THREE.Color(city.color);
        
        }
        
        city.object = addPoint(city, city.population, color,subgeo);
        

    });

    if (opts.animated) {
      this._baseGeometry.morphTargets.push({'name': opts.name, vertices: subgeo.vertices});
    } else {
      this._baseGeometry = subgeo;
    }

  }
  
  function addForce(city, size,color) {

    var lat = city.latitude;
    var lng = city.longitude;
    
    addSphere(lat,lng,size,color);

  }
  
  function addUnit(lat,lng,size,color,name) {


   
    var subgeo = new THREE.Geometry();

    color = new THREE.Color(color); 

    
    var geometry = new THREE.CylinderGeometry( 1.5, 1.5, 1,3  );
    var material = new THREE.MeshBasicMaterial( {color: color} );
//		geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0,0,-0.5));

	var point = new THREE.Mesh(geometry,material);

	  
    var phi = (90 - lat) * Math.PI / 180;
    var theta = (180 - lng) * Math.PI / 180;

    var sphereSize = 200; 
    
    point.position.x = sphereSize * Math.sin(phi) * Math.cos(theta);
    point.position.y = sphereSize * Math.cos(phi);
    point.position.z = sphereSize * Math.sin(phi) * Math.sin(theta);

    point.geometry.rotateX((-94 * Math.PI) / 180);
    point.geometry.translate(0,0,-5);
    point.lookAt(mesh.position);

    
    var scale = Math.sqrt(size)/500;
    scale = Math.max( scale, 0.1 );
//		    scale = Math.sqrt(scale);
    point.scale.x = scale;
    point.scale.y = scale;
    point.scale.z = scale; // avoid non-invertible matrix
   

    
//	     this._baseGeometry.morphTargets.push({'name': opts.name, vertices: subgeo.vertices});
     scene.add(point);

     var geo = new THREE.EdgesGeometry( point.geometry );
     var mat = new THREE.LineBasicMaterial( { color: 0x333333, linewidth: 1 } );
     var wireframe = new THREE.LineSegments( geo, mat );
     wireframe.renderOrder = 1; // make sure wireframes are rendered 2nd
     point.add( wireframe );
     
     
     return point;

  }

  function createPoints() {
    if (this._baseGeometry !== undefined) {
    	
    	scene.remove(this.points);

    	
      if (this.is_animated === false) {
        this.points = new THREE.Mesh(this._baseGeometry, new THREE.MeshBasicMaterial({
              color: 0xffffff,
              vertexColors: THREE.FaceColors,
              morphTargets: false
            }));
      } else {
        if (this._baseGeometry.morphTargets.length < 8) {
          console.log('t l',this._baseGeometry.morphTargets.length);
          var padding = 8-this._baseGeometry.morphTargets.length;
          console.log('padding', padding);
          for(var i=0; i<=padding; i++) {
            console.log('padding',i);
            this._baseGeometry.morphTargets.push({'name': 'morphPadding'+i, vertices: this._baseGeometry.vertices});
          }
        }
        this.points = new THREE.Mesh(this._baseGeometry, new THREE.MeshBasicMaterial({
              color: 0xffffff,
              vertexColors: THREE.FaceColors,
              morphTargets: true
            }));
      }
      scene.add(this.points);
    }
  }
  
 

  var roadColors = {
	  "normal":new THREE.Color( 0xAB9B5D),
	  "water":new THREE.Color( 0xA2C5FF),
	  "high":new THREE.Color( 0x6E6957),
	  "mountain":new THREE.Color( 0x588062),
	  "desert":new THREE.Color( 0xC89769) 
  }
  
  function addVertex(geo,start,end,type){
	  geo.vertices.push(start,end);
	  geo.colors.push(	roadColors[type]);	  
	  geo.colors.push(roadColors[type]);	  

  }
  
  function addLines(lines) {
	  
	  var geo = new THREE.Geometry;

	  var radius = 200.1;
		
	  lines.forEach(function(line){
		  
		  if(line.waypoint != "" && line.waypoint != null){
			  var waypoint = JSON.parse(line.waypoint);
			  
			  for(var i = 0;i<waypoint.length;i++){
				  if(i == 0){
					  addVertex(geo,globePoint(line.start.latitude,line.start.longitude,radius),vertex(waypoint[0],radius),line.type);					  
				  }else{
					  addVertex(geo,vertex(waypoint[i-1],radius),vertex(waypoint[i],radius),line.type);
				  }
			  }
			  addVertex(geo,vertex(waypoint[waypoint.length-1],radius),globePoint(line.end.latitude,line.end.longitude,radius),line.type);					  
			  
			  
		  }else{
			  addVertex(geo,globePoint(line.start.latitude,line.start.longitude,radius),globePoint(line.end.latitude,line.end.longitude,radius),line.type);
		  }
		  

	  });
	  
//	  for ( var i = 0; i < geo.vertices.length; i+=2 ) {
//		  geo.colors[ i ] = new THREE.Color( 0xAB9B5D);
//		  geo.colors[ i + 1 ] = geo.colors[ i ];
//		}

	var material = new THREE.LineBasicMaterial( {
	    color: 0xffffff,
	    vertexColors: THREE.VertexColors
	} );
  
	  
	  var mesh  = new THREE.LineSegments(geo, material);
		scene.add( mesh);
		
		return mesh;

  }
  
  
  function addPoint(city, size, color, subgeo) {

	
	var radius = 200.2;
	var geometry;
	
	if(size == 0){
		geometry = new THREE.CylinderGeometry( 0.1, 0.1, 0.25,16  );
		
	    
	}else{
		
		
		geometry = new THREE.BoxGeometry(1, 1, 0.3);
		geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0,0,-0.5));
	}
	
	

	
	
    var material = new THREE.MeshBasicMaterial( {color: color} );

	var point = new THREE.Mesh(geometry,material);


	if(size == 0){
	
		point.geometry.rotateX((-90 * Math.PI) / 180);
	//    point.geometry.translate(0,0,-3);

		
	}else{
	    var scale = Math.cbrt(size)/100;
	    scale = Math.max( scale, 0.3 );
	//    scale = Math.sqrt(scale);
	    point.scale.x = scale;
	    point.scale.y = scale;
	    point.scale.z = scale; // avoid non-invertible matrix
	
	    
	
	    for (var i = 0; i < point.geometry.faces.length; i++) {
	      point.geometry.faces[i].color = color;
	    }
	    
	    
	    addDom(point,city.name,city.labelPosition);

	}

	
	
    var phi = (90 - city.latitude) * Math.PI / 180;
    var theta = (180 - city.longitude) * Math.PI / 180;

    point.position.x = radius * Math.sin(phi) * Math.cos(theta);
    point.position.y = radius * Math.cos(phi);
    point.position.z = radius * Math.sin(phi) * Math.sin(theta);

    point.lookAt(mesh.position);
    
    
    if(point.matrixAutoUpdate){
      point.updateMatrix();
    }
    
    scene.add(point);
    
    var geo = new THREE.EdgesGeometry( point.geometry );
    var mat = new THREE.LineBasicMaterial( { color: 0x111111, linewidth: 4 } );
    var wireframe = new THREE.LineSegments( geo, mat );
    wireframe.renderOrder = 1; // make sure wireframes are rendered 2nd
    point.add( wireframe );
    
    return point;
    
  }
  
  function addDom(point,name,labelPosition){
		var text = createTextLabel();
		text.setHTML(name);
		text.setParent(point);
		textlabels.push(text);
		if(labelPosition =='top'){
			text.element.classList.add("label-top")
		}
		container.appendChild(text.element);
  }
  
  function detail(city,filter){
	 
	  if(detailHtml == undefined){
		  detailHtml = createTextLabel();
		  
	      container.appendChild(detailHtml.element);
	  }	 
	  
	  if(city == undefined){
		  detailHtml.element.className = "text-hide";
		  return;
	  }
	  
	  detailHtml.element.className ="text-detail";
	  
	  var html = "<div><h5>"+city.name+"</h5>";

	  if(city.faction > 0){
		  html +="<strong>"+city.factionData.name+"</strong><br/>";

		  detailHtml.element.style.backgroundColor = city.factionData.color;
	  }else{
		  detailHtml.element.style.backgroundColor = "#000";
		  
	  }
	  if(city.population > 0){
		  html +="<span class='glyphicon glyphicon-user'> </span> "+filter('number')(city.population);
	  }
	  
	  html 	+="</div>";

	  
	 
		  
	  detailHtml.setHTML(html);
	  detailHtml.setParent(city.object);
	  detailHtml.updatePosition(true);

  }
  
  function createTextLabel() {
    var div = document.createElement('div');
    div.className = 'text-label';
    div.style.position = 'absolute';
    div.style.width = 100;
    div.style.height = 100;
    div.innerHTML = "hi there!";
    div.style.top = -1000;
    div.style.left = -1000;
    
    var _this = this;
    
    return {
      element: div,
      parent: false,
      position: new THREE.Vector3(0,0,0),
      setHTML: function(html) {
        this.element.innerHTML = html;
      },
      setParent: function(threejsobj) {
        this.parent = threejsobj;
      },
      updatePosition: function(show) {
        if(parent) {
          this.position.copy(this.parent.position);
        }
        
        var coords2d = this.get2DCoords(this.position, camera);
        this.element.style.left = coords2d.x + 'px';
        this.element.style.top = coords2d.y + 'px';

       
        if(show!=true){
        	var distance = this.parent.position.distanceTo(camera.position);
	        	
        	var a = this.parent.scale.x / 0.3;
        	
        	if(distance < Math.pow(a,2) * 80){
	        	this.element.classList.remove("text-hide");
        	}else{
        		this.element.classList.add("text-hide");
        		
        	}
        	
	        if(distance> 400){
        		this.element.classList.add("text-hide");
	        }
	        
        }

	        	

      },
      get2DCoords: function(position, camera) {
        var vector = position.project(camera);
        vector.x = (vector.x + 1)/2 * window.innerWidth;
        vector.y = -(vector.y - 1)/2 * window.innerHeight;
        return vector;
      }
    };
  } 
    
  
  function globePoint(lat, lng,sphereSize){
    var phi = (90 - lat) * Math.PI / 180;
    var theta = (180 - lng) * Math.PI / 180;

    var point = {};
    point.x = sphereSize * Math.sin(phi) * Math.cos(theta);
    point.y = sphereSize * Math.cos(phi);
    point.z = sphereSize * Math.sin(phi) * Math.sin(theta);
    
    return point;
  }
  
  
  function move(object,target,speed){

	  var dir = new THREE.Vector3();
	  
	  dir.subVectors( target.position, object.position ).normalize();

	 if( object.position.distanceTo(target.position) >= speed){
		  
		  object.position.add(dir.multiplyScalar(speed));
	  
		  return true;
	 }else{
		  object.position.add(dir.multiplyScalar(object.position.distanceTo(target.position)));

		 return false;
	 }
	 // object.position.addScaledVector(target.position.sub(object.position).normalize(), 0.1);
	//   if (target.position.z <= object.position.z) sphere.userData.speed = 0; // stop, when we reached the plane

	//  requestAnimationFrame(animate);
	 // renderer.render(scene, camera);
	  
  }
  
  function distanceTo(object,target){
	  return object.position.distanceTo(target.position);
  }
  
  function remove(object){
	  scene.remove(object);
  }
  
  
  function changeColor(object,color){
	  
	  object.material.color = new THREE.Color(color);	  
	  
  }
  
  function onClick(event){
//	  console.log(event);

	  opts.onClick(event,camera,scene);

  }

  function onMouseDown(event) {
    event.preventDefault();

    container.addEventListener('mousemove', onMouseMove, false);
    container.addEventListener('mouseup', onMouseUp, false);
    container.addEventListener('mouseout', onMouseOut, false);

    mouseOnDown.x = - event.clientX;
    mouseOnDown.y = event.clientY;

    targetOnDown.x = target.x;
    targetOnDown.y = target.y;

    container.style.cursor = 'move';
  }

  function onMouseMove(event) {
    mouse.x = - event.clientX;
    mouse.y = event.clientY;

    var zoomDamp = distance/1000;

    target.x = targetOnDown.x + (mouse.x - mouseOnDown.x) * 0.005 * zoomDamp;
    target.y = targetOnDown.y + (mouse.y - mouseOnDown.y) * 0.005 * zoomDamp;

    target.y = target.y > PI_HALF ? PI_HALF : target.y;
    target.y = target.y < - PI_HALF ? - PI_HALF : target.y;
  }

  function onTouchMove( event ) {

		var x, y;

		if ( event.changedTouches ) {

			x = event.changedTouches[ 0 ].pageX;
			y = event.changedTouches[ 0 ].pageY;

		} else {

			x = event.clientX;
			y = event.clientY;

		}

		mouse.x = ( x / window.innerWidth ) * 2 - 1;
		mouse.y = - ( y / window.innerHeight ) * 2 + 1;

	    

	//	checkIntersection();

	}
  
  function onMouseUp(event) {
    container.removeEventListener('mousemove', onMouseMove, false);
    container.removeEventListener('mouseup', onMouseUp, false);
    container.removeEventListener('mouseout', onMouseOut, false);
    container.style.cursor = 'auto';
  }

  function onMouseOut(event) {
    container.removeEventListener('mousemove', onMouseMove, false);
    container.removeEventListener('mouseup', onMouseUp, false);
    container.removeEventListener('mouseout', onMouseOut, false);
  }

  function onMouseWheel(event) {
    event.preventDefault();
    if (overRenderer) {
      zoom(event.wheelDeltaY * 0.1);
    }
    return false;
  }

  function onDocumentKeyDown(event) {
    switch (event.keyCode) {
      case 38:
        zoom(100);
        event.preventDefault();
        break;
      case 40:
        zoom(-100);
        event.preventDefault();
        break;
    }
  }

  function onWindowResize( event ) {
    camera.aspect = container.offsetWidth / container.offsetHeight;
    camera.updateProjectionMatrix();
    renderer.setSize( container.offsetWidth, container.offsetHeight );
  }

  function zoom(delta) {
    distanceTarget -= delta;
    distanceTarget = distanceTarget > 600 ? 600 : distanceTarget;
    distanceTarget = distanceTarget < 230 ? 230 : distanceTarget;
  }

  function animate() {
    requestAnimationFrame(animate);
    render();
  }

  function render() {
    zoom(curZoomSpeed);

    rotation.x += (target.x - rotation.x) * 0.1;
    rotation.y += (target.y - rotation.y) * 0.1;
    distance += (distanceTarget - distance) * 0.3;

    camera.position.x = distance * Math.sin(rotation.x) * Math.cos(rotation.y);
    camera.position.y = distance * Math.sin(rotation.y);
    camera.position.z = distance * Math.cos(rotation.x) * Math.cos(rotation.y);

    camera.lookAt(mesh.position);
    
    for(var i=0; i<textlabels.length; i++) {
        textlabels[i].updatePosition();
     }


    opts.onMouseover(mouse,camera,scene);
    
    renderer.render(scene, camera);
    
  }

  init();
  this.animate = animate;


  this.__defineGetter__('time', function() {
    return this._time || 0;
  });

  this.__defineSetter__('time', function(t) {
    var validMorphs = [];
    var morphDict = this.points.morphTargetDictionary;
    for(var k in morphDict) {
      if(k.indexOf('morphPadding') < 0) {
        validMorphs.push(morphDict[k]);
      }
    }
    validMorphs.sort();
    var l = validMorphs.length-1;
    var scaledt = t*l+1;
    var index = Math.floor(scaledt);
    for (i=0;i<validMorphs.length;i++) {
      this.points.morphTargetInfluences[validMorphs[i]] = 0;
    }
    var lastIndex = index - 1;
    var leftover = scaledt - index;
    if (lastIndex >= 0) {
      this.points.morphTargetInfluences[lastIndex] = 1 - leftover;
    }
    this.points.morphTargetInfluences[index] = leftover;
    this._time = t;
  });

  this.addData = addData;
  this.addForce = addForce;
  this.addUnit = addUnit;

  this.remove = remove;
  this.move = move;
  this.changeColor = changeColor;
  
  this.addLines = addLines;
  this.createPoints = createPoints;
  this.renderer = renderer;
  this.scene = scene;
  this.distanceTo = distanceTo;
  this.detail = detail;
  
  return this;

};

