require_relative '../test_helper'

module S2C::Utils
  def self.get_random( array )
    array.first
  end
end

class FleetCombatFailureTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet1    = S2C::Global.store.create_planet( [1, 1] )
    @planet2    = S2C::Global.store.create_planet( [1, 2] )

    @ship1      = S2C::Global.store.create_ship( @planet1 )
    @ship2      = S2C::Global.store.create_ship( @planet1 )
    @ship3      = S2C::Global.store.create_ship( @planet1 )

    @ship4      = S2C::Global.store.create_ship( @planet2 )
    @ship5      = S2C::Global.store.create_ship( @planet2 )

    @fleet      = S2C::Global.store.create_fleet( @planet1, @planet2, [@ship2, @ship3] )

    @ship1.id = "ship1"
    @ship2.id = "ship2"
    @ship3.id = "ship3"
    @ship4.id = "ship4"
    @ship5.id = "ship5"

    @fleet.id = "fleet"

    @planet1.id = "planet1"
    @planet2.id = "planet2"

    @planet2.units.each do |ship|
      ship.atack   = 10
      ship.defense = 7
      ship.life    = 8
    end

    @fleet.units.each do |ship|
      ship.atack   = 10
      ship.defense = 7
      ship.life    = 4
    end
  end

  def test_setup
    assert( @fleet.job.instance_of?( S2C::Jobs::Travel ) )
    assert_equal( @planet2.id, @fleet.destination.id )
    assert_equal( 1, @fleet.job.ticks_remain )
  end

  def test_start_combat
    @universe.step # Fleet arrives to the planet and decide to atack

    assert( @fleet.job.instance_of?( S2C::Jobs::Combat ) )
    assert_equal( 1, @fleet.job.targets.size )
    assert_equal( @planet2.id, @fleet.job.targets.first.id )

    assert( @planet2.job.instance_of?( S2C::Jobs::Combat ) )
    assert_equal( 1, @planet2.job.targets.size )
    assert_equal( @fleet.id, @planet2.job.targets.first.id )
  end

  def test_combat
    @universe.step # Fleet arrives to the planet and decide to atack

    assert( @fleet.job.instance_of?( S2C::Jobs::Combat ) )
    assert( @planet2.job.instance_of?( S2C::Jobs::Combat ) )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( true,   @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.units.include?( @ship4 ) )
    assert_equal( true,   @planet2.units.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 10,      @ship1.life )
    assert_equal( 4,      @ship2.life )
    assert_equal( 4,      @ship3.life )
    assert_equal( 8,      @ship4.life )
    assert_equal( 8,      @ship5.life )

    @universe.step

    assert( @fleet.job.instance_of?( S2C::Jobs::Combat ) )
    assert( @planet2.job.instance_of?( S2C::Jobs::Combat ) )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( false,  @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.units.include?( @ship4 ) )
    assert_equal( true,   @planet2.units.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( -2,     @ship2.life )
    assert_equal( 4,      @ship3.life )
    assert_equal( 5,      @ship4.life )
    assert_equal( 8,      @ship5.life )

    @universe.step

    assert( @fleet.job.nil? )
    assert( @planet2.job.instance_of?( S2C::Jobs::Combat ) )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( false,  @universe.units.include?( @ship2 ) )
    assert_equal( false,  @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.units.include?( @ship4 ) )
    assert_equal( true,   @planet2.units.include?( @ship5 ) )
    assert_equal( false,  @planet2.units.include?( @ship3 ) )
    assert_equal( false,  @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( -2,     @ship2.life )
    assert_equal( -2,     @ship3.life )
    assert_equal( 5,      @ship4.life )
    assert_equal( 8,      @ship5.life )

    @universe.step

    assert( @fleet.job.nil? )
    assert( @planet2.job.nil? )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( false,  @universe.units.include?( @ship2 ) )
    assert_equal( false,  @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.units.include?( @ship4 ) )
    assert_equal( true,   @planet2.units.include?( @ship5 ) )
    assert_equal( false,  @planet2.units.include?( @ship3 ) )
    assert_equal( false,  @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( -2,     @ship2.life )
    assert_equal( -2,     @ship3.life )
    assert_equal( 5,      @ship4.life )
    assert_equal( 8,      @ship5.life )
  end

end