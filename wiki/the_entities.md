# The Entities

## ShipTemplate

Represents the characteristics of a **Ship Model**.

This is most a configuration table than an instance of anything, so maybe this is better to put it in a _yaml_ .. I don't know.

### Attributes

* **name**: the name of the model (Fighter, Explorer, Destroyer, Mine, ...)
* **attack**: attack power (attack relating)
* **mobility**: mobility power (attack relating)
* **harvest**: harvest power (only Mine has this attribute) 
* **capacity**: resources warehouse capacity (only Wharehouse has this attribute) 
* **velocity**: velocity
* **life**: Initial life
* **cost_resources_level**: The materials needed to update level.
* **cost_time_level**: The time needed to update level.

### Calculations

All the values of the attributes are the value for the **level 1** of this model of ship.

To know the actual value of any attribute make: *attribute_value X ship_level*

## Ship

A ship entity.

### Attributes

* **model**: the name of the model (Fighter, Explorer, Destroyer, Harvester, Warehouse, Hangar...)
* **license_plate**: identify code
* **status**: (ready, broken, repairing, dead)
* **level**: The actual level
* **life**: points of life
* **fleet**: Name of the Fleet this ship belongs

## Fleet

Is a group of ships.

The ships can't travel by it's own, they belong to a _fleet_ and is the _fleet_ who is designed to travel some where.

Ships in status: **broken, repairing, dead**, can't belong to any _fleet_.

### Attributes

* **name**: unique name
* **position**: 2D position of this fleet in the _Map_
* **status**: (standby, traveling)

## Planet

The planets are the only way to obtain _Resources_.

There is the only place where an _Attack_ can happen.

* **name**: unique name
* **position**

The planets belongs to an user, but if an enemy fleet arrives to this planet and defeats the actual fleet in the planet, this planet will belong to the user owner of victorious fleet.

All the planets exists before any user is created, and they will remain forever.

### Resources

The resources of a planet are infinite but _mines_ are needed to harvest them.
