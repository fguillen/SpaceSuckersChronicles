require_relative "../../test_helper"

class ShipTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @ship1  = @planet.ships.create!
    @ship2  = @planet.ships.create!
  end

  def test_setup
    assert_equal( @planet,  @ship1.base )
    assert_equal( 2,        @planet.ships.count )
    assert_equal( 10,       @ship1.life )
    assert_equal( 20,       @ship1.power )
    assert_equal( 12,       @ship1.attack )
    assert_equal( 8,        @ship1.defense )
    assert_equal( "ship",   @ship1.name )
  end

  def test_hit_with_damage
    @ship1.attack  = 10
    @ship2.defense = 8
    @ship2.life    = 4

    @ship1.hit( @ship2 )

    assert_equal( 2, @ship2.life )
  end

  def test_hit_without_damage
    @ship1.attack  = 10
    @ship2.defense = 20
    @ship2.life    = 4

    @ship1.hit( @ship2 )

    assert_equal( 4, @ship2.life )
  end

  def test_hit_with_total_destruction
    @ship1.attack  = 10
    @ship2.defense = 6
    @ship2.life    = 4

    @ship2.base.expects( :remove_ship ).with( @ship2 )

    @ship1.hit( @ship2 )
  end

end