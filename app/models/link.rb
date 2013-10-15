class Link

	attr_accessor :url, :title, :date_read, :service, :service_id

	def formatted_date
		Date.parse(Time.at(self.date_read).to_s).to_formatted_s(:long_ordinal)
	end

end