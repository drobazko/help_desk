module IdGeneration
	extend ActiveSupport::Concern

	module ClassMethods
		def get_uniq_id
			id = ''
			loop {
				id = generate_id
				break unless Ticket.find_by_token(id)
			}
			id
		end

		def generate_id
			id = []
			"%s-%d-%s-%d-%s".split('-').each{|v| id << (v.eql?('%s') ? generate_characters : generate_digits)}
			id.join('-')
		end

		def generate_digits(quantity = 3)
			(0..9).to_a.shuffle[0, quantity].join
		end

		def generate_characters(quantity = 3)
			('A'..'Z').to_a.shuffle[0, quantity].join
		end		
	end
end