MovieGrabber::App.controllers :movies do
  
  # Create
  post :create do
    @movie = Movie.new(params[:movie])
    @movie.save
    redirect url_for(:movies, :index)
  end

  # New
  get :new do
    @movie = Movie.new
    erb :'movies/new', :layout => :'/movies'
  end

  # Index
  get :index do
    @movie = Movie.show_all
    erb :'movies/index', :layout => :'/movies'
  end
  
  # Show
  get :index, with: :id do
    search_results = Movie.find_with_reviews(params['id'])
    @movie = search_results[0]
    @reviews = search_results[1]
    erb :'/movies/info', :layout => :'/movies'
  end

  # Edit
  get :edit, with: :id do
    @movie = Movie.find(params['id'])
    erb :'/movies/edit', :layout => :'/movies'
  end

  # Update
  put :edit, with: :id do
    @movie = Movie.new(params[:movie])
    Movie.update(params['id'], @movie)
    redirect url_for(:movies, :index, :id => params['id'])
  end

  # Confirm Delete
  get :delete, with: :id do
    @movie = Movie.find(params['id'])
    erb :'/movies/delete', :layout => :'/movies'
  end

  # Delete
  delete :delete, with: :id do
    Movie.delete(params['id'])
    redirect url_for(:movies, :index)
  end

end