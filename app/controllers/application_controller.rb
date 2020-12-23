class ApplicationController < ActionController::API
    before_action :authorized 
    #  this macro tells rails to run the authorized funcion before completing any request to the API. (to make sure they are logged in before they use the API)

  def encode_token(payload) 
    # this method takes in a payload (a hash of key/values you want to save in the token) and signs a token using a secret key. (in production this should an ENV variable.)
    JWT.encode(payload, 'yourSecret') 
  end

  def auth_header 
    # When determining if someone is logged in the frontend usually sends the token in the “Authorization” header preceded by the word bearer, this function checks to see if the header was sent.
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization'] 
  end

  def decoded_token 
    if auth_header #If the auth header is present...
      token = auth_header.split(' ')[1] #this function parses the string...
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256') #for the token and verified it and pulls out the payload (the hash we stored in the token when we created it).
      rescue JWT::DecodeError # If verification fails it will 
        nil # return nil.
      end
    end
  end

  def logged_in_user 
    if decoded_token #if decoding the token is successful...
      user_id = decoded_token[0]['user_id'] # it grabs the username from the payload 
      @user = User.find_by(id: user_id) # and searches our user in the database.
      # @user - an instance property -> adds property to the controller called user. this looks for user in the database and asigns the user to that database. this makes user available to any routes. 
    end
  end

  def logged_in?
    !!logged_in_user #  returns true if logged in
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in? # returns a message asking user to log in unless logged_in returns true
  end
end
