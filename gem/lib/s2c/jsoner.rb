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
        "ships"    => universe.ships.map   { |e| ship_to_hash( e ) },
        "events"   => universe.events.map  { |e| event_to_hash( e ) },
      }
    end

    def self.event_to_hash( event )
      {
        "id"      => event.id,
        "tick"    => event.tick,
        "family"  => event.family,
        "message" => RDiscount.new( event.message ).to_html
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
        "stuff"     => silo.base.stuff,
        "level"     => silo.level,
        "job"       => job_to_hash( silo.job )
      }
    end

    def self.parking_to_hash( parking )
      return {} if parking.nil?

      {
        "id"        => parking.id,
        "capacity"  => parking.capacity,
        "ships"     => parking.base.ships.size,
        "level"     => parking.level,
        "job"       => job_to_hash( parking.job )
      }
    end

    def self.hangar_to_hash( hangar )
      return {} if hangar.nil?

      {
        "id"                => hangar.id,
        "production_ticks"  => hangar.production,
        "building_ships"    => hangar.building_ships,
        "level"             => hangar.level,
        "job"               => job_to_hash( hangar.job )
      }
    end

    def self.ship_to_hash( ship )
      {
        "id"         => ship.id,
        "base_id"    => ship.base_id,
        "life"       => ship.life,
        "attack"     => ship.attack,
        "defense"    => ship.defense,
        "job"        => job_to_hash( ship.job )
      }
    end

    def self.fleet_to_hash( fleet )
      {
        "id"             => fleet.id,
        "base_id"        => fleet.base_id,
        "target_id" => fleet.target_id,
        "job"            => job_to_hash( fleet.job )
      }
    end

    def self.job_to_hash( job )
      return nil                                if job.nil?
      return job_travel_to_hash( job )          if job.name == "travel"
      return job_combat_to_hash( job )          if job.name == "combat"
      return job_upgrade_to_hash( job )         if job.name == "upgrade"
      return job_produce_stuff_to_hash( job )   if job.name == "produce_stuff"
      return job_build_ship_to_hash( job )      if job.name == "build_ship"
      raise "job type not supported: '#{job.class}'"
    end

    def self.job_travel_to_hash( job )
      {
        "name"            => job.name,
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain,
        "target_id"  => job.target_id
      }
    end

    def self.job_upgrade_to_hash( job )
      {
        "name"            => job.name,
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain
      }
    end

    def self.job_build_ship_to_hash( job )
      {
        "name"            => job.name,
        "ticks_total"     => job.ticks_total,
        "ticks_remain"    => job.ticks_remain
      }
    end

    def self.job_produce_stuff_to_hash( job )
      {
        "name"            => job.name,
      }
    end

    def self.job_combat_to_hash( job )
      {
        "name"            => job.name,
        "target_ids"      => job.target_id
      }
    end
  end
end