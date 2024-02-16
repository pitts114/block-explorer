# frozen_string_literal: true

module Bitcoin
  class Client
    def initialize(host: 'localhost', port: 8332, user: nil, password: nil)
      @connection = Connection.new
    end

    def getblockchaininfo
      @connection.get('/getblockchaininfo')
    end
  end
end
