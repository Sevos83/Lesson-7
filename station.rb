class Station

  include InstanceCounter

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.filter { |train| train.type == type }
  end
end
