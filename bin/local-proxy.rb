require 'rubygems'
require 'em-proxy'

listen_port=ARGV[0]
relay_port=ARGV[1]

puts "I am listening on #{listen_port}"
puts "I am relaying to #{relay_port}"

Proxy.start(:host => "0.0.0.0", :port => listen_port, :debug => true) do |conn|
  conn.server :srv, :host => "127.0.0.1", :port => relay_port

  # modify / process request stream
  conn.on_data do |data|
    p [:on_data, data]
    data
  end

  # modify / process response stream
  conn.on_response do |backend, resp|
    p [:on_response, backend, resp]
    resp
  end

  # termination logic
  conn.on_finish do |backend, name|
    p [:on_finish, name]

    # terminate connection (in duplex mode, you can terminate when prod is done)
    unbind if backend == :srv
  end
end