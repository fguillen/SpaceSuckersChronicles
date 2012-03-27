require_relative "../../test_helper"

class PlanetTest < Test::Unit::TestCase
  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 2] )
  end

  def test_setup
    assert_equal( 1,    @planet.position[0] )
    assert_equal( 2,    @planet.position[1] )
    assert_equal( 0,    @planet.ships.count )
    assert_equal( 1000, @planet.stuff )
  end

  def test_after_battle
    @planet.job = S2C::Models::Jobs::Combat.create!( :unit => @planet )

    assert_difference "S2C::Models::Jobs::Combat.count", -1 do
      @planet.after_battle
    end

    @planet.reload

    assert_equal( true, @planet.job.nil? )
  end

  def test_add_ship
    @planet.add_ship
    @planet.reload
    assert_equal( 1, @planet.ships.count )
  end

  def test_add_stuff
    @planet.add_stuff( 10 )
    @planet.reload
    assert_equal( 1010, @planet.stuff )
  end
end