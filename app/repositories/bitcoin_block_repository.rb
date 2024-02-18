# frozen_string_literal: true

class BitcoinBlockRepository
  def initialize(
    client: Bitcoin::Client.new(
      rpc_user: ENV['BITCOIN_RPC_USER'],
      rpc_password: ENV['BITCOIN_RPC_PASSWORD'],
      rpc_connect: ENV['BITCOIN_RPC_CONNECT'],
      rpc_port: ENV['BITCOIN_RPC_PORT']
    )
  )
    @client = client
  end

  def get_latest_blocks(count:)
    return [] if count.zero?

    current_block_count = @client.call_rpc_method(method: 'getblockcount')['result']

    ((current_block_count - count + 1)..current_block_count).reverse_each.map do |height|
      block_hash = @client.call_rpc_method(method: 'getblockhash', params: [height])
      @client.call_rpc_method(method: 'getblock', params: [block_hash, 1])
    end
  end
end
