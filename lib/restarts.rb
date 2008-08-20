# restarts.rb - Implements a simple condition-restarts exception system,
#               just like Common Lisp
#
# Refer to README.txt for more info

module Restarts
  VERSION = '1.0.1'
end

module Kernel
  # FIXME: Find a way to have it part of Restarts module, but mixed-into Kernel
  # Don't even know if thats a better way to do it.
  def raise_with_restarts(condition)
    restart = callcc do |cc|
      # Have the continuation object accessible via the #restart method.
      # FIXME: check for pre defined methods by the name "restart".
      (class <<condition; self; end).class_eval do
        define_method(:restart) do |*id|
          if id.empty?
            return cc
          else
            return cc.call(id[0])
          end
        end
      end

      raise condition
    end

    # This allows raise_condition to be used in the same way as regular raise
    # Just don't give an exception.
    #
    # IDEA: maybe alias this to default Kernal#raise, would be nice.
    yield restart if block_given?
  end
end
