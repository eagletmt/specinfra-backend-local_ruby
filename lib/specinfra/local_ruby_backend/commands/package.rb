module Specinfra
  module LocalRubyBackend
    module Commands
      module Package
        %i[
          check_package_is_installed
          get_package_version
          install_package
          remove_package
        ].each do |meth|
          define_method(meth) do |*args|
            @factory.get(meth, *args)
          end
        end
      end
    end
  end
end
