#!/usr/bin/env ruby
require "bunny"

# conn = Bunny.new("amqps://guest:guest@173.37.4.133:30671/testx",
# :tls_ca_certificates   => ["../../certs/testca/cacert.pem"],
# :verify_peer           => false)

conn = Bunny.new("amqp://guest:guest@173.37.4.133:30672/test")

conn.start

ch   = conn.create_channel
q    = ch.queue("hello")

ch.default_exchange.publish("Hello World!", :routing_key => q.name)
puts " [x] Sent 'Hello World!'"
