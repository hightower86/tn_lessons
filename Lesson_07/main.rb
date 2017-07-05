require_relative "modules"
require_relative "train"
require_relative "station"
require_relative "route"
require_relative "vagon"
require_relative "passenger_vagon"
require_relative "cargo_vagon"


class Main
  attr_reader :routes, :trains, :stations
  
  def initialize
    @routes = []
    @trains = []
    @stations = []
    fill_data
  end

  def fill_data
    tr1 = Train.new("123-32", :passenger)
    tr2 = Train.new("1А3-55", :passenger)
    tr3 = Train.new("1А4-99", :passenger)
    tr4 = Train.new("254-87", :cargo)
    tr5 = Train.new("335-68", :cargo)
    trains << tr1 << tr2 << tr3

    st1 = Station.new("Москва")
    st2 = Station.new "Ленинград"
    st3 = Station.new "Сургут"
    st4 = Station.new "Тюмень"
    st5 = Station.new "Вологда"
    stations << st1 << st2 << st3 << st4 << st5
    
    r1 = Route.new(st1, st2)
    r2 = Route.new(st3, st4)
    r3 = Route.new(st2, st5)
    routes << r1  << r2 << r3

    tr1.take_route(r1)
    tr2.take_route(r1)

    tr1.hook(PassengerVagon.new("111", 200))
    tr1.hook(PassengerVagon.new("112", 200))
    tr1.hook(PassengerVagon.new("113", 250))
  end

  def create_station
    puts "Ведите название станции"
    name = gets.chomp
    my_station = Station.new(name)
    self.stations << my_station
  end

  def create_train
    number_format = /\A[А-Яа-я0-9]{3}-*[А-Яа-я0-9]{2}\z/
    begin
      puts "Введите номер поезда"
      number = gets.chomp
      raise  if number !~ number_format
    rescue 
      puts "Номер поезда не соответствует формату! Попробуйте еще раз"
      retry
    end
    puts "ввели номер #{number}"
    begin
      puts "Выберите тип создаваемого поезда: 
      1. Пассажирский, 
      2. Грузовой"
      type = gets.chomp.to_i
      raise if type < 1 && type > 2 
    rescue
      puts "Введено неправильное значение! введите 1 или 2 "
      retry
    end

    if type == 1
      my_train = Train.new(number, :passenger)
    elsif type == 2
      my_train = Train.new(number, :cargo) 
    end

    puts "Поезд номер #{my_train.num_tr}, тип #{my_train.type} создан успешно!" if my_train != nil

    self.trains << my_train
    # p my_train
    # p trains
  end

  def create_new_route
    puts "Создаем новый маршрут. Введите название первой станции маршрута:"
    first_station = gets.chomp
    puts "Введите название последней станции маршрута:"
    last_station = gets.chomp
    my_route = Route.new(first_station, last_station)
    puts "Маршрут #{my_route} создан успешно"
    self.routes << my_route
  end

  def add_station_to_route
    my_route = select_route
    puts "Введите название добавляемой станции в маршрут: "
    my_route.add_station(gets.chomp)
    p my_route
  end

  def remove_station
    my_route = select_route
    puts "Какую станцию из маршрута хотите удалить? (введите название): "
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
    case choise
    when 1
      create_new_route
    when 2
      add_station_to_route
    when 3
      remove_station
    when 0
      Exit 
    end
  end

  def direct_route
    if trains.size == 0
      puts "список поездов пуст, создайте сперва поезда"
      # как отсюда перейти в главное меню? прошу подсказку
    else
      my_train = select_train
    end
    if routes.size == 0
      puts "список маршрутов пуст, создайте сперва маршруты"
      # как отсюда перейти в главное меню? прошу подсказку
    else
      my_route = select_route
    end
    my_train.take_route(my_route)
    # как отсюда перейти в главное меню? прошу подсказку
  end

  def hook_vagon
    my_train = select_train
    puts "Выберите тип вагона: 
    1. Пассажирский, 
    2. Грузовой"
    type = gets.chomp.to_i
    puts "Укажите номер вагона: "
    number = gets.chomp
    if type == 1
      puts "Введите количество мест в вагоне: "
      total_of_places = gets.chomp
      my_vagon = PassengerVagon.new(number, total_of_places)
    elsif type == 2
      puts "Введите объём вагона: "
      total_volume = gets.chomp
      my_vagon = CargoVagon.new(number, total_volume)
    else
      puts "Ошибка!!!"
    end
    my_train.hook(my_vagon)
    p my_train.vagons
  end

  def unhook_vagon
    my_train = select_train
    my_vagon = select_vagon(my_train)
    my_train.unhook(my_vagon)
    p my_train.vagons
  end

  def move_train
    my_train = select_train
    if my_train.current_route == nil
      puts "Поезду не назначен маршрут. Сначала назначьте"
    else
      puts "Выберите направление движения поезда: 
      1. Вперед, 
      2. Назад"
      choise = gets.chomp.to_i
      if choise == 1
        my_train.move_forward
      elsif choise == 2
        my_train.move_back
      else
        puts "Ошибка!!!"
      end
      puts "Текущая станция #{my_train.current_station}"
    end
  end

  def list_stations
    puts "Список станций: "
    stations.each { |s| puts s.title }
  end

  def list_trains
    my_station = select_station
    puts "Список поездов на станции: "
    my_station.list_of_trains { |train| puts "Номер: #{train.num_tr}, тип: #{train.type}, кол. вагонов: #{train.vagons.size}" }
    # endtrains.each { |t| puts "Номер поезда: #{t.num_tr} Тип: #{t.type}" } 
  end

  def list_vagons
    my_train = select_train
    puts "Список вагонов поезда: "
    my_train.list_of_vagons do |v| 
      str = "Номер: #{v.number}, тип: #{v.type}"
      if v.type == :passenger
        puts str + ", занято: #{v.taken_seats}, свободно #{v.free_seats}" 
      else
        puts str + ", занято: #{v.filled_volume }, свободно #{v.free_volume}" 
      end
    end
  end

  def fill_vagon
    my_train = select_train
    my_vagon = select_vagon(my_train)
    if my_vagon.class == PassengerVagon
      puts "Сколько мест будет занято?: "
      number = gets.chomp.to_i
      number.times { my_vagon.take_seat }
      p my_vagon
    elsif my_vagon.class == CargoVagon
      puts "Сколько объёма будет занято?: "
      volume = gets.chomp.to_i
      my_vagon.fill_volume(volume)
    end
  end

  protected  # нижеследующие методы класса необходимы лишь внутри объекта класса

  attr_writer :routes, :trains, :stations

  def select_route
    puts "Выберите маршрут из списка:"
    routes.each_index { |r| puts "#{r} - #{routes[r].route.to_s}" } 
    index_route = gets.chomp.to_i
    routes[index_route]
  end

  def select_train
    puts "Выберите поезд из списка:"
    trains.each_index { |t| puts "#{t} - #{trains[t].num_tr} - #{trains[t].type}" } 
    index_train = gets.chomp.to_i
    trains[index_train]
  end

  def select_vagon(train)
    puts "Выберите вагон из состава:"
    train.vagons.each_index { |i| puts "#{i} - #{train.vagons[i]}" } 
    index_vagon = gets.chomp.to_i
    train.vagons[index_vagon]
  end

  def select_station
    puts "Выберите cтанцию из списка:"
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

  break if choise == 0 
  case choise
  when 1 
    main.create_station
  when 2 
    main.create_train
  when 3 
    main.edit_route
  when 4 
    main.direct_route
  when 5 
    main.hook_vagon
  when 6 
    main.unhook_vagon
  when 7 
    main.move_train
  when 8 
    main.list_stations
  when 9
    main.list_trains
  when 10
    main.list_vagons
  when 11
    main.fill_vagon  
  else
    puts "Вы ввели неправильное значение. Повторите снова"
  end
end