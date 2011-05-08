# Problems

Things that we have to think about

## Processes

The whole game if full of processes this is one of the most interesting parts of it.

Nothing happens immediately, everything need time:

* build
* upgrade
* travel
* harvest
* attack??

So we need to define this kind of entity in a very flexible way.

Every process has a **time left**.

When the **time left** arrives to 0 the **event** happens: we need to define this entity too. 

An _event_ can be:

* one ship is upgrade and its status changes
* a float arrives to a planet and status changes
* a ship is created and is available in a planet

## Universe knowledge

How can the user find new planets?

Does he know the position of any one but don't know the actual info?

### Solutions

#### Universal knowledge

I think the official _OGame_ show a list of all the planets in the universe so you can send a float to any planet.

#### Researching

Use _Explorer_ ships to send them in random directions to find new planets.


## Resource transportation

We have to define the way to transport resources from a planet to another without add too many commands that the actual existing.


## User stack

What happen if the user lost every of its planets? Or he/she is in a position from where he/she can't build anything?