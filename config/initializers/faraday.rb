require 'faraday_middleware'

FaradayConnection = Faraday.new 'localhost:8081' do |conn|
  conn.request :json
  conn.response :json, :content_type => /\bjson$/

  conn.use :instrumentation
  conn.adapter Faraday.default_adapter
end
