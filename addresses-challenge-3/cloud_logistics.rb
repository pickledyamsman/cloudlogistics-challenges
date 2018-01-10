require_relative 'config/environment'

# This file is used to start the CLI from the command line.
class CloudLogistics
  def call
    run_cli
    show_bill
  end

  private

  def run_cli
    @route = Route.new
    stop_number = ask_stop_number
    puts 'Carrier name:'
    @route.carrier = gets.chomp
    ask_stops(stop_number - 2, @route)
    @route.save
  end

  #######################
  # Input methods
  #######################

  def ask_stop_number
    puts 'Number of stops:'
    puts 'Stops must be 0 or higher.' while (stop_number = gets.chomp.to_i) < 2
    stop_number
  end

  def ask_stops(stop_number, route)
    puts 'Origin:'
    route.stops << split_address(gets.chomp, 'Origin')
    stop_number.times do |stop|
      puts "#{(stop + 1).ordinalize} stop:"
      route.stops << split_address(gets.chomp, "#{(stop + 1).ordinalize} stop")
    end
    puts 'Destination:'
    puts 'Format (street address, city, state, zipcode, country)'
    route.stops << split_address(gets.chomp, 'Destination')
  end

  def split_address(full_address, stop_type)
    address, city, the_rest = full_address.split(', ', 3)
    state, zipcode, country = the_rest.split(' ', 3)

    Stop.create(address: address,
                city: city,
                state: state,
                zipcode: zipcode,
                country: country,
                stop_type: stop_type)
  end

  #######################
  # Output methods
  #######################

  def show_bill
    puts "Bill of lading number #{@route.id}, "\
         "being carried by #{@route.carrier}"

    show_stops
  end

  def show_stops
    @route.stops.each do |stop|
      stop_formatter(stop)
    end
  end

  def stop_formatter(stop)
    puts " - #{stop.stop_type}: #{stop.address}, "\
     "#{stop.city}, #{stop.state} #{stop.zipcode}, "\
     "#{stop.country} #{stop.latitude}, #{stop.longitude}"
  end
end

CloudLogistics.new.call
