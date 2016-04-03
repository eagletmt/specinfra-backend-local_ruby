require 'open3'
require 'specinfra/command_result'
require 'specinfra/local_ruby_backend/command_factory'
require 'specinfra/local_ruby_backend/command_wrapper'

module Specinfra
  module Backend
    class LocalRuby
      attr_reader :command
      attr_writer :stdout_handler, :stderr_handler

      def initialize
        @command = LocalRubyBackend::CommandFactory.new
      end

      def run_command(command)
        if command.is_a?(LocalRubyBackend::CommandWrapper)
          command.call
        else
          stdout, stderr, status = with_clean_env { Open3.capture3(command) }
          Specinfra::CommandResult.new(
            exit_status: status.exitstatus,
            stdout: stdout,
            stderr: stderr,
          )
        end.tap do |result|
          if @stdout_handler && !result.stdout.empty?
            @stdout_handler.call(result.stdout)
          end
          if @stderr_handler && !result.stderr.empty?
            @stderr_handler.call(result.stderr)
          end
        end
      end

      def send_file(source, destination)
        FileUtils.cp(source, destination)
      end

      private

      def with_clean_env(&block)
        if defined?(Bundler)
          Bundler.with_clean_env(&block)
        else
          block.call
        end
      end
    end
  end
end
