# frozen_string_literal: true

require_relative 'trip_trails/version'

require 'trip_trails/trip_trail_event'
require 'trip_trails/trip_trail'

require 'trip_trails/generate_trail'
require 'trip_trails/save_trail_event'
require 'trip_trails/store_in_trail'
require 'trip_trails/update_trail_status'

module TripTrails
  class Error < StandardError; end
  # Your code goes here...
end
