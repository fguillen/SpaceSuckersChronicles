module S2C
  module Models
    module Jobs
      class Base < ActiveRecord::Base
        self.table_name = "jobs"

        belongs_to :unit, :class_name => "S2C::Models::Units::Base"

        def step
          raise Exception, "Job.step should be defined"
        end

        def finish?
          raise Exception, "Job.finish? should be defined"
        end
      end
    end
  end
end