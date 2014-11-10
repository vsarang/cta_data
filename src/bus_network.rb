require '../models/route.rb'
require '../models/stop.rb'

class BusNetwork
    attr_reader :routeWithMostStops

    def initialize
        @stops = Hash.new
        @routes = Hash.new
    end

    def addStop(stop)
        @stops[stop.stop_id.to_s] = stop
        stop.routes.split.each do |route|
            if @routes[route] == nil
                @routes[route] = Route.new(route)
            end

            @routes[route].addStop(stop)
            updateRouteWithMostStops(stop)
        end
    end

    private
    def updateRouteWithMostStops(route)
        if @routeWithMostStops.stops.length < route.length
            @routeWithMostStops = route
        end
    end
end
