module Replicate
  REPLICATE_API_BASE_URL = "https://api.replicate.com"

  attr_reader :api_key, :adaptor

  # Client for the Replicate API
  class Client
    def initialize(token:, adaptor=Faraday.default_adaptor)
      @token = token
      @adaptor = adaptor
      @connection = Faraday.new(url: REPLICATE_API_BASE_URL) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter adaptor
      end
    end

  
    private 

    def headers()
      return {
        "Authorization": "Token #{@api_token}",
        "User-Agent": "replicate-ruby@#{__version__}",
      }
    end

    def requests(method:, path:, **kwargs)
      if ["GET", "OPTIONS"].include? method
        kwargs.setdefault(:allow_redirects, true)
      end 
      if ["HEAD"].include? method
        kwargs.setdefault(:allow_redirects, false)
      end
      kwargs.setdefault(:headers, {})


    #   if method in ["GET", "OPTIONS"]:
    #     kwargs.setdefault("allow_redirects", True)
    # if method in ["HEAD"]:
    #     kwargs.setdefault("allow_redirects", False)
    # kwargs.setdefault("headers", {})
    # kwargs["headers"].update(self._headers())
    # resp = self.session.request(method, self.base_url + path, **kwargs)
    # if 400 <= resp.status_code < 600:
    #     try:
    #         raise ReplicateError(resp.json()["detail"])
    #     except (JSONDecodeError, KeyError):
    #         pass
    #     raise ReplicateError(f"HTTP error: {resp.status_code, resp.reason}")
    # return resp
    end

  end
end