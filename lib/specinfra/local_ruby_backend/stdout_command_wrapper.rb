require 'specinfra/command_result'
require 'specinfra/local_ruby_backend/command_wrapper'

module Specinfra
  module LocalRubyBackend
    class StdoutCommandWrapper < CommandWrapper
      def call
        stdout = @block.call
        Specinfra::CommandResult.new(exit_status: 0, stdout: stdout)
      rescue => e
        Specinfra::CommandResult.new(exit_status: 1, stderr: e.message)
      end
    end
  end
end
