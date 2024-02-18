# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BitcoinBlockRepository do
  subject(:repository) { described_class.new(client: client) }

  let(:client) { double('BitcoinClient') }
  let(:block) { double(:block) }
  let(:most_recent_block) { double(:most_recent_block) }

  describe '#get_latest_blocks' do
    let(:current_block_count) { { 'result' => 100 } }

    before do
      allow(client).to receive(:call_rpc_method).with(method: 'getblockcount')
                                                .and_return(current_block_count)
      allow(client).to receive(:call_rpc_method).with(method: 'getblockhash', params: [100])
                                                .and_return('result' => 'block_hash')
      allow(client).to receive(:call_rpc_method).with(method: 'getblock', params: ['block_hash', 1])
                                                .and_return('result' => most_recent_block)
      allow(client).to receive(:call_rpc_method).with(method: 'getblockhash', params: [99])
                                                .and_return('result' => 'most_recent_block_hash_99')
      allow(client).to receive(:call_rpc_method).with(method: 'getblock', params: ['most_recent_block_hash_99', 1])
                                                .and_return('result' => block)
    end

    it 'returns an array of latest blocks with the most recent block first' do
      blocks = repository.get_latest_blocks(count: 2)

      expect(blocks).to eq([most_recent_block, block])
    end

    it 'returns an empty array when count is 0' do
      blocks = repository.get_latest_blocks(count: 0)

      expect(blocks).to eq([])
    end
  end
end
