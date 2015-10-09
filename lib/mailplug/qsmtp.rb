################################################################################
# QSMTP is a "Quick SMTP" Protocol variation which removes the
# chatty request/response cycle and sends all the data at once.
# At any point, the server can send an error or success message and close the
# connection. It will only send a single response.
# This is called SMTP PIPELINING.
#-------------------------------------------------------------------------------
# Command     Code Response            Default Message
# ----------- ---- ------------------- -----------------------------------------
# Any         500  PROTOCOL_ERROR      Syntax error, command, or protocol violation
#             451  SERVICE_ERROR       Error occurred processing your request
#             421  SERVICE_UNAVAILABLE Try again later
#             420  PROTOCOL_TIMEOUT    Timeout error ocurred
# Connect     400  CONNECTION_REFUSED  Connection is not allowed from this IP
#             421  CONNECTION_LIMIT    Limited connections from  your IP/Block
#             421  CONNECTION_DEFERRED Try again later
#             421  MESSAGE_LIMIT       Limited messages from your IP.Block
# HELO        400  IDENTITY_ERROR      Your server is not properly identified
# MAIL FROM   400  SENDER_REFUSED      Sender not allowed
#             550  SENDER_ERROR        Could not determine sender
# RCPT TO     551  RECIPIENT_UNKNOWN   Recipient unknown
#             422  MAILBOX_UNAVAILABLE Mailbox is full or unavailable
# DATA        250  MESSAGE_ACCEPTED    Message Queued for Delivery
#             550  MESSAGE_REFUSED     Content, Size, Policy
#             554  MESSAGE_REJECTED    SPF, DKIM, DMARC, Hop/Mail-Loop
#             452  MESSAGE_ERROR       Error while saving message
#-------------------------------------------------------------------------------
# Client:   HELO mail.example.com
# Client:   MAIL FROM: <sender@example.com>
# Client:   RCPT TO: <recipient@example.com>
# Client:   DATA
# Client:   From: Sender <sender@example.com>
# Client:   To: Recipient <recipient@example.com>
# Client:   Subject: QSMTP Example
# Client:
# Client:   Message Body
# Client:   .
# Server:   250 OK Message Accepted
################################################################################

class Mailplug::QSMTP
end
