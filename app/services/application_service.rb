# A service performs a single function.
# Use when the logic doesn't belong in a model, controller, or viewcomponent
class ApplicationService
  attr_reader :result
  attr_reader :fail_message

  def self.call(**args)
    new(**args).tap do |service|
      service.instance_variable_set(
        :@result,
        service.call
      )
    end
  end

  def call
    raise NotImplementedError
  end

  def success?
    !failure?
  end

  def failure?
    @failure || false
  end

  def fail!(message = "")
    @fail_message = message
    @failure = true
  end
end
