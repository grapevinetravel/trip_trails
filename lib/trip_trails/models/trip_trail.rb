# frozen_string_literal: true

require 'active_record'

class TripTrail < ActiveRecord::Base
  scope :communication_sent, -> { where(status: STATUS[:success], status_explanation: 'Communication sent') }

  STATUS = {
    delayed: 'delayed',
    discarded: 'discarded',
    error: 'error',
    on_hold: 'on_hold',
    pending: 'pending',
    scheduled: 'scheduled',
    success: 'success',
    valid_but_excluded: 'valid_but_excluded',
    warn: 'warn'
  }.freeze

  has_many :trip_trail_events
end
