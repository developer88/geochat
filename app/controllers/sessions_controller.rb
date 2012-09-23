	require 'net/http'
class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.try_to_authenticate(params)
		if user
			session[:user_id] = user.id
	    	redirect_to root_url, :notice => "Logged in!"
	    else
	    	flash.now.alert = "Invalid email or password"
	    	render "new"
	    end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end

	def check_password

	end

	

end