class ApplicationController < Sinatra::Base
     # Add this line to set the Content-Type header for all responses
 set :default_content_type, 'application/json'

  get '/games' do
  
     games = Game.all.order(:title).limit(10)
  # return a JSON response with an array of all the game data
     games.to_json
  end


  get '/games/:id' do
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
