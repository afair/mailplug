module Mailplug
  class Session
    STATES = %w{ready connect helo mail_from rcpt_to data save disconnect}
    ACTIONS = %w{accept error defer pretend drop}
    attr_accessor :state, :connection, :host, :sender, :recipients, :data, :memo

    def initialize(config={})
      @config     = config
      @state      = 'ready'
      @action     = 'accept'
      @connection = @host = @sender = @data = nil
      @recipients = []
      @memo       = Hash.new()
    end

    def mail
      @mail = @data && Mail.new(@data)
    end

  end
end
