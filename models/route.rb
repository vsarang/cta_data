class Route
    attr_reader :name
    attr_reader :stops
    attr_reader :totalBoardings
    attr_reader :totalAlightings

    def initialize(name)
        @name = name
        @stops = Hash.new
        @totalBoardings = 0
        @totalAlightings = 0
    end

    def addStop(stop)
        @stops[stop.stop_id.to_s] = stop
        @totalBoardings = @totalBoardings + stop.boardings
        @totalAlightings = @totalAlightings + stop.alightings
    end
end
