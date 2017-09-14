require 'active_model'

class Movie
	include ActiveModel::Model

	attr_accessor :id, :title, :year, :rating, :synopsis, :image_url

	def self.db
		binding.pry
		db = SQLite3::Database.new("movies.db")
	end

	# def self.create_table
	# 	binding.pry
	# 	Movie.db.execute<<-SQL
	# 		create table IF NOT EXISTS movies (
	# 			id INTEGER PRIMARY KEY NOT NULL,
	# 			title varchar,
	# 			year varchar,
	# 			rating int,
	# 			synopsis varchar,
	# 			image_url varchar
	# 		);
	# 		SQL
	# end

	def save
		Movie.create_table
		Movie.db.execute("INSERT INTO movies (title, year, rating, synopsis, image_url)
	 						VALUES (?, ?, ?, ?, ?)", [@title, @year, @rating, @synopsis, @image_url])
	end

end
