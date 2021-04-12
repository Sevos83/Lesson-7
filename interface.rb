class Interface
  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def start
    loop do
    puts "Действие:\n
    1. Создать cтанцию\n
    2. Создать поезд\n
    3. Создавать маршруты и управлять станциями в нем (добавлять, удалять)\n
    4. Назначать маршрут поезду\n
    5. Добавлять вагоны к поезду\n
    6. Отцеплять вагоны от поезда\n
    7. Перемещать поезд по маршруту вперед и назад\n
    8. Просматривать список станций и список поездов на станции\n
    0. Выйти"

    input = gets.to_i
    case input
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      direct_route
    when 5
      add_carriages
    when 6
      delete_carriages
    when 7
      move_train
    when 8
      list_stations_trains
    when 0
    break
    end
  end

  private

  def create_staiton
    puts 'Введите название станции: '
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def create_train
    puts 'Введите номер поезда: '
    number = gets.chomp
    puts "Выберите тип создаваемого поезда:
    1. Пассажирский,
    2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
    @trains = Train.new(number, :passenger)
    elsif type == 2
    @trains = Train.new(number, :cargo)
    else
    puts "Введено неправильное значение! Начните сначала"
    break
    end
  end

  def create_route
    puts 'Выберите начальную станцию: '
    @stations.each_with_index { |index, station| puts "#{index + 1}. #{station.name}" }
    first_station = @stations[gets.to_i - 1]
    puts 'Выберите конечную станцию: '
    @stations.each_with_index { |index, station| puts "#{index + 1}. #{station.name}" }
    last_station = @stations[gets.to_i - 1]
    @routes << Route.new(first_station, last_station)
  end

  def add_station_to_route
    route = select_route
    puts 'Какую станцию добавить в маршрут: '
    route.add_station(gets.chomp)
  end

  def remove_station
    route = select_route
    puts 'Какую станцию удалить из маршрута: '
    route.del_station(gets.chomp)
  end

  def select_route
    puts "Выберите маршрут из списка:"
    routes.each_index { |r| puts "#{r} - #{routes[r].route.to_s}" }
    index_route = gets.chomp.to_i
    routes[index_route]
  end

  def direct_route
    puts "Выберите действие с маршрутом:
    1 - Создать новый маршрут
    2 - Добавить станцию в маршрут
    3 - Удалить станцию из маршрута
    0 - Выйти"

    input = gets.chomp.to_i
    case input
    when 1
      create_route
    when 2
      add_station_to_route
    when 3
      remove_station
    when 0
    break
    end
  end

  def add_carriages
    train = select_train
    puts "Выберите тип вагона:
    1. Пассажирский,
    2. Грузовой"
    type = gets.chomp.to_i
    puts 'Укажите номер вагона: '
    number = gets.chomp
    if type == 1
      carriages = PassengerCarriage.new(number)
    elsif type == 2
      carriages = CargoCarriage.new(number)
    else
      puts 'Ошибка!!!'
    end
    train.add(carriages)
  end

  def delete_carriages
    train = select_train
    carriages = select_carriage(train)
    train.delete(carriages)
  end

  def select_train
    puts "Выберите поезд из списка:"
    trains.each_index { |t| puts "#{t} - #{trains[t].num_tr} - #{trains[t].type}" }
    index_train = gets.chomp.to_i
    trains[index_train]
  end

  def select_carriage(train)
  puts "Выберите вагон из состава:"
  train.carriages.each_index { |i| puts "#{i} - #{train.carriages[i]}" }
  index_carriage = gets.chomp.to_i
  train.carriages[index_carriage]
  end

  def move_train
    train = select_train
    if train.current_route == nil
      puts "Поезду не назначен маршрут. Сначала назначьте"
    else
    puts "Выберите направление движения поезда:
    1. Вперед,
    2. Назад"
    choise = gets.chomp.to_i
    if choise == 1
      train.move_next_station
    elsif choise == 2
      train.move_previous_station
    else
      puts "Ошибка!!!"
    end
      puts "Текущая станция #{train.current_station}"
    end
  end

  def list_stations_trains
    puts "Список станций: "
    stations.each { |s| puts s.title }
    puts "Список поездов: "
    trains.each { |t| puts "Номер поезда: #{t.num_tr} Тип: #{t.type}" }
  end
end
