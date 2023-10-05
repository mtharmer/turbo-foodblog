# frozen_string_literal: true

class RandoJob
  include Sidekiq::Job

  def perform(id)
    Rails.logger.info "You gave me some args! Here's the id: #{id}"
    # Do something
  end
end
