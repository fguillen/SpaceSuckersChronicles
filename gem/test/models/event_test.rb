require_relative "../test_helper"

class EventTest < Test::Unit::TestCase

  def setup
    super
  end

  def test_create
    assert_difference "S2C::Models::Event.count", 1 do
      S2C::Models::Event.create!(
        :universe_id  => 1,
        :tick         => 1,
        :family       => :ship,
        :message      => "message"
      )
    end

    event = S2C::Models::Event.last

    assert_equal( 1,          event.universe_id )
    assert_equal( 1,          event.tick )
    assert_equal( "ship",     event.family )
    assert_equal( "message",  event.message )
  end

end