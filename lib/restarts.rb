# restarts.rb - Implements a simple condition-restarts exception system,
#               just like Common Lisp
#
# Refer to README.txt for more info

module Restarts
  VERSION = '1.0.2'
end

module Kernel
  # Similar to the standard Kernel#raise command. Allows you to throw exceptions
  # The benefit is though that using raise_with_restarts adds the infrastructure
  # so that the rescue code can tell the exception to restart and recover from
  # a specific point.
  #
  # See README.txt for example
  def raise_with_restarts(condition)
    restart = callcc do |cc|
      # Have the continuation object accessible via the #restart method.
      # FIXME: check for pre defined methods by the name "restart".
      condition.instance_variable_set(:@cc, cc)
      condition.instance_eval do
        def restart(id=nil)
          if id.nil?
            return @cc
          else
            return @cc.call(id)
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
