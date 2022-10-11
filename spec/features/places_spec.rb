require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if multiple are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Gurula", id: 2 ), Place.new( name: "Unicafe", id: 3 ) ]
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Gurula"
    expect(page).to have_content "Unicafe"
  end
  it "if none are returned by the API, the page shows no locations found" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Gurula", id: 2 ), Place.new( name: "Unicafe", id: 3 ) ]
    )
    allow(BeermappingApi).to receive(:places_in).with("kampala").and_return(
      []
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return(
      nil
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kampala").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kampala')
    click_button "Search"

    expect(page).to have_content "No locations in kampala"
  end
end