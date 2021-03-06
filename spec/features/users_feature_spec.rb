require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "must be logged in to create restaurant" do
      visit('/')
      click_link('Add a restaurant')
      expect(page).not_to have_button('Create Restaurant')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end

feature "Once logged in on the website" do
  before do
    first_user = build :first_user
    sign_up(first_user)
  end

  it "can only edit restaurants which they've created" do
    click_link('Add a restaurant')
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    # expect(page).to have_content 'KFC'
    # expect(current_path).to eq '/restaurants'
    click_link('Sign out')
    # expect(current_path).to eq '/'
    second_user = build :second_user
    sign_up(second_user)
    # click_link 'Edit KCF'
    # expect(current_path).to eq '/'
    expect(page).not_to have_content('Edit KFC')
  end

  # it "can only delete restaurants which they've created" do
  #   sign_up_first_user
  #   click_link('Add a restaurant')
  #   fill_in 'Name', with: 'KFC'
  #   click_button 'Create Restaurant'
  #   expect(page).to have_content 'KFC'
  #   expect(current_path).to eq '/restaurants'
  #   click_link('Sign out')
  #   expect(current_path).to eq '/'
  #   sign_up_second_user
  #   click_link 'Delete KFC'
  #   expect(current_path).to eq '/'
  #   expect(page).to have_content 'You are not allowed to delete this restaurant'
  # end

end
