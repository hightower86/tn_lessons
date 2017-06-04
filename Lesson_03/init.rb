require_relative "train"
require_relative "station"
require_relative "route"

ro = Route.new("Ленинград", "Москва")
tr = Train.new("123", "pass", 17)

#tr.current_route = ro 
p tr
p ro
p tr.current_speed
p tr.current_station
p tr.current_route
