require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir["./app/models/*.rb"].each {|f| require f}

class App < Sinatra::Base
    
    get '/' do
        "Hello world"
    end

    post '/webhock' do
        request.body.rewind
        result = JSON.parse(request.body.read)["queryResult"]

        if result["contexts"].present?
            response = InterpretService.call(result["action"], result["context"][0]["parameters"])
        else
            response = InterpretService.call(result["action"], result["parameters"])
        end

        content_type :json, charset: 'utf-8'
        {
            "fulfillmentText": response,
            "payload":{
                "telegram": {
                    "text": response,
                    "parse_mode": "Markdown"
                }
            }
        }.to_json

    end

end