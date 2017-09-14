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
    @movie = Movie.show_all
    erb :'movies/index', :layout => :'/movies'
  end
  
  # Show
  get '/:id' do
    @movie = Movie.find(params['id'])
    erb :'/movies/info', :layout => :'/movies'
  end

  # Edit
  get '/edit/:id' do
    @movie = Movie.find(params['id'])
    erb :'/movies/edit', :layout => :'/movies'
  end

  # Update
  put'/:id' do
    @movie = Movie.new(params[:movie])
    Movie.update(@movie)
    redirect '/'
  end

  # Delete
  delete '/:id' do
  end

end