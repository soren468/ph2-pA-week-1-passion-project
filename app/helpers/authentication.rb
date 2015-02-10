def create
  @user = User.new(user_name: params[:user_name], email: params[:email])
  p params.inspect
  @user.password = params[:password]
  @user.save!
end

def login
  @user = User.find_by(user_name: params[:user_name])
  if !@user.is_a?(User)
    @incorrect_login = true
  elsif @user.password == params[:password]
    new_session = Session.create(user_id: @user.id)
    session[:this_id] = new_session.id
  else
    @incorrect_login = true
  end
end

def forgot_password
  @user = User.find_by_email(params[:email])
  random_password = Array.new(10).map { (65 + rand(58)).chr }.join
  @user.password = random_password
  @user.save!
  Mailer.create_and_deliver_password_change(@user, random_password)
end

def logged_in?
  session[:this_id]
end

def current_user
  begin
    @user = User.find(Session.find(session[:this_id]).user_id)
  rescue
    session.clear
    redirect '/'
  end
end