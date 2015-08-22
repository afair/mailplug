module Mailplug
  class Plugin::Example < Mailplug::Middleware

    # Message Envelope Methods
    def return_path
    end

    def recipients
    end

    def message # returns Mail::Message
    end

    # Hash of state and inter-stack data memo[classname][key]=value
    def memo
    end

    # SMTP State Changes

    def open(remote_ip)
    end

    def helo(server_name)
    end

    def mail_from(email)
    end

    def rcpt_to(email)
    end

    def data
    end

    def data_line(line)
    end

    def data_stop
    end

    def save # false(i don't queue), true (i queued), error msg
    end

    def quit
    end

    def close
    end

    def header(name, value)
    end

    def abort(code, msg) # Stop it with reason
    end

    def continue # don't stop
    end

    def log(msg)
    end

    def status(number, message, close, waitseconds=0)
    end

    # SMTP Responses  http://www.greenend.org.uk/r
    def service_ready # 220
    end
  end
end
