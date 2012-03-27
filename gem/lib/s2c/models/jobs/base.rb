module S2C
  module Models
    module Jobs
      class Base < ActiveRecord::Base
        self.table_name = :jobs

        before_validation( :on => :create ) { setup }

        belongs_to :unit, :class_name => "S2C::Models::Units::Base"

        validates_presence_of :unit_id
        validates_presence_of :callback

        def step
          raise Exception, "Job.step should be defined"
        end

        def finish?
          raise Exception, "Job.finish? should be defined"
        end

        def name
          raise Exception, "Job.name should be defined"
        end

        def setup
          # empty
        end

        def callback
          read_attribute( :callback ) ? read_attribute( :callback ).to_sym : nil
        end
      end
    end
  end
end