# Questions

## symbolize keys in YAML load

In my `S2C::CONFIG` hash all the keys are strings and I want them symbolized.

The `Hash.symbolized_keys` on Rails hasn't solved my problem due only symbolize keys in the first level.

## Modify an instance variable from out side

Having this:

    class Wadus
      attr_reader :variable
    end
    
    wadus = Wadus.new
    
How to modify the `wadus.variable` from outside?

_I want this for testing pruposes._

### Solution

    wadus.instance_variable_set( :@variable, 'new value' )

Actually I would like to know all the **introspection** methods available in Ruby.
    
## How to grow up the attributes

I have stolen a _formula_ from an _OGame_ formula.. but I would like to build my own.

## Improve the Config class

I don't really like the way it is now.


## The possible statuses of the Construction

The class `S2C::Models::Construction` has a list of the status that each descendent class can have, but I want every descendent class to **add its own statuses**.

And also, I want to use this statuses list in the code, but if it is an array I don't know how to use them, and if is a hash, I don't understand the meaning.

## How to reuse test_helper setup

If I define a `Test::Unit::TestCase.setup` I can use it on any test class but if my test class **wants to add some new stuff to the setup** how can I deal with this?.


## The infinite run cycle and the progress of the processes

I think there are to approach to update the progress of the processes:

* Using the real clock to calculate the status of a process on every moment.
* Update the progress of the process sending 'update' signals each fixed amount of real time

In this moment I'm using the second approach:

The Universe is the one keeping running an infinite loop, calling to the method `work` of every element in the system: Constructions, Ships, ...

There are two things I don't like with this approach:

* My console in blocked because the method `run` never ends.
* Could be de-synchronization between real clock and processes progress due different durations in the work that has to be done in each cycle.

But I don't want to leave this approach yet because is very **stable** and **manipulable**:

* The end of a process is never missed
* I can _accelerate_ or _slow down_ the velocity of all processes very easily.

So questions:

* Is the not ending `run` method a good idea?
* How can I avoid the console block? Threads?
* What do you think is better approach: _real clock_ calculation, or the _cycle_ one?
