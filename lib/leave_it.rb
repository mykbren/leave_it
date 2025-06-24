# frozen_string_literal: true

require_relative 'leave_it/version'
require_relative 'leave_it/cli'

module LeaveIt
  def self.run(path = '.')
    CLI.run(path)
  end
end
