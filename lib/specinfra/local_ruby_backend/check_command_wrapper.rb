require 'specinfra/local_ruby_backend/command_wrapper'

module Specinfra
  module LocalRubyBackend
    class CheckCommandWrapper < CommandWrapper
      def call
        result = @block.call
        Specinfra::CommandResult.new(exit_status: result ? 0 : 1)
      end
    end
  end
end
