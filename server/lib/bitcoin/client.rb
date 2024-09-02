# frozen_string_literal: true

require 'net/http'
require 'json'

module Bitcoin
  class Client
    # rubocop:disable Metrics/ParameterLists
    def initialize(
      rpc_connect:,
      rpc_port:,
      rpc_user:,
      rpc_password:,
      net_http: Net::HTTP,
      net_http_post: Net::HTTP::Post,
      json: JSON,
      time: Time,
      uri: nil
    )
      @rpc_connect = rpc_connect
      @rpc_port = rpc_port
      @rpc_user = rpc_user
      @rpc_password = rpc_password
      @net_http = net_http
      @net_http_post = net_http_post
      @json = json
      @time = time
      @uri = uri || URI("http://#{@rpc_connect}:#{@rpc_port}/")
    end
    # rubocop:enable Metrics/ParameterLists

    def call_rpc_method(method:, params: [])
      request = build_request(method, params)
      response = send_request(request)
      parse_response(response)
    end

    private

    def build_request(method, params)
      request = @net_http_post.new(@uri)
      request.basic_auth(@rpc_user, @rpc_password)
      request.body = {
        jsonrpc: '1.0',
        id: "#{method}_#{@time.now.to_i}",
        method: method,
        params: params
      }.to_json
      request['Content-Type'] = 'text/plain'
      request
    end

    def send_request(request)
      http = @net_http.new(request.uri.host, request.uri.port)

      response = http.request(request)
      response.body
    end

    def parse_response(response)
      @json.parse(response)
    end
  end
end
