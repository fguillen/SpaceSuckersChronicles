module S2C
  module Models
    module Units
      class Base < ActiveRecord::Base

        self.table_name = :units

        has_one :job, :class_name => "S2C::Models::Jobs::Base", :foreign_key => :unit_id
        has_one :base

        def work
          S2C::Global.logger.log( self, "Working" )

          self.job.step if self.job
        end
      end
    end
  end
end