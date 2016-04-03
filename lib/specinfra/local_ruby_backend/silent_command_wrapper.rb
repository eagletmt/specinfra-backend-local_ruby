require 'specinfra/command_result'
require 'specinfra/local_ruby_backend/command_wrapper'

module Specinfra
  module LocalRubyBackend
    class SilentCommandWrapper < CommandWrapper
      def call
        @block.call
        Specinfra::CommandResult.new
      rescue => e
        Specinfra::CommandResult.new(exit_status: 1, stderr: e.message)
      end
    end
  end
end
