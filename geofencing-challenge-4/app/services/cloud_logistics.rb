# This file is used to start the CLI from the command line.
class CloudLogistics
  DISTANCE = 10

  def call
    @route = Route.new
    stop_number = ask_stop_number
    puts 'Carrier name:'
    @route.carrier = gets.chomp
    ask_stops(stop_number - 2, @route)
    @route.save

    @route.stops.each do |stop|
      check_current_distance(stop)
    end
  end

  private

  #######################
  # Input methods
  #######################

  def ask_stop_number
    puts 'Number of stops:'
    puts 'Stops must be 2 or higher.' while (stop_number = gets.chomp.to_i) < 2
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

  def ask_current
    puts 'Current location:'
    split_address(gets.chomp, 'current')
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

  def show_visited_stop(current)
    show_bill
    puts "Location, #{current.address}, #{current.city}, #{current.state}"\
         " #{current.zipcode} is within #{DISTANCE} miles, marking the "\
         "destination as visited!"
  end

  #######################
  # Output formatter methods
  #######################

  def stop_formatter(stop)
    puts " - #{visited_formatter(stop)}#{stop.stop_type}: #{stop.address}, "\
         "#{stop.city}, #{stop.state} #{stop.zipcode}, "\
         "#{country_formatter(stop)}#{stop.latitude}, #{stop.longitude}"
  end

  def country_formatter(stop)
    "#{stop.country} " if stop.country.present?
  end

  def visited_formatter(stop)
    '* ' if stop.visited == true
  end

  #######################
  # geolocation methods
  #######################

  def find_distance(destination, current)
    destination.distance_from(current)
  end

  def check_current_distance(stop)
    while stop.visited == false
      current = ask_current

      if find_distance(stop, current) < DISTANCE
        stop.update_attribute(:visited, true)
        show_visited_stop(current)
      end
    end
  end
end
