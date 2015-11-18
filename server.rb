require 'sinatra'
require 'csv'
require_relative "app/models/television_show"
require 'pry'

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  @shows = TelevisionShow.all
  erb :index
end

get '/television_shows/new' do
  erb :new
end

# [title, network, starting_year, synopsis, genre]

post '/television_shows' do
  title = params['title']
  network = params['network']
  starting_year = params['starting_year']
  synopsis = params['synopsis']
  genre = params['Genre']
# binding.pry
  show = TelevisionShow.new(title, network, starting_year, synopsis, genre)
# binding.pry
  if show.save
    redirect '/television_shows'
  else
    @errors = show.errors
    erb :new
  end
end
