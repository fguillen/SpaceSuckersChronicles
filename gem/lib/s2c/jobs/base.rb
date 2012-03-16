module S2C
  module Jobs
    class Base
      attr_accessor(
        :unit,
        :callback
      )

      def initialize( unit, callback )
        @unit     = unit
        @callback = callback
      end

      def step
        raise Exception, "Job.step should be defined"
      end

      def finish?
        raise Exception, "Job.finish? should be defined"
      end

    end
  end
end