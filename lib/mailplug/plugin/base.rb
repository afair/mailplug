module Mailplug
  class Plugin::Base
    attr_accessor :env

    def initialize(env)
      self.env = env
    end

    # Connection, HELO
    def connect(ip)
      skip # or error
    end

    def server(name)
      skip
    end

    # MAIL FROM
    def sender(email)
      skip
    end

    # RCPT TO
    def recipient(email)
      skip # or error
    end

    # DATA
    def data_line(line)
      skip # or error
    end

    def message(email_message)
      skip # or error or save/accept
    end

    # Called after QUIT or disconnect for cleanup
    def quit
      skip
    end

    private

    # Call when you are okay with this state, passes control up stack
    def skip
      [:skip, nil]
    end

    # Call when you are done with processing, return control down stack
    def accept(msg=nil)
      [:message_accepted, msg]
    end

    # Calll when you find a problem, returns control down stack
    def error(error_symbol, message=nil)
      [error_symbol, msg]
    end

  end
end
