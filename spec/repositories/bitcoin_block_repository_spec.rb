# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BitcoinBlockRepository do
  subject(:repository) { described_class.new(client: client) }

  let(:client) do
    Bitcoin::Client.new(
      rpc_connect: ENV['BITCOIN_RPC_CONNECT'],
      rpc_port: ENV['BITCOIN_RPC_PORT'],
      rpc_user: ENV['BITCOIN_RPC_USER'],
      rpc_password: ENV['BITCOIN_RPC_PASSWORD'],
      time: double('Time', now: Time.at(1_708_399_313))
    )
  end

  describe '#get_latest_blocks' do
    it 'returns an array of latest blocks with the most recent block first', vcr: { cassette_name: 'bitcoin_block_repository/get_latest_blocks' } do
      blocks = repository.get_latest_blocks(count: 2)
      expect(blocks.size).to eq(2)
      expect(blocks[0]).to include('hash' => '74443e86924b475d5e30f4ab4d282fc1ab1d8c1e3e43ab7a89dfd44bf4266eab')
      expect(blocks[1]).to include('hash' => '0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206')
    end

    it 'returns an array of latest blocks with size smaller than count when height is lower', vcr: { cassette_name: 'bitcoin_block_repository/get_latest_blocks' } do
      blocks = repository.get_latest_blocks(count: 3)
      expect(blocks.size).to eq(2)
      expect(blocks[0]).to include('hash' => '74443e86924b475d5e30f4ab4d282fc1ab1d8c1e3e43ab7a89dfd44bf4266eab')
      expect(blocks[1]).to include('hash' => '0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206')
    end

    it 'returns an empty array when count is 0', vcr: { cassette_name: 'bitcoin_block_repository/get_latest_blocks' } do
      blocks = repository.get_latest_blocks(count: 0)
      expect(blocks).to eq([])
    end
  end
end
