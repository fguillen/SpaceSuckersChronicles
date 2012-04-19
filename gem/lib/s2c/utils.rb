module S2C
  module Utils
    def self.get_random( array )
      array.sample
    end

    def self.planet_distance( planet1, planet2 )
      Math.sqrt(
        (planet2.position[0] - planet1.position[0]) ** 2 +
        (planet2.position[1] - planet1.position[1]) ** 2
      ).round
    end

    def self.travel_ticks( planet1, planet2, velocity )
      distance = S2C::Utils.planet_distance(planet1, planet2)
      result = (distance / velocity).round

      result
    end

    def self.feed_universe( universe )
      universe = S2C::Global.universe

      planets = []

      planets[0]  = universe.planets.create!( :position =>  [100, 100] )
      planets[1]  = universe.planets.create!( :position =>  [100, 200] )
      planets[2]  = universe.planets.create!( :position =>  [100, 300] )
      planets[3]  = universe.planets.create!( :position =>  [100, 400] )
      planets[4]  = universe.planets.create!( :position =>  [200, 100] )
      planets[5]  = universe.planets.create!( :position =>  [200, 200] )
      planets[6]  = universe.planets.create!( :position =>  [200, 300] )
      planets[7]  = universe.planets.create!( :position =>  [200, 400] )
      planets[8]  = universe.planets.create!( :position =>  [300, 100] )
      planets[9]  = universe.planets.create!( :position =>  [300, 200] )
      planets[10] = universe.planets.create!( :position =>  [300, 300] )
      planets[11] = universe.planets.create!( :position =>  [300, 400] )

      planets.each do |planet|
        planet.furnish
        planet.mine.start_produce
      end

      ship1    = planets[0].ships.create!
      ship2    = planets[0].ships.create!
      ship3    = planets[0].ships.create!
      ship4    = planets[0].ships.create!

      40.times { planets[1].ships.create! }
      3.times { planets[2].ships.create! }
      3.times { planets[3].ships.create! }
      3.times { planets[4].ships.create! }

      3.times { planets[0].hangar.start_build_ship }

      fleet =
        S2C::Models::Units::Fleet.arrange(
          :base   => planets[0],
          :target => planets[1],
          :ships  => [ship1, ship2]
        )

      fleet.start_trip


      fleet2 =
        S2C::Models::Units::Fleet.arrange(
          :base   => planets[0],
          :target => planets[1],
          :ships  => [ship3, ship4]
        )

      fleet2.start_trip

      universe
    end

  end
end