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
        "job"        => job_to_hash( planet.job )
      }
    end

    def self.ship_to_hash( ship )
      {
        "id"         => ship.id,
        "base_id"    => ship.base.id,
        "life"       => ship.life,
        "atack"      => ship.atack,
        "defense"    => ship.defense,
        "job"        => job_to_hash( ship.job )
      }
    end

    def self.fleet_to_hash( fleet )
      {
        "id"             => fleet.id,
        "base_id"        => fleet.base.id,
        "destination_id" => fleet.destination.id,
        "job"            => job_to_hash( fleet.job )
      }
    end

    def self.job_to_hash( job )
      return job_travel_to_hash( job ) if job.instance_of?( S2C::Jobs::Travel )
      return job_combat_to_hash( job ) if job.instance_of?( S2C::Jobs::Combat )
      return nil
    end

    def self.job_travel_to_hash( job )
      {
        "type"            => "travel",
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain,
        "destination_id"  => job.destination.id
      }
    end

    def self.job_combat_to_hash( job )
      {
        "type"          => "combat",
        "target_ids"    => job.targets.map { |e| e.id }
      }
    end
  end
end