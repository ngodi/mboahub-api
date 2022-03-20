class MainController < ApplicationController

    def index
        render json: {response: "welcome"}
    end
end