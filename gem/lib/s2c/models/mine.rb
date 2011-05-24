module S2C
  module Models
    class Mine < S2C::Models::Construction
      
      def initialize(planet)
        planet.universe.log(self, "Starting construction mine")
        super(planet, 'mine')
      end

      def work_standby
        universe.log(self, "Mine extracting")
        planet.add_black_stuff(power)
      end
      
    end
  end
end