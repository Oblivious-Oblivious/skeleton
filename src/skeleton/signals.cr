Signal::INT.trap { puts "Server exiting..."; exit; };
Signal::TERM.trap { puts "Killing server..."; exit; };
