class PlacesController < ApplicationController
  def show
    @place = $places.select { |p| p['id'] == params[:id].to_s }[0]
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherApi.get_weather_in(params[:city])
    $places = @places
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end
end
