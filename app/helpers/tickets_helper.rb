module TicketsHelper
	def statuses_for_select
	  Status.all.collect { |m| [m.title, m.id] }
	end
end
