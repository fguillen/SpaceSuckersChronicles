require_relative "../test_helper"

class CombatTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Planet.new( [1, 1] )
    @ship1  = S2C::Models::Ship.new( @planet )
    @ship2  = S2C::Models::Ship.new( @planet )

    @planet.units = [@ship1, @ship2]

    @ship3  = S2C::Models::Ship.new( @planet )
    @ship4  = S2C::Models::Ship.new( @planet )
    @ship5  = S2C::Models::Ship.new( @planet )

    @fleet  = S2C::Models::Fleet.new( @planet, nil, [@ship3, @ship4, @ship5] )

    @combat =
      S2C::Jobs::Combat.new(
        :unit         => @fleet,
        :callback     => :callback_method,
        :targets      => [@planet]
      )
  end

  def test_setup
    assert_equal( 2, @planet.units.size )
    assert_equal( 3, @fleet.units.size )
  end

  def test_initialize
    assert_equal( @fleet,            @combat.unit )
    assert_equal( :callback_method,  @combat.callback )
    assert_equal( [@planet],         @combat.targets )
  end

  def test_finish
    assert_equal( false, @combat.finish? )

    @planet.units = []
    assert_equal( true, @combat.finish? )

    @planet.units = [@ship1]
    assert_equal( false, @combat.finish? )

    @combat.instance_variable_set( :@targets, [] )
    assert_equal( true, @combat.finish? )
  end

  def test_step
    target_unit = mock()
    @combat.stubs( :random_target_unit ).returns( target_unit )

    @combat.expects( :hit ).with( @ship3, target_unit )
    @combat.expects( :hit ).with( @ship4, target_unit )
    @combat.expects( :hit ).with( @ship5, target_unit )

    @combat.step
  end

  def test_step_finish
    @fleet.expects( :callback_method )
    @combat.stubs( :finish? ).returns( true )
    @combat.expects( :hit ).never

    @combat.step
  end

  def test_hit_with_damage
    @ship1.attack   = 10
    @ship2.defense = 8
    @ship2.life    = 4

    @combat.hit( @ship1, @ship2 )

    assert_equal( 2, @ship2.life )
  end

  def test_hit_without_damage
    @ship1.attack   = 10
    @ship2.defense = 20
    @ship2.life    = 4

    @combat.hit( @ship1, @ship2 )

    assert_equal( 4, @ship2.life )
  end

  def test_hit_with_total_destruction
    @ship1.attack   = 10
    @ship2.defense = 6
    @ship2.life    = 4

    S2C::Global.store.expects( :remove_ship ).with( @ship2 )

    @combat.hit( @ship1, @ship2 )
  end

end
