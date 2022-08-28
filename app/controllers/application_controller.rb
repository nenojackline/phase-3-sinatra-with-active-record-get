class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data

    game = Game.all.order(:price)
    game.to_json
  end

  get '/games/:id' do
    # get a single game from the database
    # return a JSON response with the game data
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end
end
