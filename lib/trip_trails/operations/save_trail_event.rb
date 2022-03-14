# frozen_string_literal: true

require 'dry/transaction/operation'

class SaveTrailEvent
  include Dry::Transaction::Operation

  def call(input)
    TripTrailEvent.create(
      trip_trail_id: input[:trip_trail_id],
      name: input[:coming_from],
      batch_id: input[:trips_batch_id],
      ext_id: input[:active_trip_id]
    )
  end
end
