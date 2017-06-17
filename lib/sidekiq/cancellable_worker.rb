module Sidekiq
  module CancellableWorker
    VERSION = '1.0.0'

    class WorkerContext
      def initialize(jid)
        @jid = jid
      end

      def cancelled?
        ::Sidekiq.redis { |c| c.exists("cancelled-#{@jid}") }
      end
    end

    def self.prepended(base)
      base.extend(ClassMethods)
    end

    def perform(*)
      @context = WorkerContext.new(jid)
      super
    end

    module ClassMethods
      def cancel!(jid)
        ::Sidekiq.redis { |c| c.setex("cancelled-#{jid}", 86_400, 1) }
      end
    end
  end
end