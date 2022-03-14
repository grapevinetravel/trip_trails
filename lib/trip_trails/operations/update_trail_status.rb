# frozen_string_literal: true

require 'dry/transaction/operation'

class UpdateTrailStatus
  include Dry::Transaction::Operation

  def call(input, status, explanation = '')
    explanation = 'Internal server error' if status ==
                                             TripTrail::STATUS[:error] && explanation.empty?
    trip_trail = TripTrail.find(input.fetch(:trip_trail_id))
    trip_trail.update({ status: status, status_explanation: explanation })
  end
end
