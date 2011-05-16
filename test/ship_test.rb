require_relative 'test_helper'

class ShipTest < Test::Unit::TestCase
  
  def setup 
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
    
    @universe = S2C::Universe.new( { 'size' => 20 } )
    @planet = @universe.create_planet( 'jupiter' )
  end
  
  def test_initialize
    ship = S2C::Models::Ship.new( @planet )
    
    assert_not_nil( ship.identity )
    assert_equal( @universe, ship.universe )
    assert_equal( @planet, ship.planet )
    assert_equal( 0, ship.level )
    assert_equal( 'ship', ship.type )
    assert_equal( :under_construction, ship.status )
    assert_equal( 33, ship.instance_variable_get( :@process_remaining_ticks ) )
  end
  
  def test_travel
    planet_origin = @universe.create_planet( 'x500' )
    planet_destiny = @universe.create_planet( 'x700' )
    
    ship = S2C::Models::Ship.new( planet_origin )
    ship.instance_variable_set( :@status, :standby )
    ship.instance_variable_set( :@traveling_to, nil )
    ship.instance_variable_set( :@process_remaining_ticks, 1 )
    
    ship.planet.instance_variable_set( :@black_stuff, 12 )
    
    S2C::Utils.expects( :travel_black_stuff ).with( ship.planet, planet_destiny ).returns( 11 )
    S2C::Utils.expects( :travel_ticks ).with( ship.planet, planet_destiny, ship.velocity ).returns( 3 )
    
    ship.travel( planet_destiny )
    assert_equal( :traveling, ship.status )
    assert_equal( planet_destiny, ship.traveling_to )
    assert_equal( 1, ship.planet.black_stuff )
    assert_equal( 3, ship.process_remaining_ticks )
  end
  
  def test_travel_not_in_standby_should_returns_false
    planet_destiny = @universe.create_planet( 'saturn' )
    
    ship = S2C::Models::Ship.new( @planet )
    ship.instance_variable_set( :@status, :under_construction )
    ship.instance_variable_set( :@traveling_to, nil )
    ship.instance_variable_set( :@process_remaining_ticks, 1 )
    
    assert_equal( false, ship.travel( planet_destiny ) )
    assert_equal( :under_construction, ship.status )
    assert_equal( 1, ship.process_remaining_ticks )
    assert_match( "ERROR", @universe.logs.last )
  end
  
  def test_travel_not_enough_black_stuff_should_returns_false
    planet_destiny = @universe.create_planet( 'saturn' )
    
    ship = S2C::Models::Ship.new( @planet )
    ship.instance_variable_set( :@status, :standby )
    ship.instance_variable_set( :@traveling_to, nil )
    ship.instance_variable_set( :@process_remaining_ticks, 1 )
    
    ship.planet.expects( :black_stuff ).returns( 10 )
    
    S2C::Utils.expects( :travel_black_stuff).with( ship.planet, planet_destiny ).returns( 11 )
    
    assert_equal( false, ship.travel( planet_destiny ) )
    assert_equal( :standby, ship.status )
    assert_equal( 1, ship.process_remaining_ticks )
    assert_match( "ERROR", @universe.logs.last )
  end
  
  def test_work_traveling
    ship = S2C::Models::Ship.new( @planet )
    ship.instance_variable_set( :@status, :traveling )
    ship.instance_variable_set( :@process_remaining_ticks, 1 )
    
    ship.work_traveling
    assert_equal( :traveling, ship.status )
  end
  
  def test_work_traveling_finished
    planet_origin = @universe.create_planet( 'x500' )
    planet_destiny = @universe.create_planet( 'x700' )
    
    ship = S2C::Models::Ship.new( planet_origin )
    ship.instance_variable_set( :@status, :traveling )
    ship.instance_variable_set( :@traveling_to, planet_destiny )
    ship.instance_variable_set( :@process_remaining_ticks, 0 )
    
    ship.work_traveling
    assert_equal( planet_destiny.name, ship.planet.name )
    assert_equal( 0, planet_origin.constructions.size )
    assert_equal( 1, planet_destiny.constructions.size )
    assert_equal( ship, planet_destiny.constructions.first )
    assert_equal( :standby, ship.status )
    assert_nil( ship.traveling_to )
  end
  
  def test_stats_in_traveling
    S2C::Utils.stubs( :remaining_ticks_to_time ).returns( Time.new( 2010, 11, 12, 13, 14, 15 ) )
    
    planet_destiny = @universe.create_planet( 'x700' )
    
    ship = S2C::Models::Ship.new( @planet )
    ship.instance_variable_set( :@status, :traveling )
    ship.stubs( :type ).returns( 'TYPE' )
    ship.stubs( :level ).returns( 123 )
    ship.stubs( :traveling_to ).returns( planet_destiny )
    ship.stubs( :process_remaining_ticks ).returns( 14 )

    assert_equal( 
      "type:TYPE           level:123           status:traveling    remaining_ticks:14  ending_time:2010-11-12 13:14:15",
      ship.stats
    )
  end
  
  def test_stats_in_standby
    ship = S2C::Models::Ship.new( @planet )
    ship.instance_variable_set( :@status, :standby )
    ship.stubs( :type ).returns( 'TYPE' )
    ship.stubs( :level ).returns( 123 )

    assert_equal( 
      "type:TYPE           level:123           status:standby      ",
      ship.stats
    )
  end
end