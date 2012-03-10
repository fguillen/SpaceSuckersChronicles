require 'benchmark'

module S2C
  class Universe
    attr_accessor(
      :planets,
      :logs,
      :status,
      :tick,
      :size,
      :config,
      :last_id
   )

    def initialize(config, opts = {})
      @logs     = []
      @planets  = []
      @config   = config
      @tick     = opts["tick"] || 0 # Universe's time
      @last_id  = opts["last_id"] || 0
    end

    def create_planet(position)
      planet =
        S2C::Models::Planet.new(
          self,
          {
            "id"        => self.generate_id( "X" ),
            "position"  => position
          }
        )

      @planets << planet

      planet
    end

    def cycle
      log(self, "Start cycle")

      @planets.each do |planet|
        planet.constructions.each do |construction|
          construction.work
        end
      end

      @tick += 1

      log(self, "End cycle")
    end

    def start
      Thread.new { run }
    end

    def end
      @status = :ending
    end

    def run
      log(self, "Start run")

      while(status != :ending)
        time =
          Benchmark.realtime do
            begin
              cycle
            rescue Exception => e
              log( self, "ERROR: #{e}" )
              raise e
            end
          end

        rest_time = config['universe']['tick_seconds'].to_i - time
        log( self, "Resting #{rest_time * 1000} millisecond" )
        sleep( rest_time )
      end

      log(self, "End run")
    end

    def id
      'Universe'
    end

    def stats
      "planets:#{planets.size}"
    end

    def log(element, message)
      message =
        Kernel.sprintf(
          "(%010d) [%10s] > %s",
          tick,
          element.id,
          message
       )

      # puts "XXX: #{message}"

      @logs << message
    end

    def print_logs(last_lines = 10)
      last_lines = logs.size  if last_lines > logs.size

      logs[-(last_lines),last_lines]
    end

    def ships
      result = []

      planets.each do |planet|
        result += planet.constructions.select { |e| e.type == 'ship' }
      end

      fleets.each do |fleet|
        result.concat( fleet.ships )
      end

      result
    end

    def fleets
      result = []

      planets.each do |planet|
        result += planet.constructions.select { |e| e.type == 'fleet' }
      end

      result
    end

    def get_planet(id)
      planets.select { |e| e.id == id }.first
    end

    def get_ship(id)
      ships.select { |e| e.id == id }.first
    end

    def get_fleet(id)
      fleets.select { |e| e.id == id }.first
    end

    def generate_id( prefix )
      @last_id += 1
      Kernel.sprintf( "#{prefix}%03d", last_id )
    end

    def to_hash
      planets_hash = planets.map { |e| e.to_hash }
      ships_hash   = ships.map { |e| e.to_hash }
      fleets_hash  = fleets.map { |e| e.to_hash }

      {
        :planets  => planets_hash,
        :fleets   => fleets_hash,
        # :logs     => logs,
        :status   => status,
        :tick     => tick,
        :ships    => ships_hash,
        :id       => id,
        :last_id  => last_id
      }
    end

    def from_hash( hash )
      planets =
        hash["planets"].map do |opts|
          planet = S2C::Models::Planet.new( self, opts )

          opts["ship_ids"].each do |ship_id|
            ship_opts = hash["ships"].select{ |e| e["id"] == ship_id }.first
            ship = S2C::Models::Ship.new( planet, ship_opts )

            planet.constructions << ship
            planet.ships << ship
          end

          @planets << planet
        end

      fleets =
        hash["fleets"].map do |opts|
          planet = self.get_planet( opts["planet_id"] )

          fleet = S2C::Models::Fleet.new( planet, opts )

          opts["ship_ids"].each do |ship_id|
            ship_opts = hash["ships"].select{ |e| e["id"] == ship_id }.first
            ship = S2C::Models::Ship.new( planet, ship_opts )
            fleet.ships << ship
          end

          planet.constructions << fleet
        end
    end
  end
end