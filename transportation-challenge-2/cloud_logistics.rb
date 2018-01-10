require_relative 'config/environment'

# This file is used to start the CLI from the command line.
class CloudLogistics
  def call
    run_cli
    show_output
  end

  private

  def run_cli
    @route = Route.new
    @stops = ask_stop_number
    @route.carrier = ask_question('Carrier name:')
    @route.origin = ask_question('Origin:')
    ask_stops(@stops - 2, @route)
    @route.destination = ask_question('Destination:')
    @route.save
  end

  def ask_stop_number
    puts 'Number of stops:'
    puts 'Stops must be 0 or higher.' while (stop_number = gets.chomp.to_i) < 2
    stop_number
  end

  def ask_question(question)
    puts question
    gets.chomp
  end

  def ask_stops(stops, route)
    stops.times do |stop|
      puts "#{(stop + 1).ordinalize} stop:"
      route.stops.new(address: gets.chomp)
    end
  end

  def show_output
    puts "Bill of lading number #{@route.id}, being carried by #{@route.carrier}"
    puts " - Origin: #{@route.origin}"
    show_stops
    puts " - Destination: #{@route.destination}"
  end

  def show_stops
    @route.stops.each_with_index do |stop, index|
      puts " - #{(index + 1).ordinalize} stop: #{stop.address}"
    end
  end
end

CloudLogistics.new.call
