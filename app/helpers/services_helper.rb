module ServicesHelper

	AGO_REGEX = Regexp.new("^\\d{4}-#{Time.now.month}-#{Time.now.day}")

	def find_years_ago(list)
		expression = AGO_REGEX
		list.select { |link| Time.at(link.date_read).to_s.match(expression) }
	end

end
