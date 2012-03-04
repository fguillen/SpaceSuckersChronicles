# The static content rooted in the current working directory
# Dir.pwd => http://0.0.0.0:3000/
#

root = Dir.pwd
puts ">>> Serving: #{root}"
run Rack::Directory.new("#{root}")