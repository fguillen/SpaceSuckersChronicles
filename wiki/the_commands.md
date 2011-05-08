# The Commands

Nothing is done if you don't tell it to be done.

## Build

### Command

* **action**: build
* **parameters**:
** **ship_model**

### Requirements

It has to be an _Hangar_ ship.

The actual planet has to have enough _resources_.

### Resolution

The _Hangar_ update its _production_tale_ (each Hangar is only available to build a concrete number of ships each time)

A new _process_ is started (we have to define processes)

## Upgrade

### Command

* **action**: upgrade
* **parameters**:
** **license_plate**: the unique number to identify the ship

### Requirements

It has to be an _Hangar_ ship.

The actual planet has to have enough _resources_.

### Resolution

The ship is in status: **upgrading** and it can't belongs to any _fleet_.

A new _process_ is started.

## Add to fleet

### Command

* **action**: add_to_fleet
* **parameters**:
** **fleet_name**: the unique name to identify the fleet
** **license_plate**: the unique number to identify the ship

### Requirements

Both _ship_ and _fleet_ hast to be in the same planet and both has to be in _standby_ status.

### Resolution

The ship belongs now to this fleet.

## Remove from fleet

The opposite to _add_to_fleet_ command.

## Send fleet to a planet

### Command

* **action**: send
* **parameters**:
** **fleet_name**: the unique name to identify the fleet
** **planet_name**: the unique name to identify the planet

### Requirements

### Resolution

The float and any ship on it is in status: **traveling**.

A new _process_ is started.

