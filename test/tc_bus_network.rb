require '../src/bus_network.rb'

class TestBusNetwork < Test::Unit::TestCase
    def testRouteWithMostStops
        stops = Array.new
        5.times do |i|
            stops.push(Stop.new)
            stops[i].stop_id = i
            stops[i].boardings = 1
            stops[i].alightings = 1
        end
        stops[1].routes = 'B'
        stops[2].routes = 'A,B'
        stops[3].routes = 'A,B,C'
        stops[4].routes = 'A,B,C,D'

        busNetwork = BusNetwork.new
        stops.each do |stop|
            busNetwork.addStop(stop)
        end

        assert(busNetwork.routeWithMostStops.name == 'B')
    end
end
