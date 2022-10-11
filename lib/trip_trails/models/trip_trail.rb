# frozen_string_literal: true

require 'active_record'

class TripTrail < ActiveRecord::Base
  scope :communication_sent, lambda {
                               where(
                                 status: STATUS[:success],
                                 status_explanation: STATUS_EXPLANATION[:comm_sent]
                               )
                             }

  STATUS_EXPLANATION = {
    comm_sent: 'Communication sent'
  }.freeze
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

  def internal_id
    self.process.with_indifferent_access[:internal_id]
  rescue StandardError
    ''
  end
end
