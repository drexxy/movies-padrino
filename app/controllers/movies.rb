MovieGrabber::App.controllers :movies do
  
  # Create
  post '/' do
    @movie = Movie.new(params[:movie])
    @movie.save
    redirect '/'
  end

  # New
  get '/new' do
    @movie = Movie.new
    erb :'movies/new', :layout => :'/movies'
  end

  # Index
  get '/' do
  end
  
  # Show
  get '/:id' do
  end

  # Edit
  get '/edit/:id' do
  end

  # Update
  put'/:id' do
  end

  # Delete
  delete '/:id' do
  end

end