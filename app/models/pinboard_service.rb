class PinboardService
	include Service
	include ServicesHelper
	attr_reader :pinboard

	def name
		"Pinboard"
	end

	def initialize(attributes = {})		
		@token = attributes[:token]
		@login = attributes[:login]
		attributes[:username] = @login if @login

		@pinboard = Pinboard::Client.new(attributes)
	end

	def authorized?
		@pinboard and @pinboard.api_token
	end

	def token
		if !@token and @login
			@token = @login + ":" + @pinboard.api_token
		end
		{ token: @token }
	end

	def bookmarks(args = nil)
		# Due to Pinboard API limits, a call to /posts/all is wont to cause problems. Watch for errors.
		posts = pinboard.posts
		@links = posts.map do |p|
			post_to_link(p)
		end
		@links.sort_by(&:date_read)
	end

	def random(num = 1)
		return @links.sample(num) if @links and @links.count > 0
		@dates ||= pinboard.dates.keys
		return post_to_link pinboard.get({ dt: @dates.sample }).sample if num == 1
		
		links = []
		num.times do
			links << post_to_link(pinboard.get({ dt: @dates.sample }).sample)
		end
		return links
	end

	def years_ago
		@dates ||= pinboard.dates.keys
		today = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
		days = @dates.select{ |date| !date.include?(today) and date.match(AGO_REGEX) }
		days.map do |date|
			pinboard.get({ dt: date }).map { |p| post_to_link p }
		end.flatten
	end

	private

		def post_to_link p
			l = Link.new
			l.url = p.href
			l.title = p.description
			l.date_read = p.time
			l.service = :pinboard
			l
		end

end