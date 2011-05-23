# S2C

I have improve this exercise adding a **server layer** and starting what is could be a **console client layer**.

## Next Iteration

* clean up and stabilize the _client layer_.

I also would like to work on:

* Persistence layer
* Multiuser
* Attack

But I'm afraid I am going out of time so I prefer to focus in finish the _client layer_ and clean up everything

## Layers

I have defined the most basic _3 layers_ needed for the game.

Each one of them is intentioned to be release as _independent gem_ but for a more agile development I think is better to have them all together.

I have separate each one of them in a subfolder of the project:

* /gem
* /server
* /client


### The gem

In the `gem` folder we have all the elements that implements the business logic of the game.

* The models
* The surrounding Universe
* The infinite loop

### The server

The server initialize an _Universe_, starts it and exposes it to network request through a _REST API_.

#### How to initialize it
    
    cd server
    ruby bin/s2c_server.rb
    
#### Commands

* show universe: get "/universe"
* show planets: get "/universe/planets"
* show ships: get "/universe/ships"
* show planet: get "/universe/planet/:name"
* create planet: post "/universe/planet?name=<planet_name>"
* build mine: post "/universe/planets/:name/mines"
* build ship: post "/universe/planets/:name/ships"
* travel: post "/universe/ships/:identity/travel?planet_name=<planet_name>" 

### The client

Please don't make a review of this part of the code since I just have write on the air and just to have something to use to interact with the _server layer_.

#### How to initialize it

First you have to **initialize the server**. 

Then:
    
    cd client
    ruby bin/s2c_console.rb
    
#### Commands

You can check this [command session](https://github.com/fguillen/SpaceSuckersChronicles/blob/master/wiki/console_session.md), it is for the _stand alone_ version but it should work just the same.



