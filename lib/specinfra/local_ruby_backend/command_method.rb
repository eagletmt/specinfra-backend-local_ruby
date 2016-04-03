require 'specinfra/backend'
require 'specinfra/local_ruby_backend/commands/file'
require 'specinfra/local_ruby_backend/commands/package'
require 'specinfra/local_ruby_backend/commands/service'

module Specinfra
  module LocalRubyBackend
    class CommandMethod
      def initialize
        @factory = Specinfra::Backend::Exec.new.command
      end

      include Commands::File
      include Commands::Package
      include Commands::Service
    end
  end
end
