require "thor"

module Mailplug
  class CLI < Thor
    desc "accept", "Accepts a TCP Connection to accept email via SMTP"
    def accept
      put "Accepted!"
    end
  end
end

Mailplug::CLI.start(ARGV)
