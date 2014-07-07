require 'rubygems'
require 'socket.io-client-simple'

socket = SocketIO::Client::Simple.connect 'http://192.168.1.14:8080'

## connect with parameter
## socket = SocketIO::Client::Simple.connect 'http://localhost:3000', :foo => "bar"

socket.on :connect do
  puts "connect!!!"
end

socket.on :disconnect do
  puts "disconnected!!"
end

socket.on :status do |data|
  puts "> " + data['time']
end

socket.on :error do |err|
  p err
end

puts "please input and press Enter key"
loop do
  cmd = STDIN.gets.strip
  next if cmd.empty?
  case cmd
  when 'l'
    socket.emit :brightness_update, 1
    puts "sent brightness_update 1"
  when 'o'
    socket.emit :brightness_update, 0
  end
end
