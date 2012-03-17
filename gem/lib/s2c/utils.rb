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
      (distance / velocity).round
    end

    def self.feed_universe( universe )
      store = S2C::Store.new( universe )

      planet1  = store.create_planet( [1, 1] )
      planet2  = store.create_planet( [1, 2] )
      planet3  = store.create_planet( [1, 3] )
      planet4  = store.create_planet( [1, 4] )
      planet5  = store.create_planet( [2, 1] )
      planet6  = store.create_planet( [2, 2] )
      planet7  = store.create_planet( [2, 3] )
      planet8  = store.create_planet( [2, 4] )
      planet9  = store.create_planet( [3, 1] )
      planet10 = store.create_planet( [3, 2] )
      planet11 = store.create_planet( [3, 3] )
      planet12 = store.create_planet( [3, 4] )


      3.times { store.create_ship( planet1 ) }
      3.times { store.create_ship( planet2 ) }
      3.times { store.create_ship( planet3 ) }
      3.times { store.create_ship( planet4 ) }
      3.times { store.create_ship( planet5 ) }

      universe
    end

  end
end