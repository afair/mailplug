# The plugin stack
class Mailplug::Stack
  attr_accessor :stack, :env

  def initialize(env)
    self.env   = env
    self.stack = []
  end

  def setup(&block)
    instance_eval(&block)
  end

  def add(plugin_class)
    self.stack << plugin_class.new(self.env)
  end

  # Returns true to keep processing, false to send message and halt
  def run(method, *objects)
    stack.each do |plugin|
      env.code, env.error_message = plugin.call(method, *objects)
      if env.code == :skip
        next
      elsif env.code == :message_accepted
        return false
      else # Halting error
        return false
      end
    end
    true
  end
end
