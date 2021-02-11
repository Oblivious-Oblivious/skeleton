Signal::INT.trap {
    Skeleton::SERVER_LIST.each { |s| s.close; };
    puts "Server exiting...";
    exit;
};

Signal::TERM.trap {
    Skeleton::SERVER_LIST.each { |s| s.close; };
    puts "Killing server...";
    exit;
};
