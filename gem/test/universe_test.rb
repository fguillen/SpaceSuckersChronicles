require_relative 'test_helper'

class UniverseTest < Test::Unit::TestCase
  def setup
    @config = S2C::Config.new( "#{FIXTURES_PATH}/config.yml" )  
  end
  
  def test_initialize
    universe = S2C::Universe.new( @config )
    
    assert_equal( [], universe.logs )
    assert_equal( [], universe.planets )
    assert_equal( 0, universe.tick )
    assert_equal( 10, universe.size )
  end
  
  def test_create_planet
    universe = S2C::Universe.new( @config )
    
    planet = universe.create_planet( 'jupiter', [1,2] )
    
    assert_equal( 1, universe.planets.size )
    assert_equal( planet, universe.planets.first )
    assert_equal( [1,2], planet.position )
  end
  
  def test_cycle
    universe = S2C::Universe.new( @config )
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
    universe = S2C::Universe.new( @config )

    planet1 = universe.create_planet( 'jupiter' )
    mine1 = planet1.build_mine
    ship1 = planet1.build_ship
    ship2 = planet1.build_ship

    planet2 = universe.create_planet( 'mercurio' )
    ship3 = planet2.build_ship
    
    assert_equal( [ship1, ship2, ship3], universe.ships )
  end
  
  def test_get_planet
    universe = S2C::Universe.new( @config )
    planet1 = universe.create_planet('jupiter')
    planet2 = universe.create_planet('mercurio')
    
    assert_equal(planet2, universe.get_planet('mercurio'))
  end
  
  def test_get_ship
    universe = S2C::Universe.new( @config )
    planet1  = universe.create_planet('jupiter')
    ship1    = planet1.build_ship
    
    assert_equal(ship1, universe.get_ship(ship1.identity))
  end
  
  def test_to_hash
    universe = S2C::Universe.new( @config )
    planet1 = universe.create_planet('jupiter')
    planet2 = universe.create_planet('mercurio')
    
    ship1 = planet1.build_ship
    ship2 = planet1.build_ship
    mine1 = planet1.build_mine
    
    universe.stubs( :logs ).returns( ['1','2'] )
    universe.stubs( :status ).returns( 'STATUS' )
    universe.stubs( :tick ).returns( 'TICK' )
    universe.stubs( :size ).returns( 'SIZE' )
    
    assert_equal(['1', '2'], universe.to_hash[:logs])
    assert_equal('STATUS', universe.to_hash[:status])
    assert_equal('TICK', universe.to_hash[:tick])
    assert_equal('SIZE', universe.to_hash[:size])
    assert_equal(2, universe.to_hash[:planets].size)
    assert_equal(ship1.identity, universe.to_hash[:planets][0][:constructions][0][:identity])
  end
end