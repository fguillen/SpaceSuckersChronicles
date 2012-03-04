
function random(num){
  return Math.floor( Math.random() * num );
};

function planetsDataMock(){
  var result =
    _.map(
      [1, 2, 3, 4, 5, 6],
      planetDataMock
    );

  return result;
};

function fleetsDataMock(){
  var result =
    _.map(
      [1, 2, 3, 4, 5, 6],
      fleetDataMock
    );

  return result;
};

function fleetDataMock(){
  var data = {
    id:           random(400),
    name:         ("F22" + random(9)),
    x:            (random(400) + 50),
    y:            (random(400) + 50),
    shipsData:    shipsDataMock()
  }

  return data;
};


function planetDataMock(){
  var data = {
    id:           random(400),
    name:         ("X22" + random(9)),
    x:            (random(400) + 50),
    y:            (random(400) + 50),
    level:        random(10),
    production:   random(100),
    shipsData:    shipsDataMock()
  }

  return data;
}

function shipsDataMock(){
  var result =
    _.map(
      [1, 2, 3, 4],
      shipDataMock
    );

  return result;
};

function shipDataMock(){
  var data = {
    id:   random(400),
    name: ("S22" + random(9))
  }

  return data;
}