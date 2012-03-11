require_relative '../test_helper'

module S2C::Utils
  def self.get_random( array )
    array.first
  end
end

class CombatTest < Test::Unit::TestCase

  def setup
    @config     = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe   = S2C::Universe.new(@config)
    @planet1    = @universe.create_planet( [1, 1] )
    @planet2    = @universe.create_planet( [1, 40] )

    @ship_in_fleet1 = @planet1.build_ship
    @ship_in_fleet2 = @planet1.build_ship
    @ship_in_planet = @planet2.build_ship

    @ship_in_planet.instance_variable_set( :@status, :standby )

    @fleet = @planet1.build_fleet( @planet2, [@ship_in_fleet1, @ship_in_fleet2] )

    @planet1.stubs( :id ).returns( "planet1" )
    @planet2.stubs( :id ).returns( "planet2" )
    @fleet.stubs( :id ).returns( "fleet" )
    @ship_in_fleet1.stubs( :id ).returns( "ship_in_fleet1" )
    @ship_in_fleet2.stubs( :id ).returns( "ship_in_fleet2" )
    @ship_in_planet.stubs( :id ).returns( "ship_in_planet" )
  end

  # def test_initial_status
  #   assert_equal( :traveling, @fleet.status )
  #   assert_equal( @planet2, @fleet.traveling_to )
  #   assert_equal( 1, @fleet.process_remaining_ticks )
  # end

  # def test_start_combat
  #   @universe.cycle # Fleet arrives to the planet
  #   @universe.cycle # Fleet decide to attack

  #   assert_equal( :combat, @fleet.status )
  #   assert_equal( @planet2.id, @fleet.combat_against.id )

  #   assert_equal( :combat, @ship_in_fleet.status )
  #   assert_equal( @planet2.id, @ship_in_fleet.combat_against.id )
  #   assert_equal( :planet, @ship_in_fleet.combat_type )

  #   assert_equal( :combat, @ship_in_planet.status )
  #   assert_equal( @fleet.id, @ship_in_planet.combat_against.id )
  #   assert_equal( :fleet, @ship_in_planet.combat_type )
  # end

  def test_first_cycle_combat
    # Fleet is traveling

    @universe.cycle # Fleet arrives to the planet

    assert_equal( :standby,       @ship_in_planet.status )
    assert_equal( :traveling,     @ship_in_fleet1.status )
    assert_equal( :traveling,     @ship_in_fleet2.status )
    assert_equal( :traveling,     @fleet.status )
    assert_equal( true,           @universe.units.include?( @ship_in_planet ) )
    assert_equal( true,           @planet2.units.include?( @ship_in_planet ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet1 ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet2 ) )
    assert_equal( 32,             @ship_in_planet.life )
    assert_equal( 32,             @ship_in_fleet1.life )
    assert_equal( 32,             @ship_in_fleet2.life )
    assert_equal( 0,              @ship_in_planet.level )
    assert_equal( 0,              @ship_in_fleet1.level )
    assert_equal( 0,              @ship_in_fleet2.level )


    @universe.cycle # Fleet decide to attack

    assert_equal( :combat,        @ship_in_planet.status )
    assert_equal( :combat,        @ship_in_fleet1.status )
    assert_equal( :combat,        @ship_in_fleet2.status )
    assert_equal( :combat,        @fleet.status )
    assert_equal( true,           @universe.units.include?( @ship_in_planet ) )
    assert_equal( true,           @planet2.units.include?( @ship_in_planet ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet1 ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet2 ) )
    assert_equal( 32,             @ship_in_planet.life )
    assert_equal( 32,             @ship_in_fleet1.life )
    assert_equal( 32,             @ship_in_fleet2.life )
    assert_equal( 0,              @ship_in_planet.level )
    assert_equal( 0,              @ship_in_fleet1.level )
    assert_equal( 0,              @ship_in_fleet2.level )

    @universe.cycle # Fist attack turn

    assert_equal( :combat,        @ship_in_planet.status )
    assert_equal( :combat,        @ship_in_fleet1.status )
    assert_equal( :combat,        @ship_in_fleet2.status )
    assert_equal( :combat,        @fleet.status )
    assert_equal( true,           @universe.units.include?( @ship_in_planet ) )
    assert_equal( true,           @planet2.units.include?( @ship_in_planet ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet1 ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_fleet2 ) )
    assert_equal( 2,              @ship_in_planet.life )
    assert_equal( 17,             @ship_in_fleet1.life )
    assert_equal( 32,             @ship_in_fleet2.life )
    assert_equal( 0,              @ship_in_planet.level )
    assert_equal( 0,              @ship_in_fleet1.level )
    assert_equal( 0,              @ship_in_fleet2.level )

    @universe.cycle # Second attack turn

    assert_equal( :destroyed,     @ship_in_planet.status )
    assert_equal( :standby,       @ship_in_fleet1.status )
    assert_equal( :standby,       @ship_in_fleet2.status )
    assert_equal( :disolved,      @fleet.status )
    assert_equal( false,          @universe.units.include?( @ship_in_planet ) )
    assert_equal( false,          @planet2.units.include?( @ship_in_planet ) )
    assert_equal( true,           @planet2.units.include?( @ship_in_fleet1 ) )
    assert_equal( true,           @planet2.units.include?( @ship_in_fleet2 ) )
    assert_equal( false,          @universe.fleets.include?( @fleet ) )
    assert_equal( -13,            @ship_in_planet.life )
    assert_equal( 17,             @ship_in_fleet1.life )
    assert_equal( 32,             @ship_in_fleet2.life )
    assert_equal( 0,              @ship_in_planet.level )
    assert_equal( 1,              @ship_in_fleet1.level )
    assert_equal( 1,              @ship_in_fleet2.level )

  end

end