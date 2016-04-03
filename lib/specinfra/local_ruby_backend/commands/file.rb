require 'etc'
require 'fileutils'
require 'specinfra/local_ruby_backend/check_command_wrapper'
require 'specinfra/local_ruby_backend/silent_command_wrapper'
require 'specinfra/local_ruby_backend/stdout_command_wrapper'

module Specinfra
  module LocalRubyBackend
    module Commands
      module File
        def check_file_is_file(path)
          CheckCommandWrapper.new { FileTest.file?(path) }
        end

        def change_file_mode(path, mode, recursive: false)
          SilentCommandWrapper.new do
            if recursive
              FileUtils.chmod_R(mode.to_i(8), path)
            else
              FileUtils.chmod(mode.to_i(8), path)
            end
          end
        end

        def create_file_as_directory(path)
          SilentCommandWrapper.new do
            FileUtils.mkdir_p(path)
          end
        end

        def remove_file(path)
          SilentCommandWrapper.new do
            FileUtils.rm_rf(path)
          end
        end

        def change_file_owner(path, owner, group = nil, recursive: false)
          SilentCommandWrapper.new do
            if recursive
              FileUtils.chown_R(owner, group, path)
            else
              FileUtils.chown(owner, group, path)
            end
          end
        end

        def move_file(source, destination)
          SilentCommandWrapper.new do
            FileUtils.mv(source, destination)
          end
        end

        def get_file_mode(path)
          StdoutCommandWrapper.new do
            (::File.stat(path).mode & 0o7777).to_s(8)
          end
        end

        def get_file_owner_user(path)
          StdoutCommandWrapper.new do
            Utils.get_name_from_uid(::File.stat(path).uid)
          end
        end

        def get_file_owner_group(path)
          StdoutCommandWrapper.new do
            Utils.get_group_from_gid(::File.stat(path).gid)
          end
        end

        def check_file_is_directory(path)
          CheckCommandWrapper.new do
            FileTest.directory?(path)
          end
        end

        def check_file_is_link(path)
          CheckCommandWrapper.new do
            FileTest.symlink?(path)
          end
        end

        def check_file_is_linked_to(path, target)
          CheckCommandWrapper.new do
            begin
              ::File.readlink(path) == target
            rescue SystemCallError
              false
            end
          end
        end

        def link_file_to(path, target, force: false)
          SilentCommandWrapper.new do
            if force
              FileUtils.ln_sf(target, path)
            else
              FileUtils.ln_s(target, path)
            end
          end
        end

        def get_file_link_target(path)
          StdoutCommandWrapper.new do
            ::File.readlink(path)
          end
        end

        module Utils
          module_function

          def get_name_from_uid(uid)
            Etc.passwd do |pw|
              if pw.uid == uid
                return pw.name
              end
            end
            nil
          end

          def get_group_from_gid(gid)
            Etc.group do |gr|
              if gr.gid == gid
                return gr.name
              end
            end
            nil
          end
        end
      end
    end
  end
end
