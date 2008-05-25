module RSAML #:nodoc:
  module Statement #:nodoc:
    # Base class for statements.
    class Base
      # An xsi:type attribute used to indicate the actual statement type.
      attr_accessor :type
    end
  end
end