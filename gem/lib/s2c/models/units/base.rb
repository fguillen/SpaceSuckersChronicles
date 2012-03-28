module S2C
  module Models
    module Units
      class Base < ActiveRecord::Base
        self.table_name = :units

        before_validation( :on => :create ) { setup }

        has_many   :jobs,     :class_name => "S2C::Models::Jobs::Base", :foreign_key => :unit_id, :dependent => :destroy, :order => "created_at asc"
        belongs_to :base,     :class_name => "S2C::Models::Units::Base"
        belongs_to :universe, :class_name => "S2C::Models::Universe"

        validates_presence_of :base_id
        validates_presence_of :universe_id

        def setup
          self.universe = S2C::Global.universe
        end

        def work
          if( job )
            S2C::Global.logger.log( self, "Working" )

            if job.finish?
              end_job
            else
              job.step
            end

          else
            S2C::Global.logger.log( self, "Standby" )

          end
        end

        def end_job
          S2C::Global.logger.log( self, "Ended job" )
          send( job.callback )
          job.destroy if job
        end

        def job
          jobs.first
        end

        def name
          raise Exception, "Unit.name should be defined"
        end

      end
    end
  end
end