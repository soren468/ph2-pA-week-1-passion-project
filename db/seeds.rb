cursor = nil
loop do
  resources = Cloudinary::Api.resources(cloud_name: 'dtxam53uz', api_key: '652441437488924', api_secret: 'qNuJk5DfocBDd52B0emcCK_EDUo', next_cursor: cursor)
  resources["resources"].each do |image_info|
    Image.create(link: image_info["url"])
  end
  cursor = resources["next_cursor"]
  break if cursor == nil
end