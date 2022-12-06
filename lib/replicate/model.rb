module Replicate
  class Model
    attr_reader :version_id, :path

    def initialize(client:, path:) 
      @client = client
      @path = path
      response = client.requests(method: "GET", path: "models/#{path}")
      @version_id = response.body["latest_version"]["id"]
    end

    def predict(prompt:, height = 512, width = 512)
      body = {version: @version_id, input: {prompt: prompt, height: height, width: width}}
      response = @client.requests(method: "POST", path: "predictions", **body)
      poll(prediction_id: response.body["id"])
    end

    def poll(prediction_id:)
      response = @client.requests(method: "GET", path: "predictions/#{prediction_id}")
      puts(response.body["status"])
      if !["succeeded", "failed", "canceled"].include?(response.body["status"])
        sleep(2)
        poll(prediction_id: prediction_id)
      elsif response.body["status"] == "succeeded" 
        return response.body["output"][0]
      else
        raise response.body["error"]
      end
    end

  end
end
