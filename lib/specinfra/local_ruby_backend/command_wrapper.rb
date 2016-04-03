module Specinfra
  module LocalRubyBackend
    class CommandWrapper
      def initialize(&block)
        @block = block
      end

      def to_s
        "[#{self.class}]#{@block}"
      end
    end
  end
end
