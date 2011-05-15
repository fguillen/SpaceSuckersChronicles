## Intentions

Build a **very simple** [text-based massively multiplayer online role-playing game](http://en.wikipedia.org/wiki/List_of_text-based_MMORPGs).

Due I don't want to waste time in thinking and designing a consistent environment context I'm gonna try to build a **very simple clone of [OGame](http://en.wikipedia.org/wiki/OGame)**.

I don't want to build a ready to production MMORP, I just want to build something that is starting to work and which allows me to understand the process and the needs of these kind of projects. This is just an experiment.


## Thechnical details

### The model

Trying to do this simple we will have _User_, _Planet_, _Ship_ and _Fabric_. Maybe another template classes like _ShipModel_ and _FabricModel_.


### The Installation and Use process 

The _Administrator_ installs the **core gem** and the **server gem** and start the server.

The _User_ installs the **console client gem**.

The _User_ configure the _console client_ with **sever ip** and **user name**.

The _User_ use the _console client_ to interact with the _server_.

The _User_ create an account and magically a _Planet_ will be create for him/her with an small _Fleet_ and a basic _Resources_ to star build and explore.

The _User_ could start build new _Fabrics_ or _Ships_ or send _Spy Ships_ to random locations trying to find new _Planets_.

Once the _User_ has find a new _Planet_ he can send a _Fleet_ to this _Planet_ an conquer it.
 
Attacks will be produced when two enemy _Fleets_ are found in the same planet. _Attacks_ will be resolved automatically and not strategy possibilities are available. The winner of the _Attack_ will be the owner of the _Planet_.

### The User Commands

I have very forgotten my OGame epoch, I think the commands could be:

* create account
* see planet stats (all the ships, all the fabrics, levels, positions, constructions status, stored resources, extraction resources possibilities)
* lunch an spy ship to another planet
* lunch an spy ship to random locations looking for planets
* read the spy ship reports
* lunch a fleet (define the fleet) to another planet
* attack another planet
* build new ships or fabrics
* upgrade ship or fabric levels
* ??


### The Server

I'm thinking in an **HTTP REST API**, maybe with a very simple **Sinatra layer**.

Even if we expose an _HTTP REST API_ the core has to be an **atomic gem with its own API** and there is where is gonna be the 90% of the effort in this project. 

### The Client

Could be anything that is able to consume the **HTTP REST API**: web, console client, iPhone App.

I'm not going to build all of these clients, I think I'm going to focus to build a **console client**, or a **very simple web client**.

### Example of comunication

- _CLIENT:_ http://spacesuckerschronicles.com/users/<user_name>/planets/<planet_name>/stats
- _SERVER:_ [json with the details of all ships in this planet]
  
- _CLIENT:_ http://spacesuckerschronicles.com/users/<user_name>/planets/<planet_name>/ships/raiders/1/send/<planet_name>/<action_name>
- _SERVER:_ [json with the details of travel]
  
- _CLIENT:_ http://spacesuckerschronicles.com/users/<user_name>/planets/<planet_name>/ships/create_fleet/send/<planet_name>?attack&ships=[1,2,3,4,56,78,89]
- _SERVER:_ [json with the details of travel]
  
- _CLIENT:_ http://spacesuckerschronicles.com/users/<user_name>/planets/<planet_name>?action=build&ship_class=raider
- _SERVER:_ [json with the details of the construction]
  
- _CLIENT:_ http://spacesuckerschronicles.com/users/<user_name>/planets/<planet_name>/messages
- _SERVER:_ [json with the last news in this planet]
  
  

## Challenges

Define and build the APIs of the gem and the HTTP server **as simple and reusable as possible**.

The API should be simple and very easy to use but at the same time has to offer to the _User_ enough possibilities to be a bit fun to play.

Organizing and keep running **permanent universe**. I don't have still any idea how to implement this.

Defining a **combat resolution system**.

Trying to design the APIs the way we can take the code and change the context completely: in one clone we are playing an space war, in another clone we are garden insects trying to conquer the whole garden, or virus in a human body conquering another human bodies...

Could be nice to build some _Users managed by the computer_ with a very stupid IA, but I think this is needed due I'm not expecting the ton of real users needed to make the game funny :)

## Not going to be done

I'm not going to put attention in the bellow subjects (but they would be desirable):

* Login, and access security (we are gonna trust on any client request)
* User power equilibrium (I'm not going to define strategies to keep the equilibrium between users' power)
* Attack remains recollection possibility. 
* Multi-language (just English)
* I'm gonna use the most familiar ORM to me: ActiveRecord (I don't want this election to stack me)
* Error protection (everything will crash in case request bad-format, or resource not found)