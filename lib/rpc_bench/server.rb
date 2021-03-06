module RPCBench
  class Server
    def initialize(opts)
      case opts[:mode]
      when 'rabbitmq'
        @driver = RabbitMQ::Server.new opts
      when 'grpc'
        @driver = GRPC::Server.new opts
      when 'zeromq'
        @driver = ZeroMQ::Server.new opts
      when 'stomp'
        @driver = Stomp::Server.new opts
      when 'nats'
        @driver = NATS::Server.new opts
      else
        raise RuntimeError.new("failed to initialize driver of '#{opts[:mode]}'")
      end

      @driver.set_handler self
    end

    def run
      @driver.run
    end

    def callback(v)
      v.to_i + 1
    end
  end
end
