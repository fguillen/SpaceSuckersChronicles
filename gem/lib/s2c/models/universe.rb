require 'benchmark'

module S2C
  module Models
    class Universe < ActiveRecord::Base
      self.table_name = :universe
      before_validation( :on => :create ) { setup }

      validates_presence_of :tick
      validates_presence_of :name
      validates_uniqueness_of :name

      has_many :units,    :class_name => "S2C::Models::Units::Base"
      has_many :planets,  :class_name => "S2C::Models::Units::Planet"
      has_many :fleets,   :class_name => "S2C::Models::Units::Fleet"
      has_many :ships,    :class_name => "S2C::Models::Units::Ship"

      def setup
        self.tick = 0
      end

      def step
        self.tick += 1

        S2C::Global.logger.log( self, "Start step" )

        units.each do |unit|
          unit.work
        end

        self.save!

        S2C::Global.logger.log( self, "End step" )
      end

      def start
        Thread.new { run }
      end

      def end
        @status = :ending
      end

      def run
        S2C::Global.logger.log( self, "Start run" )

        while( @status != :ending )
          time =
            Benchmark.realtime do
              begin
                step
              rescue Exception => e
                S2C::Global.logger.log( self, "ERROR: #{e}" )
                puts "XXX: backtrace:"
                puts e.backtrace.join( "\n" )
                raise e
              end
            end

          rest_time = 1 - time
          S2C::Global.logger.log( self, "Resting #{rest_time * 1000} millisecond" )
          sleep( rest_time )
        end

        S2C::Global.logger.log( self, "End run" )
      end

    end
  end
end