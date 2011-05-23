require_relative 'test_helper'

class ThimblSingingTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    S2C::Server::App.new
  end
  
  def setup
    S2C::Universe.any_instance.stubs(:start)
    
    config = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(config)
    
    @planet1 = @universe.create_planet( 'x100', [1,2] )
    @planet2 = @universe.create_planet( 'x200', [5,8] )
    @planet3 = @universe.create_planet( 'yogan exsima', [5,9] )
    
    @mine1 = @planet1.build_mine
    @mine2 = @planet1.build_mine
    @mine3 = @planet2.build_mine
    
    @ship1 = @planet1.build_ship
    @ship2 = @planet2.build_ship
    @ship3 = @planet2.build_ship
    @ship4 = @planet2.build_ship
    
    @ship3.instance_variable_set( :@status, :traveling )
    @ship3.instance_variable_set( :@traveling_to, @planet3 )
    
    S2C::Server::App.any_instance.stubs(:universe).returns(@universe)
  end
  
  def test_show_universe
    get '/universe'
    
    json_response = JSON.parse(last_response.body)
    
    assert_equal(3, json_response['planets'].size)
    assert_equal(0, json_response['tick'])
    assert_equal(10, json_response['size'])
  end
  
  def test_show_planets
    get '/universe/planets'
    json_response = JSON.parse(last_response.body)
    
    assert_equal(3, json_response.size)
  end
  
  def test_show_ships
    get '/universe/ships'
    json_response = JSON.parse(last_response.body)
    
    assert_equal(4, json_response.size)
  end
  
  def test_show_planet
    get '/universe/planet/x100'
    json_response = JSON.parse(last_response.body)
    
    assert_equal('x100', json_response['name'])
  end
  
  def test_create_planet
    @universe.
      expects(:create_planet).
      with('mercurio').
      returns(OpenStruct.new(:name => 'mercurio'))
      
    post "/universe/planet", :name => 'mercurio'
    
    assert last_response.redirect?
    assert_match('/universe/planet/mercurio', last_response.location)
  end
  
  def test_build_mine
    @planet1.expects(:build_mine)
    
    post "/universe/planets/#{@planet1.name}/mines"
    assert last_response.redirect?
    assert_match("/universe/planet/#{@planet1.name}", last_response.location)
  end
  
  def test_build_ship
    @planet1.expects(:build_ship)
    
    post "/universe/planets/#{@planet1.name}/ships"
    assert last_response.redirect?
    assert_match("/universe/planet/#{@planet1.name}", last_response.location)
  end
  
  def test_travel
    @ship1.expects(:travel).with(@planet2)
    
    post(
      "/universe/ships/#{@ship1.identity}/travel", 
      :planet_name => @planet2.name
    )
    
    assert last_response.redirect?
    assert_match("/universe/planet/#{@planet1.name}", last_response.location)
  end
  
  

end