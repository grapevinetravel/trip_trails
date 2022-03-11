# frozen_string_literal: true

require 'dry/transaction/operation'

class GenerateTrail
  include Dry::Transaction::Operation

  def call(input)
    trips_batch_id = input.fetch(:trips_batch_id)
    client =
      input.try(:[], :client) || input.try(:[], :context_tmc).try(:name)

    # TODO: work out why input[:active_trip_json] can be 'null' and cast it to nil
    active_trip_id =
      if input[:active_trip_json].present? &&
         input[:active_trip_json] != 'null'
        json = JSON.parse(input.fetch(:active_trip_json))
        json['trip_details']['trip_id'] if json.key?('trip_details')
        json['TripId'] if json.key?('TripId')
      else
        input.fetch(:active_trip_id)
      end
    if input.keys.exclude?(:active_trip_id)
      input.merge!({ active_trip_id: active_trip_id })
    end

    trip_trail =
      TripTrail.find_by(trip_batch_id: trips_batch_id, ext_id: active_trip_id)
    if trip_trail.present?
      trip_trail.input = {}
      trip_trail.output = {}
      trip_trail.process = {}
    else
      trip_trail =
        TripTrail.new(
          ext_id: active_trip_id,
          trip_batch_id: trips_batch_id,
          input: {},
          process: {},
          output: {}
        )
    end
    trip_trail.tmc = client
    trip_trail.save

    Success(input.merge!({ trip_trail_id: trip_trail.id }))
  end
end
