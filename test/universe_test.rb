require_relative 'test_helper'

class UniverseTest < Test::Unit::TestCase
  def test_initialize
    universe = S2C::Universe.new
    
    assert_equal( [], universe.logs )
    assert_equal( [], universe.planets )
    assert_equal( 0, universe.tick )
  end
  
  def test_create_planet
    universe = S2C::Universe.new
    
    planet = universe.create_planet( 'jupiter', [1,2] )
    
    assert_equal( 1, universe.planets.size )
    assert_equal( planet, universe.planets.first )
    assert_equal( [1,2], planet.position )
  end
  
  def test_cycle
    universe = S2C::Universe.new
    universe.instance_variable_set( :@tick, 1 )
    planet = universe.create_planet( 'jupiter' )
    mine = planet.build_mine
    ship = planet.build_ship

    mine.expects( :work )
    ship.expects( :work )
        
    universe.cycle
    
    assert_equal( 2, universe.tick )
  end
  
  
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