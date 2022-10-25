require 'rails_helper'


describe "Beers" do
  before :each do
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) { FactoryBot.create :style, name: "Weizen" }

  it "new beer is created with proper name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'test_brew')
    select('Weizen', from: 'beer[style_id]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
      click_button "Create beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content 'test_brew'
  end
  it "new beer is not created with empty name" do
    visit new_beer_path
    select('Weizen', from: 'beer[style_id]')
    select('Koff', from: 'beer[brewery_id]')

    click_button "Create beer"

    expect(Beer.count).to eq(0)
    expect(page).to have_content 'Name can\'t be blank'
  end
end