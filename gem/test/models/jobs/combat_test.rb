require_relative "../../test_helper"

class CombatTest < Test::Unit::TestCase

  def setup
    super

    @planet1 = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @planet2 = S2C::Models::Units::Planet.create!( :position => [1, 1] )

    @ship1  = @planet2.ships.create!
    @ship2  = @planet2.ships.create!

    @fleet  = S2C::Models::Units::Fleet.create!( :base => @planet1, :target => @planet2 )

    @ship3  = @fleet.ships.create!
    @ship4  = @fleet.ships.create!
    @ship5  = @fleet.ships.create!

    @combat =
      S2C::Models::Jobs::Combat.create!(
        :unit     => @fleet,
        :callback => :callback,
        :target   => @planet2
      )
  end

  def test_setup
    assert_equal( @fleet,    @combat.unit )
    assert_equal( :callback, @combat.callback )
    assert_equal( @planet2,  @combat.target )
    assert_equal( "combat",  @combat.name )
    assert_equal( 0,         @combat.cost )
  end

  def test_step
    target_ship = mock()
    @combat.stubs( :random_target_ship ).returns( target_ship )

    @ship3.expects( :hit ).with( target_ship )
    @ship4.expects( :hit ).with( target_ship )
    @ship5.expects( :hit ).with( target_ship )

    unit_ship = mock()
    @combat.stubs( :random_unit_ship ).returns( unit_ship )

    @ship1.expects( :hit ).with( unit_ship )
    @ship2.expects( :hit ).with( unit_ship )

    @combat.step
  end

  def test_finish
    assert_equal( false, @combat.finish? )

    @planet2.ships.destroy_all
    assert_equal( true, @combat.finish? )
  end

end
