require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "is redirected back to signin form if wrong credentials given" do
        sign_in(username: "Pekka", password: "wrong")
  
        expect(current_path).to eq(signin_path)
        expect(page).to have_content 'Username and/or password mismatch'
    end
    it "can see own ratings on user page" do
        user = User.first
        create_beers_with_many_ratings({user: user}, 10, 20)
        user2 = FactoryBot.create(:user, username: "Vilma")
        create_beers_with_many_ratings({user: user2}, 30, 40)
        sign_in(username: "Pekka", password: "Foobar1")
        visit user_path(user)
        expect(page).to have_content 'User has done 2 ratings with average of 15.0'
    end
    # it "can delete rating" do
    #     user = User.first
    #     create_beer_with_rating({user: user}, 10)
    #     visit user_path(user)
    #     expect(Rating.count).to eq(1)
    #     expect(page).to have_content 'User has done 1 rating with average of 10.0'
    #     click_link('Delete')
    #     expect(Rating.count).to eq(0)
    #     expect(page).to have_content 'User doesn\'t have any ratings!'
    # end

  end
  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')
  
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end

