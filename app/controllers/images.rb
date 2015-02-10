# Display an image specially selected for user
get '/images' do
  get_recommendation

  begin
    erb :'images/view_image'
  rescue
    session.clear
    erb :'images/view_image'
  end
end

# Page to upload new image
get '/images/new' do
  erb :'images/new_image'
end

# Get a random image from le server
get '/images/random' do
  get_random_recommendation
  erb :'images/view_image', layout: false
end

# Add image to the database
post '/images' do
  imagedata = Cloudinary::Uploader.upload(params[:file][:tempfile], cloud_name: 'dtxam53uz', api_key: '652441437488924', api_secret: 'qNuJk5DfocBDd52B0emcCK_EDUo')
  image = Image.create(link: imagedata["url"])
  redirect "/images/#{image.id}"
end

# View a particular image
get '/images/:id' do
  @image = Image.find(params[:id])
  erb :'images/view_image'
end

# Edit page for a particular image
get '/images/:id/edit' do
end

post '/images/*/like' do
  Like.create(image_id: params[:splat][0], user_id: current_user.id)
  generate_similarities
  get_recommendation
  erb :'images/view_image', layout: false
end

post '/images/*/dislike' do
  Dislike.create(image_id: params[:splat][0], user_id: current_user.id)
  generate_similarities
  get_recommendation
  erb :'images/view_image', layout: false
end

# Update an image
put '/images/:id' do
end

# Delete a image
delete '/images' do
  Image.find_by(link: params[:url]).delete
end
