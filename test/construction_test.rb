require_relative 'test_helper'

class ConstructionTest < Test::Unit::TestCase
  def setup 
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
    
    @universe = S2C::Universe.new
    @planet = @universe.create_planet( 'jupiter' )
  end
  
  def test_initialize
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    assert_not_nil( construction.identity )
    assert_equal( @universe, construction.universe )
    assert_equal( @planet, construction.planet )
    assert_equal( 0, construction.level )
    assert_equal( 'mine', construction.type )
    assert_equal( :under_construction, construction.status )
    assert_equal( 13, construction.instance_variable_get( :@process_remaining_ticks ) )
  end
  
  def test_power_calculation
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    assert_equal( 15, construction.power )
    
    construction.instance_variable_set( :@level, 1 )
    assert_equal( 32, construction.power )
    
    construction.instance_variable_set( :@level, 2 )
    assert_equal( 51, construction.power )
    
    construction.instance_variable_set( :@level, 3 )
    assert_equal( 75, construction.power )
    
    construction.instance_variable_set( :@level, 4 )
    assert_equal( 103, construction.power )
  end
  
  def test_defense_calculation
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    assert_equal( 11, construction.defense )
    
    construction.instance_variable_set( :@level, 1 )
    assert_equal( 23, construction.defense )
  end
  
  def test_upgrade
    @planet.expects( :black_stuff ).returns( 14 )
    @planet.expects( :remove_black_stuff ).with( 14 )
    
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :standby )
    
    construction.upgrade
    assert_equal( 0, construction.level )
    assert_equal( :upgrading, construction.status )
    assert_equal( 13, construction.instance_variable_get( :@process_remaining_ticks ) )
  end
  
  def test_upgrade_not_standby_construction_should_returns_false
    @planet.expects( :remove_black_stuff ).never
    
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :under_construction )
    
    assert_equal( false, construction.upgrade )
    assert_equal( 0, construction.level )
    assert_equal( :under_construction, construction.status )
    assert_match( "ERROR", @universe.logs.last )
  end
  
  def test_upgrade_not_enough_black_stuff_should_returns_false
    @planet.expects( :black_stuff ).returns( 0 )
    @planet.expects( :remove_black_stuff ).never
    
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :standby )
    
    assert_equal( false, construction.upgrade )
    assert_equal( 0, construction.level )
    assert_equal( :standby, construction.status )
    assert_match( "ERROR", @universe.logs.last )
  end
  
  def test_word
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :under_construction )
    construction.instance_variable_set( :@process_remaining_ticks, 10 )
    construction.expects( :work_under_construction )
    
    construction.work
    
    assert_equal( 9, construction.process_remaining_ticks )
  end
  
  def test_work_under_construction
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :under_construction )
    construction.instance_variable_set( :@process_remaining_ticks, 1 )
    
    construction.work_under_construction
    assert_equal( :under_construction, construction.status )
  end
  
  def test_work_under_construction_finished
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :under_construction )
    construction.instance_variable_set( :@process_remaining_ticks, 0 )
    
    construction.work_under_construction
    assert_equal( 1, construction.level )
    assert_equal( :standby, construction.status )
  end
  
  def test_work_upgrading
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :upgrading )
    construction.instance_variable_set( :@process_remaining_ticks, 1 )
    
    construction.work_upgrading
    assert_equal( :upgrading, construction.status )
  end
  
  def test_work_upgrading_finished
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :upgrading )
    construction.instance_variable_set( :@process_remaining_ticks, 0 )
    construction.instance_variable_set( :@level, 1 )
    
    construction.work_upgrading
    assert_equal( 2, construction.level )
    assert_equal( :standby, construction.status )
  end
  
  def test_work_standby
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :standby )
    construction.instance_variable_set( :@process_remaining_ticks, 1 )
    
    construction.work_standby
    assert_equal( :standby, construction.status )
  end
  
  def test_stats_not_in_standby
    S2C::Utils.stubs( :remaining_ticks_to_time ).returns( Time.new( 2010, 11, 12, 13, 14, 15 ) )
    
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :upgrading )
    construction.stubs( :type ).returns( 'TYPE' )
    construction.stubs( :level ).returns( 78 )
    construction.stubs( :process_remaining_ticks ).returns( 12 )
    
    assert_equal( 
      "type:TYPE           level:78            status:upgrading    remaining_ticks:12  ending_time:2010-11-12 13:14:15",
      construction.stats
    )
  end

  def test_stats_in_standby
    construction = S2C::Models::Construction.new( @planet, 'mine' )
    construction.instance_variable_set( :@status, :standby )
    construction.stubs( :type ).returns( 'TYPE' )
    construction.stubs( :level ).returns( 78 )
    
    assert_equal( 
      "type:TYPE           level:78            status:standby      ",
      construction.stats
    )
  end
end