class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  attr_reader :title, :network, :starting_year, :synopsis, :genre

  def initialize(title, network, starting_year, synopsis, genre)
    @title = title
    @network = network
    @starting_year = starting_year
    @synopsis = synopsis
    @genre = genre
  end

  def self.all
    CSV.readlines('television-shows.csv').map { |tv_show|
      self.new(tv_show[0], tv_show[1], tv_show[2], tv_show[3], tv_show[4])
    }[1..-1]
  end

  def valid?
    !attributes_empty? && !title_already_exists?
  end

  def errors
    errors = []
    errors << "Please fill in all required fields" if attributes_empty?
    errors << "The show has already been added" if title_already_exists?
    errors.empty? ? nil : errors
  end

  def save
    if valid?
      CSV.open('television-shows.csv', 'a') do |file|
        file << [title, network, starting_year, synopsis, genre]
      end
      true
    else
      false
    end
  end

  def attributes_empty?
    title.empty? ||
    network.empty? ||
    starting_year.empty? ||
    synopsis.empty? ||
    genre.empty?
  end

  def title_already_exists?
    CSV
      .readlines('television-shows.csv')
      .map { |tv_show| tv_show[0] }
      .include?(title)
  end


end
