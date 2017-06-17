# Sidekiq::CancellableWorker

This gem allows Sidekiq workers to cancel themselves at runtime. Using long-running Sidekiq jobs that perform some kind of long computation (which is also better to avoid), you might want to be able to cancel these jobs in a clean and controlled way.

The gem implements the solution described in the official Sidekiq wiki: https://github.com/mperham/sidekiq/wiki/FAQ#how-do-i-cancel-a-sidekiq-job

## Usage

```ruby
class MyWorker
  include Sidekiq::Worker
  prepend Sidekiq::CancellableWorker

  def perform(args = {})
    # perform some long running work
    100.times do |i|
      sleep i
      return if @context.cancelled?
    end
  end
end
```

Then, while it is running, the job can be cancelled this way (for example in the Rails console):

```ruby
MyWorker.cancel!(jid)
```

Prepending the module `Sidekiq::Cancellable` worker injects the `@context` variable into the worker at runtime. The worker can then call `@context.cancelled?` (or pass it through the chain of execution) to be able to stop the execution depending on the result.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-cancellable-worker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-cancellable-worker

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OnceApp/sidekiq-cancellable-worker.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

