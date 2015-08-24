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
      true
    end

    def helo(server_name)
      true
    end

    def mail_from(email)
      true
    end

    def rcpt_to(email)
      true
    end

    def data
      true
    end

    def data_line(line)
      true
    end

    def data_stop
      true
    end

    def save # false(i don't queue), true (i queued), error msg
      true
    end

    def quit
      true
    end

    def disconnect
      true
    end

    def header(name, value)
      true
    end

    def abort(code, msg) # Stop it with reason
      true
    end

    def continue # don't stop
      true
    end

    ############################################################################
    # Responders (from http://www.greenend.org.uk/rjk/tech/smtpreplies.html)
    #
    # 200 (nonstandard success response, see rfc876)
    # 211	System status, or system help reply
    # 214	Help message
    # 220	<domain> Service ready
    # 221	<domain> Service closing transmission channel
    # 250	Requested mail action okay, completed
    # 251	User not local; will forward to <forward-path>
    # 252	Cannot VRFY user, but will accept message and attempt delivery
    # 354	Start mail input; end with <CRLF>.<CRLF>
    # 421	<domain> Service not available, closing transmission channel
    # 450	Requested mail action not taken: mailbox unavailable
    # 451	Requested action aborted: local error in processing
    # 452	Requested action not taken: insufficient system storage
    # 500	Syntax error, command unrecognised
    # 501	Syntax error in parameters or arguments
    # 502	Command not implemented
    # 503	Bad sequence of commands
    # 504	Command parameter not implemented
    # 521	<domain> does not accept mail (see rfc1846)
    # 530	Access denied (???a Sendmailism)
    # 550	Requested action not taken: mailbox unavailable
    # 551	User not local; please try <forward-path>
    # 552	Requested mail action aborted: exceeded storage allocation
    # 553	Requested action not taken: mailbox name not allowed
    # 554	Transaction failed
    ############################################################################

    REPLY = {
      :bad_user => [:skip, 251, "Requested action not taken: mailbox unavailable"]
    }

    ############################################################################
    # Helpers
    ############################################################################

    def log(msg)
      true
    end

    def status(number, message, close, waitseconds=0)
    end

  end
end
