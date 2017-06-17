require "spec_helper"

class TestWorker
  include Sidekiq::Worker
  prepend Sidekiq::CancellableWorker

  def perform
    raise "cancelled" if @context.cancelled?
    finish_work
  end

  def finish_work
  end
end

RSpec.describe Sidekiq::CancellableWorker do
  before :all do
    Sidekiq::Testing.fake!
  end

  it 'should run worker' do
    TestWorker.perform_async
    expect_any_instance_of(TestWorker).to receive(:finish_work)
    TestWorker.drain
  end

  it 'should cancel worker' do
    TestWorker.perform_async
    jid = TestWorker.jobs.first["jid"]
    TestWorker.cancel!(jid)

    expect {
      TestWorker.drain
    }.to raise_error("cancelled")
  end
end