    class ThreadTest
      def run
    Thread.new do
      puts "step 1"
      sleep( 0.5 )
      puts "step 2"
      sleep( 0.5 )
      puts "step 3"
      sleep( 0.5 )
      puts "end"
    end
      end
    end