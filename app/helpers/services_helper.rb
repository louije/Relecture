module ServicesHelper

	AGO_REGEX = Regexp.new("^\\d{4}-#{Time.now.month}-#{Time.now.day}")

	def find_years_ago(list)
		expression = AGO_REGEX
		# ago = "-#{Time.now.month}-#{Time.now.day}"
		today = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
		list.select { |link| t = Time.at(link.date_read).to_s; !today.in?(t) and t.match(expression) }
	end

end
