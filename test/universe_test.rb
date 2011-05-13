require_relative 'test_helper'

class UniverseTest < Test::Unit::TestCase
  # def test_universe
  #   universe = S2C::Universe.new
  #   planet = universe.create_planet( 'X700' )
  #   planet.build_mine
  #   universe.run
  # end
  
  def test_ships
    universe = S2C::Universe.new

    planet1 = universe.create_planet( 'jupiter' )
    mine1 = planet1.build_mine
    ship1 = planet1.build_ship
    ship2 = planet1.build_ship

    planet2 = universe.create_planet( 'mercurio' )
    ship3 = planet2.build_ship
    
    assert_equal( [ship1, ship2, ship3], universe.ships )
  end
end