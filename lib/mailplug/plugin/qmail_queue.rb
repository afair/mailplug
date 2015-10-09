class Mailplug::Plugin::QmailQueue < Mailplug::Plugin::Base
  def message(email_message)
    # fork
    # exec qmail-queue
    # write(0, message)
    # close(0)
    # write(1,F+env.sender+ "\0")
    # env.recipients.each {|r| write(1,T+t+"\0") }
    # write(1,"\0")
    # close(1)
    # read
    # rc = wait
    rc==0 ? accept : error(:message_error)
  end
end
