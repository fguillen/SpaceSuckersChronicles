module S2C
  module Client
    class Commander
      
      attr_reader :root
      
      def initialize(host)
        @root = "http://#{host}"
      end
      
      def get_planets
        get_json "#{root}/universe/planets"
      end
      
      def get_ships
        get_json "#{root}/universe/ships"
      end
      
      def create_planet(name)
        post "#{root}/universe/planet", { :name => name }
      end
      
      def build_mine(planet_name)
        post "#{root}/universe/planets/#{planet_name}/mines"
      end
      
      def build_ship(planet_name)
        post "#{root}/universe/planets/#{planet_name}/ships"
      end
      
      def travel(ship_identity, planet_name)
        post(
          "#{root}/universe/ships/#{ship_identity}/travel",
          { :planet_name => planet_name }
        )
      end
      
      def log
        universe['logs'].join("\n")
      end
      
      def stats
        S2C::Client::Stats.stats(universe).join("\n")
      end
      
      def map
        HighLine.new.color(universe['map'].join("\n"), :on_white, :black, :bold)
      end
      
      def universe
        get_json "#{root}/universe"
      end
      
      def get_json(url)
        JSON.parse(get(url))
      end
      
      def get(url)
        c = Curl::Easy.new(URI.escape(url))
        c.perform
        c.body_str
      end
      
      def post(url, params = {})
        Curl::Easy.http_post(
          URI.escape(url),
          params.map { |k,v| "#{k}=#{URI.escape(v)}" }
        )
      end
      
    end
  end
end