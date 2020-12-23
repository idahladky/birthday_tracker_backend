class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
    #This requires the authorization method from the ApplicationController to be run before ONLY the autologin method of this controller.
  
    # REGISTER
    def create
      @user = User.create(user_params)  # This creates a new user using the data returned from the user_params method. 
      if @user.valid? # If the new user is validated (matches the user schema) then...
        token = encode_token({user_id: @user.id}) # a JWT token is signed and...
        render json: {user: @user, token: token} # returned in a json object to the client.
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
    # LOGGING IN
    def login
      @user = User.find_by(username: params[:username]) # Looks up the username and compares the password passed in
  
      if @user && @user.authenticate(params[:password]) # if all checks out...
        token = encode_token({user_id: @user.id}) # generate an JWT token and...
        render json: {user: @user, token: token} # send it over in a JSON object.
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
  
    def auto_login
      render json: @user # returns the user object as JSON assuming the user has previously logged in (in which case the authenticate function will run successfully)
    end
  
    private
  
    def user_params
        # private function that parses the needed data from the request to create a new user
      params.permit(:username, :password, :age)
    end
  
  end
