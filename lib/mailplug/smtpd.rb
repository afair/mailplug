class Mailplug::SMTPD
  attr_accessor :options, :stack, :env

  def initialize(conn, options={})
    self.conn = conn
    self.options = {}
    ENV.each {|n,v| self.options[n.downcase.to_sym] = v}
    self.options.merge!(options)
    self.env = Mailplug::ENV.new
    self.stack = Mailplug::Stack.new(env)
  end

  def respond(msg)
    self.conn.write(msg.chomp + "\r\n")
  end

  def okay(msg = nil)
    respond(msg || "250 OK")
    true
  end

  def error(msg)
    respond(msg)
    conn.close
    false
  end

  def readline
    self.conn.read.chomp
  end

  def protocol
    unless self.stack.connect(conn.ip)
      respond self.stack.error_message
      return close
    end
    while line = readline
      okay = case line.split.first
      when 'HELO'
        helo(line)
      when 'MAIL'
        mail(line)
      when 'RCPT'
        rcpt(line)
      when 'DATA'
        data(line)
      when 'QUIT'
        return close
      else
        respond("400 COMMAND UNKNOWN")
      end
      break unles okay
    end
    close
  end

  def close
    conn.close
  end

  def helo(line)
    unless self.stack.hello(line)
      return error(self.stack.error_message)
    end
    okay
  end

  def mail(line)
    if line =~ /\<(\S+)\>/
      self.env.sender = $1
      unless self.stack.sender($1)
        return error(self.stack.error_message)
      end
      return okay
    else
      return error(self.stack.syntax_error)
    end
  end

  def rcpt(line)
    if line =~ /\<(\S+)\>/
      self.env.recipients << $1
      unless self.stack.recipient($1)
        return error(self.stack.error_message)
      end
      return okay
    else
      return error(self.stack.syntax_error)
    end
  end

  def data(line)
    respond("250 GO AHEAD")
    while line = readline
      if line == "."
        unless self.stack.message
          return error(self.stack.error_message)
        end
        return okay
      else
        line = line[1,] if line.start_with?("..")
        self.data << line
      end
    end
  end

end
