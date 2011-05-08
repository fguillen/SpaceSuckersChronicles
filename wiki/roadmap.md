# Roadmap

Trying to define a list of TODOs

## API commands

Define the API version of the commands.

It has to be:

* API of the gem it self
* API of the web interface (who talks with the API of the gem)
* API of the console interface (who talks with the API of the web interface)

## Configuration

Define the configurations files for:

* Ship Models
* Map

## Modeling

Integrate _ActiveRecord_ without Rails!

Define the _schema_. A script to reproduce the schema (we don't have migrations, do we?)

## Universe builder

Implement a mechanism to create random planets in the universe.

It is needed to build the basics of the universe.

## User creation builder

System to create a new user.

The user has to have enough elements: _ships_ and _resources_ to start growing.

## The clock

Implement a system that is:

* increment the _harvested resources_.
* updating position of _traveling_ ships.
...

## Implement the Attack engine

System to resolve attacks between fleets.

## Processes

Implement a system where we can define:

* **time_to_finish**
* **event**

This is a sort of _DelayedJob_ or something like this.

## Implement API of the gem

After its definition we implement the commands for the internal gem, these are Ruby commands.

After this point we will be able to play the game using an _irb session_.

## Implement API of the web interface

A Sinatra server with a REST interface (o maybe no REST :))

## Implement API of the console interface

A Ruby script which is available to receive params.

I will translate the params to a **HTTP requests** to the _web interface_.


