function fleetCoordinates( fleet, planets ){
  var planetOrigin      = fleet.get( "origin" );
  var planetDestination = fleet.get( "destination" );
  var distance          = distancePlanets( planetOrigin, planetDestination );
  var distanceCovered   = percent( distance, fleet.get( "process_percent" ) );

  var result =
    coordinatesMediumPoint(
      parseInt( planetOrigin.get( "position" )[0] ),
      parseInt( planetOrigin.get( "position" )[1] ),
      parseInt( planetDestination.get( "position" )[0] ),
      parseInt( planetDestination.get( "position" )[1] ),
      distanceCovered
    );

  return result;
}

function distancePlanets( planet1, planet2 ){
  var distance =
    distancePoints(
      parseInt( planet1.get( "position" )[0] ),
      parseInt( planet1.get( "position" )[1] ),
      parseInt( planet2.get( "position" )[0] ),
      parseInt( planet2.get( "position" )[1] )
    );

  return distance;
}

function percent( value, percent ) {
  return value * (percent/100)
}

function distancePoints( xA, yA, xB, yB ){
  var xDistance = Math.abs( xA - xB );
  var yDistance = Math.abs( yA - yB );

  var distance = Math.sqrt( Math.pow( xDistance, 2 ) + Math.pow( yDistance, 2 ) );

  return distance;
}

function coordinatesMediumPoint( xA, yA, xB, yB, distanceAC ){
  var distanceAB = distancePoints( xA, yA, xB, yB );
  var angleAB = Math.atan2( ( yB - yA ), ( xB - xA ) );
  var deltaXAC = distanceAC * Math.cos( angleAB );
  var deltaYAC = distanceAC * Math.sin( angleAB );
  var xC = xA + deltaXAC;
  var yC = yA + deltaYAC;

  // console.log( "xA", xA );
  // console.log( "yA", yA );
  // console.log( "xB", xB );
  // console.log( "yB", yB );
  // console.log( "distanceAC", distanceAC );

  // console.log( "distanceAB", distanceAB );
  // console.log( "angleAB", angleAB );
  // console.log( "deltaXAC", deltaXAC );
  // console.log( "deltaYAC", deltaYAC );
  // console.log( "xC", xC );
  // console.log( "yC", yC );

  return { x: xC, y: yC };
}