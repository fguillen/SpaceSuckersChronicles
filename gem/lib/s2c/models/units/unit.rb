module S2C
  module Models
    module Units
      class Base < ActiveRecord::Base

        self.table_name = :units

        has_one :job
        has_one :base

        def work
          S2C::Global.logger.log( self, "Working" )

          self.job.step if self.job
        end
      end
    end
  end
end