# encoding: utf-8
module Service
	extend ActiveSupport::Concern
	# include ActiveModel::Model

	included do
		attr_reader :folder, :login
	end

	def label
		self.class.name.sub('Service', '').downcase.to_sym
	end

	def to_param
		label
	end

	def authorized?
		warn_unpatched
		false
	end

	def initialize(attributes = {})
		warn_unpatched		
		false
	end

	def name
		warn_unpatched
		"Unnamed Service"
	end

	def token
		warn_unpatched
		{}
	end

	def bookmarks(args = nil)
		[]
	end

	def random(num = 1)
		nil
	end

	def years_ago
		[]
	end

	private

		def warn_unpatched
			Rails.logger.warn("⚠️ Method ##{caller_locations(1,1).first.label} unpatched for #{self.class}.")
		end

end