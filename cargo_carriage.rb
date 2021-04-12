class CargoCarriage
  attr_reader :type

  def initialize(number)
    @type = :cargo
    @number = number
  end
end
