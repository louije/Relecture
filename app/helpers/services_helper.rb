module ServicesHelper

	def years_ago(list)
		expression = Regexp.new("^\\d{4}-#{Time.now.month}-#{Time.now.day}")
		list.select { |link| Time.at(link.date_read).to_s.match(expression) }
	end

end
