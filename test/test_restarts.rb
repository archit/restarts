# -*- ruby -*-
require 'restarts'

class RestartsTest < Test::Unit::TestCase

  class ExampleError < RuntimeError
    def initialize(a_message)
      @message = a_message
    end
  end
  
  class Example
    attr_reader :restart1_used, :restart2_used
    
    def initialize()
      @restart1_used = false
      @restart2_used = false
    end
    
    def i_will_raise_a_condition
      raise_with_restarts(ExampleError.new("I'm really just a condition")) do |restart_at|
        case restart_at
        when :restart1 then @restart1_used = true
        when :restart2 then @restart2_used = true
        end 
      end
    end
  end
  
  def setup
    @ex = Example.new
  end
  
  def test_calls_raise
    assert_raises(ExampleError) { @ex.i_will_raise_a_condition }
  end
  
  def test_restart1
    begin
      @ex.i_will_raise_a_condition
    rescue ExampleError
      $!.restart.call(:restart1)
    end
    
    assert @ex.restart1_used
    assert !@ex.restart2_used
  end
  
  def test_restart2
    begin
      @ex.i_will_raise_a_condition
    rescue ExampleError
      $!.restart.call(:restart2)
    end
    
    assert !@ex.restart1_used
    assert @ex.restart2_used
  end
  
  def test_alternative_syntax
    begin
      @ex.i_will_raise_a_condition
    rescue ExampleError
      $!.restart(:restart1)
    end
    
    assert @ex.restart1_used
  end
end

# vim: syntax=Ruby
