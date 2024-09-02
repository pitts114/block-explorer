# frozen_sting_literal: true

require 'rails_helper'

RSpec.describe GetLatestBlocksCommand do
  subject(:command) { described_class.new(block_repository: block_repository) }

  let(:block_repository) { instance_double(BitcoinBlockRepository) }
  let(:count) { 10 }
  let(:blocks) { double(:blocks) }

  before do
    allow(block_repository).to receive(:get_latest_blocks).with(count: count).and_return(blocks)
  end

  it 'returns the latest blocks' do
    result = command.call(count: count)
    expect(result.success?).to be true
    expect(result.blocks).to eq(blocks)
  end
end
