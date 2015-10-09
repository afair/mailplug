module Mailplug
  class Middleware
    STATES = %w{ready open helo mail_from rcpt_to data save close}
    attr_accessor :session, :config

    def initialize(session, config={})
      self.session = session
      self.config  = config
    end

    ############################################################################
    # Session Delegators for session data
    ############################################################################

    # Returns the name of the current SMTP state
    def state
      self.session.state
    end

    # Returns the name of the host offered in the SMTP "HELO" command
    def host
      self.session.host
    end

    # Returns the email address given in the "MAIL FROM" command.
    # This is where undeliverable messages are returned.
    def sender
      self.session.sender
    end

    # Returns the list of recipients given at the "RCPT TO" command.
    # These are either local mailboxes for delivery or remote addresses
    # for relay or sending.
    def recipients
      self.session.recipients
    end

    # Returns a Mail::Message object initialized with the message from
    # the SMTP "DATA" command or message text. This is unavailable until
    # the message is completely received, and would return nil until then.
    def data
      self.session.data
    end


    ############################################################################
    # SMTP State Changes. Each should return:
    # - True: I'm okay with that
    # - error_code: throw error, change state
    ############################################################################

    def connect(remote_ip)
      ok
    end

    def helo(server_name)
      ok
    end

    def mail_from(email)
      ok
    end

    def rcpt_to(email)
      ok
    end

    def data
      ok
    end

    def data_line(line)
      ok
    end

    def received
      ok
    end

    # Call to perform a store/save/queue. Return nil if you don't save and pass
    # the responsibility down the chain. Otherwise, return ok or error.
    def save
      nil
    end

    def quit
      ok
    end

    def disconnect
      ok
    end

    def header(name, value)
      ok
    end


    ############################################################################
    # Responders (from http://www.greenend.org.uk/rjk/tech/smtpreplies.html)
    # accpeted limit server blocked content other mailbox recipient
    RESPONSES = {
      remote_badhost:     "",
      remote_rbl:         "",
      remote_connections: "",
      remote_rate_limit:  "",
      remote_rejected:    "",
      server_unavailable: "",
      sender_bad:         "",
      sender_rejected:    "",
      sender_reputation:  "",
      recipient_bad:      "",
      recipient_unknown:  "",
      recipient_rejected: "",
      recipient_quota:    "",
      content_rejected:   "",
      content_filter:     "",
      content_unsigned:   "",
      failed_spf:         "",
      failed_dmarc:       "",
      failed_dk:          "",
      failed_dkim:        "",
      error_resources:    "",
    }

    ############################################################################
    # Helpers
    ############################################################################

    # Returns a Success or Bypassed result
    def ok(msg=nil)
      REPLY[:ok]
    end

    def error(code, message=nil)
      REPLY[code]
    end

    def abort(code, msg) # Stop it with reason
      ok
    end

    def continue # don't stop
      ok
    end

    def log(msg)
      true
    end

    def status(number, message, close, waitseconds=0)
    end

  end
end
