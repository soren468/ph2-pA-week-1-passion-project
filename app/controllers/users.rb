get '/users' do
  @users = User.all
  erb :'users/all_users'
end

# Page to create a new user
get '/users/new' do
  @errors = {}
  erb :'users/new_user'
end

# Authenticate and update the session / Return errors
post '/users/login' do
  # Handle when the user does not exist
  @incorrect_login = false
  login
  content_type :json
  params[:password]
  return {
    successful: false,
    content: (erb :'users/incorrect_login', layout: false)
  }.to_json if (@incorrect_login) == true
  return {
    successful: true,
    content: (erb :header, layout: false)
  }.to_json
end

get '/users/logout' do
  session.delete(:this_id)
  redirect '/images'
end

# Create and add user to the database
post '/users' do
  # Handle bad information
  begin
    create
    login
  rescue
  end
  content_type :json
  if @user.persisted?
    return {
      successful: true
    }.to_json
  else
    return {
      successful: false,
      content:(erb :'users/signup_errors', layout: false)
    }.to_json
  end
end

# View a particular user
get '/users/:id' do
  @liked_images = current_user.liked_images
  @disliked_images = current_user.disliked_images
  erb :'users/user_page'
end

# Edit page for a particular user
get '/users/:id/edit' do

end

# Update a users preferences
put '/users/:id' do

end

# Delete a user
delete '/users/:id' do
  current_user.delete
  session.clear
  redirect '/images'
end