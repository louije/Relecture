module Service
	# include ActiveSupport::Concern
	# include ActiveModel::Model

	def to_param
		self.class.name.sub('Service', '').downcase.to_sym
	end

end