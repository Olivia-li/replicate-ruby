require 'faraday'
require 'pry'


module Replicate
  REPLICATE_API_BASE_URL = "https://api.replicate.com/v1"

  # Client for the Replicate API
  class Client
    attr_reader :token, :adaptor, :connection

    def initialize(token:, adaptor: Faraday.default_adapter)
      @token = token
      @adaptor = adaptor
      @connection = Faraday.new(url: REPLICATE_API_BASE_URL) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter adaptor
        faraday.headers = headers()
      end
    end

    def models(path)
      return Replicate::Model.new(client: self, path: path)
    end
  
    def headers
      return {
        "Authorization": "Token #{@token}",
        "User-Agent": "replicate-ruby@#{Replicate::VERSION}",
      }
    end

    def api_token
      unless @token
        raise ReplicateError("No API token provided. You need to set the REPLICATE_API_TOKEN environment variable or create a client with 'replicate.Client(api_token=...)'. You can find your API key on https://replicate.com")
      end
      return @token
    end

    def requests(method:, path:, **kwargs)
      if ["GET", "OPTIONS"].include? method
        kwargs = kwargs.merge({allow_redirects: true})
      end 
      if ["HEAD"].include? method
        kwargs = kwargs.merge({allow_redirects: false})
      end
      response = @connection.send(method.downcase, path, kwargs)
      if 400 <= response.status && response.status < 600
        raise ("HTTP error: #{response.status}, #{response.reason_phrase}")
      end
      return response
    end

  end
end