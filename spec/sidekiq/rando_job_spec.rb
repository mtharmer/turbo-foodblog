# frozen_string_literal: true

require 'rails_helper'
RSpec.describe RandoJob, type: :job do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'enqueues a new job' do
    expect { described_class.perform_async(1) }.to enqueue_sidekiq_job(described_class).with(1)
  end

  it 'schedules a job in a set amount of time' do
    expect { described_class.perform_in(5.minutes, 1) }.to enqueue_sidekiq_job(described_class).with(1).in(5.minutes)
  end

  it 'schedules a job for a future time' do
    time = 5.minutes.from_now
    expect { described_class.perform_at(time, 1) }.to enqueue_sidekiq_job(described_class).with(1).at(time)
  end

  it 'drains successfully on command' do
    expect { described_class.perform_async(1) }.to enqueue_sidekiq_job(described_class).with(1)
    described_class.drain
    expect(described_class).not_to have_enqueued_sidekiq_job
  end
end
