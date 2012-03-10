require_relative '../test_helper'

class CombatTest < Test::Unit::TestCase

  def setup
    @config     = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe   = S2C::Universe.new(@config)
    @planet1    = @universe.create_planet( [1, 1] )
    @planet2    = @universe.create_planet( [1, 40] )

    @ship_in_fleet  = @planet1.build_ship
    @ship_in_planet = @planet2.build_ship

    @fleet = @planet1.build_fleet( @planet2, [@ship_in_fleet] )
  end

  # def test_initial_status
  #   assert_equal( :traveling, @fleet.status )
  #   assert_equal( @planet2, @fleet.traveling_to )
  #   assert_equal( 1, @fleet.process_remaining_ticks )
  # end

  # def test_start_combat
  #   @universe.cycle
  #   @universe.cycle

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
    @universe.cycle
    @universe.cycle
    @universe.cycle

  end

end