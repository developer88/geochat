class Loginza
	
	def self.verify(token)
		uri = URI("http://loginza.ru/api/authinfo?token=#{token}")
		response = JSON.parse(Net::HTTP.post_form(uri, {}).body)
		response[:error_type].nil? ? response : nil
	end


end