# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bitcoin::Client, type: :integration do
  let(:rpc_port) { ENV['BITCOIN_RPC_PORT'] }
  let(:rpc_user) { ENV['BITCOIN_RPC_USER'] }
  let(:rpc_password) { ENV['BITCOIN_RPC_PASSWORD'] }
  let(:rpc_connect) { ENV['BITCOIN_RPC_CONNECT'] }
  let(:client) do
    described_class.new(
      rpc_connect: rpc_connect,
      rpc_port: rpc_port,
      rpc_user: rpc_user,
      rpc_password: rpc_password
    )
  end

  describe '#call_rpc_method' do
    it 'successfully calls the bitcoind service and gets blockchain info' do
      response = client.call_rpc_method(method: 'getblockchaininfo')
      expect(response['result']['blocks']).to be_an(Integer)
    end
  end
end
