require 'active_model'

class Movie
	include ActiveModel::Model

	attr_accessor :id, :title, :year, :rating, :synopsis, :image_url

	def self.attributes
		[:id, :title, :year, :rating, :synopsis, :image_url]
	end

	def self.db
		db = SQLite3::Database.new("db/movies.db")
	end

	def self.create_table
		self.db.execute <<-SQL
			create table IF NOT EXISTS movies (
				id INTEGER PRIMARY KEY NOT NULL,
				title varchar,
				year varchar,
				rating int,
				synopsis varchar,
				image_url varchar
			);
			SQL
	end

	def save
		Movie.create_table
		Movie.db.execute("INSERT INTO movies (title, year, rating, synopsis, image_url)
	 						VALUES (?, ?, ?, ?, ?)", [@title, @year, @rating, @synopsis, @image_url])
	end

	def self.show_all
	  results =	self.db.execute("SELECT * FROM movies")
	  results.map { |result| Movie.new(Hash[attributes.zip(result)])}
	end

	def self.find(id)
		results = self.db.execute("SELECT * FROM movies WHERE id = ?",
										id)
		Movie.new(Hash[attributes.zip(results[0])])
	end

	def self.update(object)
		self.db.execute("UPDATE movies SET title = ?,
								 											 year = ?,
																			 rating = ?,
																			 synopsis = ?,
																			 image_url = ?
																			 WHERE id = ?", 
																			 object.title,
																			 object.year,
																			 object.rating,
																			 object.synopsis,
																			 object.image_url,
																			 object.id)

	end

end
