# frozen_string_literal: true

require_relative 'trip_trails/version'

Dir["#{File.dirname(__FILE__)}/trip_trails/**/*.rb"].sort.each do |file|
  require file
end

module TripTrails
  class Error < StandardError; end
  # Your code goes here...
end
