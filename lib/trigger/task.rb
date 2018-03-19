require "trigger/task/version"
require 'chronic'

module Trigger
  module Task
    module_function
    def parse commands, now: Time.now
      commands.lines.map do |command|
        next if command.empty?
        what, _,  _when = command.chomp.strip.split(/ (at|in) /)
        {what => Chronic.parse(_when, now: now) }
      end.compact.inject(&:merge!)
    end

    def load_reminders(context, commands, now: Time.now)
      slack_reminders_for(context, parse(commands, now: now))
    end

    def slack_reminders_for(context, tasks)
      tasks.map do |what, _when|
        "/remind me to #{what % context} on #{_when.strftime('%m/%d/%Y')}"
      end
    end

    def reminders_for(template, _binding, _when)
      commands = IO.read(template)
      Trigger::Task.load_reminders(_binding, commands, _when)
    end
  end
end
