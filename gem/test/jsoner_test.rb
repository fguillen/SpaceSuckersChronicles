require_relative 'test_helper'
require "json"

class JSONerTest < Test::Unit::TestCase
  def setup
    super

    S2C::Global.setup( "#{FIXTURES}/config.yml" )

    @universe   = S2C::Global.universe
    store       = S2C::Global.store

    planet1 = store.create_planet( [1, 1] )
    planet2 = store.create_planet( [1, 2] )

    store.furnish_planet( planet1 )
    store.furnish_planet( planet2 )

    planet1.mine.start_produce
    planet1.silo.start_upgrade
    planet1.hangar.build_ship

    ship1 = store.create_ship( planet1 )
    ship2 = store.create_ship( planet1 )
    ship3 = store.create_ship( planet1 )
    ship4 = store.create_ship( planet2 )
    ship5 = store.create_ship( planet2 )

    fleet = store.create_fleet( planet1, planet2, [ship2, ship3] )
  end

  def test_to_hash
    hash = S2C::JSONer.to_hash( @universe )

    assert_equal( 2, hash["planets"].size )
    assert_equal( 5, hash["ships"].size )
    assert_equal( 1, hash["fleets"].size )
  end

  def test_to_json
    universe_json = S2C::JSONer.to_json( @universe )

    File.open( "#{FIXTURES}/universe.json", "w" ) do |f|
      f.write universe_json
    end

    assert_equal( File.read( "#{FIXTURES}/universe.json" ), universe_json )
  end
end