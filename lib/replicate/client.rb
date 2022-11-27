require 'faraday'
require 'pry'


module Replicate
  REPLICATE_API_BASE_URL = "https://api.replicate.com/v1"

  # Client for the Replicate API
  class Client
    attr_reader :token, :conn

    def initialize(token:, &block)
      @token = token
      if block_given?
        conn &block
      else
        conn
      end

    end

    def conn(&block)
      @conn ||= Faraday.new(url: REPLICATE_API_BASE_URL) do |f|
        yield f if block_given?
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.headers = headers()
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

    def requests(method:, path:, **kwargs)
      if ["GET", "OPTIONS"].include? method
        kwargs = kwargs.merge({allow_redirects: true})
      end 
      if ["HEAD"].include? method
        kwargs = kwargs.merge({allow_redirects: false})
      end
      response = @conn.send(method.downcase, path, kwargs)
      if 400 <= response.status && response.status < 600
        raise ("HTTP error: #{response.status}, #{response.reason_phrase}")
      end
      return response
    end

  end
end