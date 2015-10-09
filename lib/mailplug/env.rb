# SMTP Environment state
class Mailplug::Env
  attr_accessor :ip, :helo_id, :sender, :recipients, :data
  attr_accessor :logger, :memo, :headers

  def initialize(logger, ip)
    self.ip         = ip
    self.logger     = logger
    self.recipients = []
    self.data       = []
    self.memo       = {}
    self.helo_id    = self.sender = nil
  end

  ##############################################################################
  # Headers
  ##############################################################################

  def parse_headers
    self.headers = {received:[]}
    w = ""
    for line in self.data do
      if line.strip == ""
        break
      elsif w > " " && line =~ /\A\w/
        add_header(w)
        w = line
      else
        w += line
      end
    end
    add_header(w) if w > " "
    self.headers
  end

  def add_header(h)
    n, v = h.split(/:\s+/, 2)
    k = n.gsub(/\W+/,"_").downcase.to_sym
    if self.headers[k].is_a?(Array)
      self.headers[k] << v
    else
      self.headers[k] = v
    end
  end

  # Appends the header to the message. Do this AFTER any crypto-signing
  # verification checks such as DK, DKIM.
  def add_header(name, value)
  end

  # Prepends the header to the message. Do this AFTER any crypto-signing
  # verification checks such as DK, DKIM.
  def prepend_header(name, value)
  end



end
