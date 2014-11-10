require 'active_record'
require 'mysql2'
require 'net/https'
require 'uri'
require 'json'
require '../models/stop.rb'

def addToDB(stop_data)
    stop = Stop.new
    stop.stop_id            = stop_data['stop_id']
    stop.on_street          = stop_data['on_street']
    stop.cross_street       = stop_data['cross_street']
    stop.routes             = stop_data['routes']
    stop.boardings          = stop_data['boardings']
    stop.alightings         = stop_data['alightings']
    stop.month_beginning    = stop_data['month']
    stop.daytype            = stop_data['daytype']
    stop.longitude          = stop_data['location']['longitude']
    stop.latitude           = stop_data['location']['latitude']
    stop.save
end

# Establish connection to mysql db
ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql2',
    :database => 'cta',
    :encoding => 'utf8',
    :username => 'root',
    :password => 'password',
    :host     => '127.0.0.1',
    :port     => '3306'
)

uri = URI.parse('https://data.cityofchicago.org/resource/mq3i-nnqe.json')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
stop_table = JSON.parse(response.body)

stop_table.each do |stop_data|
    addToDB(stop_data)
end
