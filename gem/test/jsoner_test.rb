require_relative 'test_helper'
require "json"

class JSONerTest < Test::Unit::TestCase
  def setup
    super

    @universe = S2C::Universe.new
    @store    = S2C::Store.new( @universe )
  end

  def test_to_hash
    planet1 = @store.create_planet( [1, 1] )
    planet2 = @store.create_planet( [1, 2] )

    ship1   = @store.create_ship( planet1 )
    ship2   = @store.create_ship( planet1 )
    ship3   = @store.create_ship( planet1 )
    ship4   = @store.create_ship( planet2 )
    ship5   = @store.create_ship( planet2 )

    fleet   = @store.create_fleet( planet1, planet2, [ship2, ship3] )

    hash = S2C::JSONer.to_hash( @universe )

    # puts S2C::JSONer.to_json( @universe )

    assert_equal( 2, hash["planets"].size )
    assert_equal( 5, hash["ships"].size )
    assert_equal( 1, hash["fleets"].size )
  end

  def test_to_json
    S2C::JSONer.expects( :to_hash ).with( "universe" ).returns( [1, 2] )

    assert_equal( [1, 2], JSON.parse( S2C::JSONer.to_json( "universe" ) ) )
  end
end