# frozen_string_literal: true

class GetLatestBlocksCommand
  include Callable

  def initialize(block_repository: BitcoinBlockRepository)
    @block_repository = block_repository
  end

  def call(count:)
    blocks = @block_repository.get_latest_blocks(count: count)

    Struct.new(:success?, :blocks).new(true, blocks)
  end
end
