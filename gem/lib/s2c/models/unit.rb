module S2C
  module Models
    class Unit
      attr_reader(
        :id,
        :planet,
        :level,
        :type,
        :job
      )

      def initialize(planet)
        S2C::Utils.log( self, "Starting contruction Construction" )

        @id     ||= (Time.now.to_i + rand(1000)).to_s
        @planet ||= planet
        @level  ||= 0
        @job    ||= nil
      end

      def work
        S2C::Utils.log( self, "Working" )

        @job.step if @job
      end
    end
  end
end