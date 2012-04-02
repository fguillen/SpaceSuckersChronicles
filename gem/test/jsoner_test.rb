require_relative 'test_helper'
require "json"

class JSONerTest < Test::Unit::TestCase
  def setup
    super

    S2C::Global.setup( "#{FIXTURES}/config.yml" )

    @universe   = S2C::Global.universe

    planet1 = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    planet2 = S2C::Models::Units::Planet.create!( :position => [1, 2] )

    planet1.furnish
    planet2.furnish

    planet1.mine.start_produce
    planet1.silo.start_upgrade
    planet1.hangar.start_build_ship

    ship1 = planet1.ships.create!
    ship2 = planet1.ships.create!
    ship3 = planet1.ships.create!
    ship4 = planet1.ships.create!
    ship5 = planet1.ships.create!

    fleet =
      S2C::Models::Units::Fleet.arrange(
        :base   => planet1,
        :target => planet2,
        :ships  => [ship2, ship3]
      )
  end

  def test_to_hash
    hash = S2C::JSONer.to_hash( @universe )
    puts "XXX: planets: #{hash["planets"].map { |e| puts "XXX2: #{e}" } }"

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