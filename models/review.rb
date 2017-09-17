require 'active_model'

class Review
	include ActiveModel::Model

	attr_accessor :id, :movie_id, :name, :rating, :review

	def self.attributes
		[:id, :movie_id, :name, :rating, :review]
	end

	def self.db
		db = SQLite3::Database.new("db/movies.db")
	end

	def self.create_table
	 	self.db.execute <<-SQL
	 	create table IF NOT EXISTS reviews (
	 	id INTEGER PRIMARY KEY NOT NULL,
	 	movie_id int,
	 	name varchar,
	 	rating int,
	 	review varchar,
	 	FOREIGN KEY(movie_id) REFERENCES movies(id)
	 	);
	 	SQL
	end

	def save(movie_id)
		Review.create_table
		Review.db.execute("INSERT INTO reviews (movie_id, name, rating, review)
							VALUES (?, ?, ?, ?)", [movie_id, @name, @rating, @review ])
	end

	def self.show_all(movie_id)
		results = self.db.execute("SELECT * FROM reviews WHERE movie_id = ?",
								movie_id)
		results.map { |result| Review.new(Hash[attributes.zip(result)])}
	end

	def self.find(id, movie_id)
		results = self.db.execute("SELECT * FROM reviews WHERE id = ? AND movie_id = ?",
								id,	movie_id)
		Review.new(Hash[attributes.zip(results[0])])
	end

	def update
		Review.db.execute("UPDATE reviews SET id = ?, movie_id = ?, name = ?, rating = ?, review = ? WHERE id = ?",
						@id, @movie_id, @name, @rating, @review, @id)
	end

	def self.delete(id)
		Review.db.execute("DELETE FROM reviews WHERE id = ?", id)
	end
end