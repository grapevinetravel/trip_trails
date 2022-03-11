# frozen_string_literal: true

require 'dry/transaction/operation'

class StoreInTrail
  include Dry::Transaction::Operation

  class StoreInTrailContract < Dry::Validation::Contract
    REQUIRED_VALUES = %i[client status].freeze

    schema { REQUIRED_VALUES.each { |val| required(val) } }
  end

  def call(input)
    contract_errors = StoreInTrailContract.new.call(input).errors
    return Failure(contract_errors) unless contract_errors.empty?

    input_block = input[:input] || input['input']
    process_block = input[:process] || input['process']
    output_block = input[:output] || input['output']

    input_block.deep_symbolize_keys! if input_block.is_a?(Hash)
    process_block.deep_symbolize_keys! if process_block.is_a?(Hash)
    output_block.deep_symbolize_keys! if output_block.is_a?(Hash)
    status = input.with_indifferent_access[:status]
    status_explanation = input.with_indifferent_access[:explanation]

    trip_trail =
      TripTrail.where(
        ext_id: input.with_indifferent_access[:active_trip_id],
        trip_batch_id: input.with_indifferent_access[:trips_batch_id],
        tmc: input.with_indifferent_access[:client]
      ).last

    if trip_trail.present?
      if input_block.present?
        trip_trail.update(input: trip_trail.input&.merge!(input_block))
      end
      if output_block.present?
        if trip_trail.output.present?
          trip_trail.update(output: trip_trail.output&.merge!(output_block))
        else
          trip_trail.output = output_block
          trip_trail.save
        end
      end
      if process_block.present?
        trip_trail.update(process: trip_trail.process&.merge!(process_block))
      end
      trip_trail.update(status: status) if status.present?
      if status_explanation.present?
        trip_trail.update(status_explanation: status_explanation)
      end
    else
      trip_trail =
        TripTrail.create(
          input: input_block,
          process: process_block,
          output: output_block,
          status: status,
          status_explanation: status_explanation,
          trip_batch_id: input.with_indifferent_access[:trips_batch_id],
          ext_id: input.with_indifferent_access[:active_trip_id],
          tmc: input.with_indifferent_access[:client]
        )
    end

    trip_trail
  end
end
