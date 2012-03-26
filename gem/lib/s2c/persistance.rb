module S2C
  module Persistance
    def self.save( universe, db_path )
      json = JSON.pretty_generate( to_hash( universe ) )

      File.open( db_path, "w" ) do |f|
        f.write json
      end
    end

    def self.load( db_path )
      data = JSON.parse( File.read( db_path ) )

      universe  = S2C::Universe.new
      store     = S2C::Store.new( universe )


    end
  end
end