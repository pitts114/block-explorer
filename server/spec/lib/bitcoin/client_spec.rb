# frozen_string_literal: true

require 'bitcoin/client'
require 'spec_helper'

RSpec.describe Bitcoin::Client do
  subject do
    described_class.new(
      rpc_connect: rpc_connect,
      rpc_port: rpc_port,
      rpc_user: rpc_user,
      rpc_password: rpc_password,
      net_http: net_http,
      net_http_post: net_http_post,
      json: json,
      time: time
    )
  end

  let(:rpc_connect) { 'localhost' }
  let(:rpc_port) { 8332 }
  let(:rpc_user) { 'rpc_user' }
  let(:rpc_password) { 'rpc_password' }
  let(:net_http) { double('Net::HTTP') }
  let(:net_http_post) { double('Net::HTTP::Post') }
  let(:json) { double('JSON') }
  let(:time) { double('Time') }
  let(:uri) { URI.parse("http://#{rpc_connect}:#{rpc_port}") }

  describe '#call_rpc_method' do
    let(:method) { 'getblockcount' }
    let(:params) { %w[foo bar] }
    let(:request) { double('Net::HTTP::Post') }
    let(:response) { double('Net::HTTPResponse', body: '{"result": 123}') }

    before do
      allow(time).to receive_message_chain(:now, :to_i).and_return(123)
      allow(net_http_post).to receive(:new).with(uri).and_return(request)
      allow(request).to receive(:basic_auth)
      allow(request).to receive(:body=)
      allow(request).to receive(:[]=)
      allow(request).to receive(:uri).and_return(uri)
      allow(net_http).to receive(:new).with(uri.host, uri.port).and_return(net_http)
      allow(net_http).to receive(:request).with(request).and_return(response)
      allow(json).to receive(:parse).with(response.body).and_return('result' => 123)
    end

    it 'returns the result' do
      expect(subject.call_rpc_method(method: method, params: params)).to eq('result' => 123)
    end
  end
end
