require_relative 'test_helper'
require "json"

class GlobalTest < Test::Unit::TestCase
  def test_global_variables
    assert_not_nil( S2C::Global.universe )
    assert_not_nil( S2C::Global.config )
    assert_not_nil( S2C::Global.logger )
    assert_not_nil( S2C::Global.store )
  end
end
