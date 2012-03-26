module S2C
  module Utils
    def self.get_random( array )
      array.sample
    end

    def self.planet_distance(planet1, planet2)
      Math.sqrt(
        (planet2.position[0] - planet1.position[0]) ** 2 +
        (planet2.position[1] - planet1.position[1]) ** 2
      ).round
    end

    def self.travel_ticks(planet1, planet2, velocity)
      distance = S2C::Utils.planet_distance(planet1, planet2)
      result = (distance / velocity).round

      result
    end

    def self.feed_universe( universe )
      store = S2C::Store.new( universe )

      planets = []

      planets[0]  = store.create_planet( [1, 1] )
      planets[1]  = store.create_planet( [1, 2] )
      planets[2]  = store.create_planet( [1, 3] )
      planets[3]  = store.create_planet( [1, 4] )
      planets[4]  = store.create_planet( [2, 1] )
      planets[5]  = store.create_planet( [2, 2] )
      planets[6]  = store.create_planet( [2, 3] )
      planets[7]  = store.create_planet( [2, 4] )
      planets[8]  = store.create_planet( [3, 1] )
      planets[9] = store.create_planet( [3, 2] )
      planets[10] = store.create_planet( [3, 3] )
      planets[11] = store.create_planet( [3, 4] )

      planets.each do |planet|
        store.furnish_planet( planet )
        planet.mine.start_produce
      end

      ship1    = store.create_ship( planets[0] )
      ship2    = store.create_ship( planets[0] )
      ship3    = store.create_ship( planets[0] )

      3.times { store.create_ship( planets[1] ) }
      3.times { store.create_ship( planets[2] ) }
      3.times { store.create_ship( planets[3] ) }
      3.times { store.create_ship( planets[4] ) }

      3.times { planets[0].hangar.build_ship }

      fleet1 = store.create_fleet( planets[0], planets[1], [ship1, ship2] )

      universe
    end

  end
end