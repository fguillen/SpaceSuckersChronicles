module S2C
  module Models
    module Jobs
      class Base < ActiveRecord::Base
        self.table_name = :jobs

        before_validation( :on => :create ) { setup }
        before_create :charge

        belongs_to :unit, :class_name => "S2C::Models::Units::Base"

        validate :validate_cost, :on => :create
        validates_presence_of :unit_id
        validates_presence_of :callback
        validates_presence_of :cost

        def setup
          self.cost ||= calculate_cost
        end

        def step
          raise Exception, "Job.step should be defined"
        end

        def finish?
          raise Exception, "Job.finish? should be defined"
        end

        def name
          raise Exception, "Job.name should be defined"
        end

        def calculate_cost
          raise Exception, "Job.calculate_cost should be defined"
        end

        def charge
          unit.base.remove_stuff( cost )
        end

        def callback
          read_attribute( :callback ) ? read_attribute( :callback ).to_sym : nil
        end

        def validate_cost
          errors.add( :cost, "Not enough stuff, needed: #{cost}" ) if cost > unit.base.stuff
        end
      end
    end
  end
end