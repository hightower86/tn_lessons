require_relative 'modules'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'vagon'
require_relative 'passenger_vagon'
require_relative 'cargo_vagon'

class Main
  attr_reader :routes, :trains, :stations

  def initialize
    @routes = []
    @trains = []
    @stations = []
    fill_data
  end

  def fill_stations_and_routes
    st1 = Station.new 'Москва'
    st2 = Station.new 'Ленинград'
    st3 = Station.new 'Сургут'
    st4 = Station.new 'Тюмень'
    stations << st1 << st2 << st3 << st4
    r1 = Route.new(st1, st2)
    r2 = Route.new(st3, st4)
    routes << r1 << r2
  end

  def fill_trains
    tr1 = Train.new('123-32', :passenger)
    tr2 = Train.new('1А3-55', :passenger)
    tr3 = Train.new('335-68', :cargo)
    trains << tr1 << tr2 << tr3
    tr1.hook(PassengerVagon.new('111', 200))
    tr1.hook(PassengerVagon.new('112', 200))
    tr1.hook(PassengerVagon.new('113', 250))
  end

  def fill_data
    fill_stations_and_routes
    fill_trains
    trains[0].take_route(routes[0])
    trains[1].take_route(routes[1])
  end

  def create_station
    puts 'Ведите название станции'
    name = gets.chomp
    my_station = Station.new(name)
    stations << my_station
  end

  def enter_number
    number_format = /\A[А-Яа-я0-9]{3}-*[А-Яа-я0-9]{2}\z/
    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      raise  if number !~ number_format
    rescue
      puts 'Номер поезда не соответствует формату! Попробуйте еще раз'
      retry
    end
    number
  end

  def enter_type
    puts "Выберите тип создаваемого поезда:
    1. Пассажирский,
    2. Грузовой"
    type = gets.chomp.to_i
    raise if type < 1 && type > 2
  rescue
    puts 'Введено неправильное значение! введите 1 или 2 '
    retry
  end

  def new_train(number, type)
    if type == 1
      Train.new(number, :passenger)
    elsif type == 2
      Train.new(number, :cargo)
    end
  end

  def create_train
    number = enter_number
    type = enter_type
    my_train = new_train(number, type)

    unless my_train.nil?
      puts "Поезд номер #{my_train.num_tr},
      тип #{my_train.type} создан успешно!"
    end
    trains << my_train
  end

  def create_new_route
    puts 'Создаем новый маршрут. Введите название первой станции маршрута:'
    first_station = gets.chomp
    puts 'Введите название последней станции маршрута:'
    last_station = gets.chomp
    my_route = Route.new(first_station, last_station)
    puts "Маршрут #{my_route} создан успешно"
    routes << my_route
  end

  def add_station_to_route
    my_route = select_route
    puts 'Введите название добавляемой станции в маршрут: '
    my_route.add_station(gets.chomp)
    p my_route
  end

  def remove_station
    my_route = select_route
    puts 'Какую станцию из маршрута хотите удалить? (введите название): '
    my_route.del_station(gets.chomp)
    p my_route
  end

  def edit_route
    puts "Выберите действие с маршрутом:
    1 - Создать новый маршрут
    2 - добавить станцию в маршрут
    3 - удалить станцию из маршрута
    0 - выйти в главное меню"
    choise = gets.chomp.to_i
    actions = { 1 => 'create_new_route', 2 => 'add_station_to_route',
                3 => 'remove_station', 0 => 'Exit' }
    send(actions[choise]) || send(Exit)
  end

  def train_select
    if trains.empty?
      puts 'список поездов пуст, создайте сперва поезда'
      create_train
    else
      select_train
    end
  end

  def direct_route
    my_train = train_select
    if routes.empty?
      puts 'список маршрутов пуст, создайте сперва маршруты'
      my_route = create_new_route
    else
      my_route = select_route
    end
    my_train.take_route(my_route)
  end

  def create_vagon(type, number)
    if type == 1
      puts 'Введите количество мест в вагоне: '
      total_of_places = gets.chomp
      PassengerVagon.new(number, total_of_places)
    elsif type == 2
      puts 'Введите объём вагона: '
      total_volume = gets.chomp
      CargoVagon.new(number, total_volume)
    end
  end

  def hook_vagon
    my_train = select_train
    type = enter_type
    puts 'Укажите номер вагона: '
    number = gets.chomp
    my_vagon = create_vagon(type, number)
    my_train.hook(my_vagon)
    p my_train.vagons
  end

  def unhook_vagon
    my_train = select_train
    my_vagon = select_vagon(my_train)
    my_train.unhook(my_vagon)
    p my_train.vagons
  end

  def move(my_train)
    puts "Выберите направление движения поезда:
    1. Вперед, 2. Назад"
    choise = gets.chomp.to_i
    if choise == 1
      my_train.move_forward
    elsif choise == 2
      my_train.move_back
    else
      puts 'Ошибка!!!'
    end
  end

  def move_train
    my_train = select_train
    if my_train.current_route.nil?
      puts 'Поезду не назначен маршрут. Сначала назначьте'
    else
      move(my_train)
      puts "Текущая станция #{my_train.current_station}"
    end
  end

  def list_stations
    puts 'Список станций: '
    stations.each { |s| puts s.title }
  end

  def list_trains
    my_station = select_station
    puts 'Список поездов на станции: '
    my_station.list_of_trains do |train|
      puts "Номер: #{train.num_tr},
  тип: #{train.type}, кол. вагонов: #{train.vagons.size}"
    end
  end

  def info_vagons(v)
    str = "Номер: #{v.number}, тип: #{v.type}"
    if v.type == :passenger
      puts str + ", занято: #{v.taken_seats}, свободно #{v.free_seats}"
    else
      puts str + ", занято: #{v.filled_volume}, свободно #{v.free_volume}"
    end
  end

  def list_vagons
    my_train = select_train
    puts 'Список вагонов поезда: '
    my_train.list_of_vagons do |v|
      info_vagons(v)
    end
  end

  def fill_vagon
    my_vagon = select_vagon(select_train)
    if my_vagon.class == PassengerVagon
      puts 'Сколько мест будет занято?:'
      gets.chomp.to_i.times { my_vagon.take_seat }
    elsif my_vagon.class == CargoVagon
      puts 'Какой объем будет занят?: '
      my_vagon.fill_volume(gets.chomp.to_i)
    end
  end

  protected

  attr_writer :routes, :trains, :stations

  def select_route
    puts 'Выберите маршрут из списка:'
    routes.each_index { |r| puts "#{r} - #{routes[r].title}" }
    index_route = gets.chomp.to_i
    routes[index_route]
  end

  def select_train
    puts 'Выберите поезд из списка:'
    trains.each_index do |t|
      puts "#{t} -
      #{trains[t].num_tr} - #{trains[t].type}"
    end
    # index_train = gets.chomp.to_i
    trains[gets.chomp.to_i]
  end

  def select_vagon(train)
    puts 'Выберите вагон из состава:'
    train.vagons.each_index { |i| puts "#{i} - #{train.vagons[i]}" }
    index_vagon = gets.chomp.to_i
    train.vagons[index_vagon]
  end

  def select_station
    puts 'Выберите cтанцию из списка:'
    stations.each_index { |s| puts "#{s} - #{stations[s].title}" }
    index_station = gets.chomp.to_i
    stations[index_station]
  end
end

main = Main.new
loop do
  puts " Выберите действие:
  1. Создать станцию
  2. Создать поезд
  3. Создать маршрут или управлять станциями в нем (добавлять, удалять)
  4. Назначить маршрут поезду
  5. Добавить вагоны к поезду
  6. Отцепить вагоны от поезда
  7. Переместить поезд по маршруту вперед и назад
  8. Вывести список станций
  9. Вывести список поездов на станции
  10. Вывести список вагонов поезда
  11. Занять место в вагоне
  0. ВЫХОД ИЗ ПРОГРАММЫ"

  choise = gets.chomp.to_i
  choises = { 1 => 'create_station', 2 => 'create_train', 3 => 'edit_route',
              4 => 'direct_route', 5 => 'hook_vagon', 6 => 'unhook_vagon',
              7 => 'move_train', 8 => 'list_stations', 9 => 'list_trains',
              10 => 'list_vagons', 11 => 'fill_vagon' }

  break if choise.zero?
  main.send(choises[choise])
end
