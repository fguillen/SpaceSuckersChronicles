module S2C
  module JSONer
    def self.to_json( universe )
      JSON.pretty_generate( to_hash( universe ) )
    end

    def self.to_hash( universe )
      {
        "universe" => universe_to_hash( universe ),
        "ships"    => universe.ships.map   { |e| ship_to_hash( e ) },
        "planets"  => universe.planets.map { |e| planet_to_hash( e ) },
        "fleets"   => universe.fleets.map  { |e| fleet_to_hash( e ) },
      }
    end

    def self.universe_to_hash( universe )
      {
        "tick"  => universe.tick
      }
    end

    def self.planet_to_hash( planet )
      {
        "id"         => planet.id,
        "position"   => planet.position,
      }
    end

    def self.ship_to_hash( ship )
      {
        "id"         => ship.id,
        "planet_id"  => ship.planet.id,
        "fleet_id"   => (ship.fleet ? ship.fleet.id : nil),
        "life"       => ship.life,
        "atack"      => ship.atack,
        "defense"    => ship.defense
      }
    end

    def self.fleet_to_hash( fleet )
      {
        "id"             => fleet.id,
        "planet_id"      => fleet.planet.id,
        "destination_id" => fleet.destination.id
      }
    end
  end
end