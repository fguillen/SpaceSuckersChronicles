# Questions

## The persistence Layer

I have initialize a _class variable_ into the `S2C::Server::App` to keep the persistence of the universe.

I know you say that using _class variables_ is not a good idea but for the moment is the easiest solution I have found.

In next iterations I want to add a proper _persistence layer_, surely `ActiveRecord` but then a big question comes to my mind:

* Where do I have to integrate the _persistence layer_?

In the gem module or in the server module?

Doing it in the gem module means to overload this layer and I don't find the way to do it in an external layer like the server layer :?