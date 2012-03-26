module S2C
  module JSONer
    def self.to_json( universe )
      JSON.pretty_generate( to_hash( universe ) )
    end

    def self.to_hash( universe )
      {
        "universe" => universe_to_hash( universe ),
        "planets"  => universe.planets.map { |e| planet_to_hash( e ) },
        "fleets"   => universe.fleets.map  { |e| fleet_to_hash( e ) },
        "ships"    => universe.ships.map   { |e| ship_to_hash( e ) }
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
        "silo"       => silo_to_hash( planet.silo ),
        "mine"       => mine_to_hash( planet.mine ),
        "parking"    => parking_to_hash( planet.parking ),
        "hangar"     => hangar_to_hash( planet.hangar ),
        "job"        => job_to_hash( planet.job )
      }
    end

    def self.mine_to_hash( mine )
      return {} if mine.nil?

      {
        "id"          => mine.id,
        "production"  => mine.production,
        "level"       => mine.level,
        "job"         => job_to_hash( mine.job )
      }
    end

    def self.silo_to_hash( silo )
      return {} if silo.nil?

      {
        "id"        => silo.id,
        "capacity"  => silo.capacity,
        "stuff"     => silo.stuff,
        "level"     => silo.level,
        "job"       => job_to_hash( silo.job )
      }
    end

    def self.parking_to_hash( parking )
      return {} if parking.nil?

      {
        "id"        => parking.id,
        "capacity"  => parking.capacity,
        "ships"     => parking.base.units.size,
        "level"     => parking.level,
        "job"       => job_to_hash( parking.job )
      }
    end

    def self.hangar_to_hash( hangar )
      return {} if hangar.nil?

      {
        "id"                => hangar.id,
        "production_ticks"  => hangar.production_ticks,
        "building_ships"    => hangar.building_ships.size,
        "level"             => hangar.level,
        "job"               => job_to_hash( hangar.job )
      }
    end

    def self.ship_to_hash( ship )
      {
        "id"         => ship.id,
        "base_id"    => ship.base.id,
        "life"       => ship.life,
        "attack"      => ship.attack,
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
      return nil                                if job.nil?
      return job_travel_to_hash( job )          if job.instance_of?( S2C::Models::Jobs::Travel )
      return job_combat_to_hash( job )          if job.instance_of?( S2C::Models::Jobs::Combat )
      return job_upgrade_to_hash( job )         if job.instance_of?( S2C::Models::Jobs::Upgrade )
      return job_produce_stuff_to_hash( job )   if job.instance_of?( S2C::Models::Jobs::ProduceStuff )
      return job_build_ship_to_hash( job )      if job.instance_of?( S2C::Models::Jobs::BuildShip )
      raise "job type not supported: '#{job.class}'"
    end

    def self.job_travel_to_hash( job )
      {
        "type"            => "travel",
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain,
        "destination_id"  => job.destination.id
      }
    end

    def self.job_upgrade_to_hash( job )
      {
        "type"            => "upgrade",
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain
      }
    end

    def self.job_build_ship_to_hash( job )
      {
        "type"            => "build_ship",
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain
      }
    end

    def self.job_produce_stuff_to_hash( job )
      {
        "type"            => "produce_stuff"
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