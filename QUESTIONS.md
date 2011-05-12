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
