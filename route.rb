class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def delete_station(station)
    if (station != @stations.first) && (station != @stations.last)
    @stations.delete(station)
    end
  end

  def add_station(station)
    @stations.insert(-2, station)
  end
end
