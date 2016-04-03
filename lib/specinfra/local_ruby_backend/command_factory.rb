require 'specinfra/local_ruby_backend/command_method'

module Specinfra
  module LocalRubyBackend
    class CommandFactory
      def initialize
        @method = CommandMethod.new
      end

      def get(*args)
        @method.public_send(*args)
      end
    end
  end
end
