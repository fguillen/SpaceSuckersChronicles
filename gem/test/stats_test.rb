require_relative 'test_helper'

class StatsTest < Test::Unit::TestCase
  def setup 
    @config = S2C::Config.new( "#{FIXTURES_PATH}/config.yml" )
  end
  
  def test_stats
    universe = S2C::Universe.new( @config )
    
    planet1 = universe.create_planet( 'x100', [1,2] )
    planet2 = universe.create_planet( 'x200', [5,8] )
    planet3 = universe.create_planet( 'yogan exsima', [45,29] )
    
    mine1 = planet1.build_mine
    mine2 = planet1.build_mine
    mine3 = planet2.build_mine
    
    ship1 = planet1.build_ship
    ship2 = planet2.build_ship
    ship3 = planet2.build_ship
    
    ship3.instance_variable_set( :@status, :traveling )
    ship3.instance_variable_set( :@traveling_to, planet3 )
    
    # puts S2C::Stats.stats( universe )
  end
end