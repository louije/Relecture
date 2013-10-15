class InstapaperService
	include Service

	attr_reader :instapaper, :folder, :login, :password

	def initialize(attributes = {})
		Instapaper.consumer_key    = Rails.application.config.instapaper_consumer_key
		Instapaper.consumer_secret = Rails.application.config.instapaper_consumer_secret

		if attributes[:oauth_token] and attributes[:oauth_token_secret]
			@instapaper = Instapaper.client
			@instapaper.oauth_token = attributes[:oauth_token]
			@instapaper.oauth_token_secret = attributes[:oauth_token_secret]
		elsif attributes[:login] and attributes[:password]
			@instapaper = Instapaper.client
			token_pair = @instapaper.access_token(attributes[:login], attributes[:password])
			@instapaper.oauth_token = token_pair["oauth_token"]
			@instapaper.oauth_token_secret = token_pair["oauth_token_secret"]
		end

	end

	def authorized?
		@instapaper and @instapaper.verify_credentials
	end

	def bookmarks(args = {})
		args = {} unless args
		@folder = args[:folder] || "starred"

		Rails.logger.info('Calling Instapaper...')
		bookmarks = @instapaper.bookmarks(folder_id: @folder, limit: 500)
		Rails.logger.info("Got #{bookmarks.count} bookmarks from folder #{@folder}.")
		
		links = bookmarks.map do |b|
			l = Link.new
			l.url = b.url
			l.title = b.title
			l.date_read = b.time
			l.service = :instapaper
			l.service_id = b.bookmark_id
			l
		end
		links.sort_by(&:date_read)
		links
	end

	def available_folders
		[ ["Unread", "unread"], ["Starred", "starred"], ["Archive", "archive"] ] + @instapaper.folders.map { |f| [f.title, f.folder_id] }
	end

	def token
		{
			oauth_token: @instapaper.oauth_token,
			oauth_token_secret: @instapaper.oauth_token_secret
		}
	end

	def name
		"Instapaper"
	end

end