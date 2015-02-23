module TrackChanges
  extend ActiveSupport::Concern

  def track_changes(msg)
    h = self.histories if self.instance_of? Ticket
    h = self.ticket.histories if self.instance_of? Post
    h.create(body: msg)
  end
end