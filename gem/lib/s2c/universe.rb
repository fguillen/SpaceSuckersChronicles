require 'benchmark'

module S2C
  class Universe
    attr_accessor(
      :planets,
      :logs,
      :status,
      :tick,
      :size,
      :config
   )

    def initialize(config)
      @logs     = []
      @planets  = []
      @config   = config
      @tick     = 0 # Universe's time
    end

    def create_planet(id, position = nil)
      planet = S2C::Models::Planet.new(self, id, position)

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
            cycle
          end

        sleep(config['universe']['tick_seconds'].to_i - time)
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
      @logs <<
        Kernel.sprintf(
          "(%010d) [%10s] > %s",
          tick,
          element.id,
          message
       )
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

    def to_hash
      planets_hash = planets.map { |e| e.to_hash }
      ships_hash   = ships.map { |e| e.to_hash }
      fleets_hash  = fleets.map { |e| e.to_hash }

      {
        :planets  => planets_hash,
        :fleets   => fleets_hash,
        :logs     => logs,
        :status   => status,
        :tick     => tick,
        :ships    => ships_hash,
        :id       => id
      }
    end
  end
end