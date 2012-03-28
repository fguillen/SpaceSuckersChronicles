require_relative '../test_helper'

module S2C::Utils
  def self.get_random( array )
    array.first
  end
end

class FleetCombatSuccessTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet1    = @universe.planets.create!( :position => [1, 1] )
    @planet2    = @universe.planets.create!( :position => [1, 3] )

    @ship1      = @planet1.ships.create!
    @ship2      = @planet1.ships.create!
    @ship3      = @planet1.ships.create!

    @ship4      = @planet2.ships.create!
    @ship5      = @planet2.ships.create!

    @fleet =
      S2C::Models::Units::Fleet.arrange(
        :base   => @planet1,
        :target => @planet2,
        :ships  => [@ship1, @ship2]
      )
    @fleet.start_trip
  end

  # def test_setup
  #   assert_equal( "travel", @fleet.job.name )
  #   assert_equal( @planet1.id, @fleet.base.id )
  #   assert_equal( @planet2.id, @fleet.target.id )
  #   assert_equal( 2, @fleet.ships.size )
  #   assert_equal( 2, @fleet.job.ticks_remain )
  # end

  # def test_start_combat
  #   @universe.step
  #   @universe.step
  #   @universe.step # Fleet arrives to the planet and decide to attack
  #   reload_units

  #   assert_equal( "combat", @fleet.job.name )
  #   assert_equal( @planet2.id, @fleet.job.target.id )
  # end

  def test_combat
    @universe.step
    @universe.step
    @universe.step # Fleet arrives to the planet and decide to attack
    reload_units

    assert_equal( "combat", @fleet.job.name )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( true,   @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.ships.include?( @ship4 ) )
    assert_equal( true,   @planet2.ships.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( 10,     @ship2.life )
    assert_equal( 10,     @ship3.life )
    assert_equal( 10,     @ship4.life )
    assert_equal( 10,     @ship5.life )

    @universe.step
    reload_units

    assert_equal( "combat", @fleet.job.name )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( true,   @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( true,   @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( true,   @planet2.ships.include?( @ship4 ) )
    assert_equal( true,   @planet2.ships.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 2,      @ship1.life )
    assert_equal( 10,     @ship2.life )
    assert_equal( 10,     @ship3.life )
    assert_equal( 2,      @ship4.life )
    assert_equal( 10,     @ship5.life )

    @universe.step
    reload_units

    assert_equal( "combat", @fleet.job.name )
    assert_equal( false,  @universe.units.include?( @ship1 ) )
    assert_equal( true,   @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( false,  @universe.units.include?( @ship4 ) )
    assert_equal( true,   @universe.units.include?( @ship5 ) )
    assert_equal( false,  @planet2.ships.include?( @ship4 ) )
    assert_equal( true,   @planet2.ships.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 2,      @ship1.life )
    assert_equal( 10,     @ship2.life )
    assert_equal( 10,     @ship3.life )
    assert_equal( 2,      @ship4.life )
    assert_equal( 6,      @ship5.life )

    @universe.step
    reload_units

    assert_equal( "combat", @fleet.job.name )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( false,  @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( false,  @universe.units.include?( @ship4 ) )
    assert_equal( false,  @universe.units.include?( @ship5 ) )
    assert_equal( false,  @planet2.ships.include?( @ship4 ) )
    assert_equal( false,  @planet2.ships.include?( @ship5 ) )
    assert_equal( true,   @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( -1,     @ship2.life )
    assert_equal( 5,      @ship3.life )
    assert_equal( -2,     @ship4.life )
    assert_equal( -2,     @ship5.life )

    @universe.step
    reload_units

    assert( @fleet.job.nil? )
    assert_equal( true,   @universe.units.include?( @ship1 ) )
    assert_equal( false,  @universe.units.include?( @ship2 ) )
    assert_equal( true,   @universe.units.include?( @ship3 ) )
    assert_equal( false,  @universe.units.include?( @ship4 ) )
    assert_equal( false,  @universe.units.include?( @ship5 ) )
    assert_equal( false,  @planet2.ships.include?( @ship4 ) )
    assert_equal( false,  @planet2.ships.include?( @ship5 ) )
    assert_equal( true,   @planet2.ships.include?( @ship3 ) )
    assert_equal( false,  @universe.fleets.include?( @fleet ) )
    assert_equal( 10,     @ship1.life )
    assert_equal( -1,     @ship2.life )
    assert_equal( 5,      @ship3.life )
    assert_equal( -2,     @ship4.life )
    assert_equal( -2,     @ship5.life )
  end

  def reload_units
      @universe.reload
      @planet1.reload
      @planet2.reload
      @ship1.reload if S2C::Models::Units::Base.exists?( @ship1 )
      @ship2.reload if S2C::Models::Units::Base.exists?( @ship2 )
      @ship3.reload if S2C::Models::Units::Base.exists?( @ship3 )
      @ship4.reload if S2C::Models::Units::Base.exists?( @ship4 )
      @ship5.reload if S2C::Models::Units::Base.exists?( @ship5 )
      @fleet.reload if S2C::Models::Units::Base.exists?( @fleet )
  end
end