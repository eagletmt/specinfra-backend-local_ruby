module Specinfra
  module LocalRubyBackend
    module Commands
      module Service
        %i[
          check_service_is_running
          check_service_is_enabled
          disable_service
          enable_service
          reload_service
          restart_service
          start_service
          stop_service
        ].each do |meth|
          define_method(meth) do |*args|
            @factory.get(meth, *args)
          end
        end
      end
    end
  end
end
