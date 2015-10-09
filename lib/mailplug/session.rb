module Mailplug
  class Session
    STATES  = %w{ready connect helo mail_from rcpt_to data save disconnect}
    ACTIONS = {defer: 1, drop: 3, error:5, pretend:8, accept:10, info:20}

    attr_accessor :state, :remote_ip, :remote_host, :sender, :recipients, :data,
                  :memo, :logger

    def initialize(config={})
      @config     = config
      @state      = 'ready'
      @action     = 'accept'
      @connection = @host = @sender = @data = nil
      @recipients = []
      @memo       = Hash.new()
      @logger     = config[:logger] || Logger.new("mailplug.log")
    end

    def mail
      @mail = @data && Mail.new(@data)
    end

    def self.new_message(data, mail_from, recipients, config={})
      m = new(config)
      m.data = data
      m.mail_from = mail_from
      m.recipients = recipients
      m
    end

  end
end
