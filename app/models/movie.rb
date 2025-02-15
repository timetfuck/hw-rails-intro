class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true

  def self.filter_and_sort(sort_column: 'title', sort_direction: 'asc', filters: {})
    movies = Movie.all

    filters.each do |key, value|
      movies = movies.where(key => value) if value.present?
    end

    valid_columns = ['title', 'release_date', 'rating']
    if valid_columns.include?(sort_column) && ['asc', 'desc'].include?(sort_direction)
      movies = movies.order("#{sort_column} #{sort_direction}")
    end

    movies
  end

  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil?
      all
    else
      where(rating: ratings_list)
    end
  end

  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
end
