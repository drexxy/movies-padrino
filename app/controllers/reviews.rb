MovieGrabber::App.controllers :reviews, :parent => :movies do

  get :new do
    @movie = Movie.find(params['movie_id'])
    @review = Review.new
    erb :'reviews/new', :layout => :'/movies'
  end

  post :create do
    @review  = Review.new(params[:review])
    @review.save(params['movie_id'])
    redirect :index
  end

  get :index do
    @movie = Movie.find(params['movie_id'])
    @review = Review.show_all(params['movie_id'])
    erb :'reviews/index', :layout => :'/movies'
  end

  get :index, with: :id do
    @movie = Movie.find(params['movie_id'])
    @review = Review.find(params['id'], params['movie_id'])
    erb :'reviews/info', :layout => :'/movies'
  end

  get :edit, with: :id do
    @movie = Movie.find(params['movie_id'])
    @review = Review.find(params['id'], params['movie_id'])
    erb :'reviews/edit', :layout => :'/movies'
  end

  put :edit, with: :id do
    @review = Review.new(params[:review])
    @review.update
    redirect :index
  end

  get :delete, with: :id do

  end

  delete :id do

  end
  
  

end
