require_relative 'test_helper'

class PlanetTest < Test::Unit::TestCase
  def setup 
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
    
    @universe = S2C::Universe.new
    @planet = @universe.create_planet( 'jupiter' )
  end
  
  def test_initialize
    planet = S2C::Models::Planet.new( @universe, 'saturn' )
    
    assert_equal( 20, planet.black_stuff )
    assert_equal( 'saturn', planet.name )
    assert_equal( 0, planet.constructions.size )
    assert_equal( @universe, planet.universe )
    assert_not_nil( planet.position )
  end
  
  def test_initialize_with_position
    planet = S2C::Models::Planet.new( @universe, 'saturn', [1,2] )
    
    assert_equal( [1,2], planet.position )
  end
  
  def test_add_black_stuff
    @planet.instance_variable_set( :@black_stuff, 1 )
    
    @planet.add_black_stuff( 3 )
    
    assert_equal( 4, @planet.black_stuff )
  end
  
  def test_remove_black_stuff
    @planet.instance_variable_set( :@black_stuff, 10 )
    
    @planet.remove_black_stuff( 3 )
    
    assert_equal( 7, @planet.black_stuff )
  end
  
  def test_build_mine
    @planet.instance_variable_set( :@constructions, [] )
    
    @planet.build_mine
    
    assert_equal( 1, @planet.constructions.size )
    assert_equal( 'mine', @planet.constructions.first.type )
    assert_equal( @planet, @planet.constructions.first.planet )
  end
  
  def test_build_ship
    @planet.instance_variable_set( :@constructions, [] )
    
    @planet.build_ship
    
    assert_equal( 1, @planet.constructions.size )
    assert_equal( 'ship', @planet.constructions.first.type )
    assert_equal( @planet, @planet.constructions.first.planet )
  end
  
  def test_identity
    assert_equal( 'jupiter', @planet.identity )
  end
  
  def test_stats
    @planet.stubs( :position ).returns( [3,45] )
    @planet.stubs( :constructions ).returns( [1,2] )
    @planet.stubs( :black_stuff ).returns( 789 )
    
    assert_equal( "position:[3,45]     constructions:2     black_stuff:789", @planet.stats )
  end

end