namespace :run do
  if Rails.env.development? || Rails.env.test?
    require "rubocop/rake_task"
    require "rspec/core/rake_task"

    desc "Run rubocop -DR"
    RuboCop::RakeTask.new(:rubocop) do |task|
      task.options       = ["-DR"] # Rails, display cop name
      task.fail_on_error = false   # don't abort rake on failure
    end

    desc "Run Rspec"
    RSpec::Core::RakeTask.new(spec: "spec:prepare")

    desc "Run all that matters"
    task all: %i(spec rubocop)
  end
end
