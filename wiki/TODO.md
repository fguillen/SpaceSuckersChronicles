# Make the run cycle in a fixed time

The infinite loop has to take always the same time.

Think in this approach:

    while( true )
      time =
        Benchmark.realtime do
          self.cycle
        end

      sleep( 2 - time )
    end