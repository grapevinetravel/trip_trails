# frozen_string_literal: true

class TripTrailEvent < ActiveRecord::Base
  EVENTS = {
    born: 'Trip born',
    born_scheduled: 'Trip born scheduled',
    processing_scheduled: 'Trip processed by scheduler',
    processing_delayed: 'Delayed Trip processed',
    retry_due_to_status: 'Trip added to retry queue due to status',
    retry_on_hold: 'Trip added to on_hold queue due to status',
    retry_due_to_dated_trigger: 'Trip processed using DatedTrips',
    retry_due_to_batch_reprocess: 'Trip re-processed using BatchReprocess',
    test_trip_tool: 'Trip processed using Tester for Trips'
  }.freeze

  belongs_to :trip_trail
end
