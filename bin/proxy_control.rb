require 'rubygems'
require 'daemons'
require 'em-proxy'

# To run:
# ruby proxy_control.rb start -- listen_port relay_port
# To stop:
# ruby proxy_control.rb stop
# Example:
# ruby proxy_control.rb start -- 80 3000

Daemons.run('local-proxy.rb', options= 
{
:dir_mode => :system,
:multiple => true
}
)


