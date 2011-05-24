require_relative 'test_helper'

class ConfigTest < Test::Unit::TestCase
  
  RESPONSES = {
    'http://myhost:port/universe'         => 'show_universe',
    'http://myhost:port/universe/planets' => 'show_planets',
    'http://myhost:port/universe/ships'   => 'show_ships'
  }
  
  def setup
    @commander = S2C::Client::Commander.new('myhost:port')
    
    RESPONSES.each do |key, value|
      @commander.
        stubs(:get).
        with(key).
        returns(File.read("#{FIXTURES_PATH}/#{value}.json"))
    end
  end
  
  def test_initialize
    assert_equal("http://myhost:port", @commander.root)
  end
  
  def test_universe
    universe = @commander.universe
    assert_equal(3, universe['planets'].size)
    assert_equal(467, universe['logs'].size)
  end
  
  def test_get_planets
    planets = @commander.get_planets
    assert_equal(3, planets.size)
  end
  
  def test_get_ships
    ships = @commander.get_ships
    assert_equal(2, ships.size)
    assert_equal('ship', ships[0]['type'])
  end
  
  def test_create_planet
    @commander.
      expects(:post).
      with("http://myhost:port/universe/planet", { :name => 'jupiter' })
      
    @commander.create_planet('jupiter')
  end
  
  def test_build_mine
    @commander.
      expects(:post).
      with("http://myhost:port/universe/planets/jupiter/mines")
      
    @commander.build_mine('jupiter')
  end
  
  def test_build_ship
    @commander.
      expects(:post).
      with("http://myhost:port/universe/planets/jupiter/ships")
      
    @commander.build_ship('jupiter')
  end
  
  def test_travel
    @commander.
      expects(:post).
      with(
        "http://myhost:port/universe/ships/111/travel",
        { :planet_name => 'jupiter' }
      )
      
    @commander.travel('111', 'jupiter')
  end
  
  def test_log
    assert_match('(0000000000) [  Universe] > Start run', @commander.log)
  end
  
  def test_stats
    assert_match(
      File.read("#{FIXTURES_PATH}/stats.txt"),
      @commander.stats
    )
  end

  def test_stats
    assert_match(
      File.read("#{FIXTURES_PATH}/map.txt"),
      @commander.map
    )
  end
  
end