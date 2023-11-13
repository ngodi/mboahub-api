class ApplicationService
  def initialize(params:)
    @params = params
  end

  def self.call(params:)
    new(params)
  end
end
