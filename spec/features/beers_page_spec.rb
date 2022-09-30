require 'rails_helper'


describe "Beers" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

  it "new beer is created with proper name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'test_brew')
    select('Weizen', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content 'test_brew'
  end
  it "new beer is not created with empty name" do
    visit new_beer_path
    select('Weizen', from: 'beer[style]')
    select('Koff', from: 'beer[brewery_id]')

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(page).to have_content 'Name can\'t be blank'
  end
end