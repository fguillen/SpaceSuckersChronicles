# Space Suckers Chronicles

The **most simple** [text-based massively multiplayer online role-playing game](http://en.wikipedia.org/wiki/List_of_text-based_MMORPGs).

## This version

We already have

* The construction of a **Universe**.
* The construction of a **Planet**.
* In a Planet you can build a **Mine**.
* In a Planet you can build a **Ship**.
* The _Ship_ can **travel** from its actual _Planet_ to another.
* The _Ship_ and the _Mine_ can be upgraded
* Every action **consumes black stuff** which is extracted with the _Mines_.
* Every action **takes time** to be finished.

### The console

To interact with the game in a very simple way you can use the **Console**:

    ruby bin/console.rb
    
Following the menus you can:

* create_planet
* build_mine
* build_ship
* travel
* log
* see stats
* see the map

For a very easy console session you can follow this sequence:

* 1:seed (this is a trick for creating a bunch of objects quick)
* 7:stats (see the actual status of your constructions)
* 8:map (see the planets map)
* 5:travel (send a _Ship_ to another planet)
** choose a ship
** choose a planet

## Next version

* Client/Server communication :)
* Attack!
* Multiuser
* ... web interface?



