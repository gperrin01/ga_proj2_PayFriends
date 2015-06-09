require 'rails_helper'

describe 'on the homepage' do 

  it 'a user can add a friend' do 
    visit '/'
    fill_in "user_name", :with => 'Johny'
    click_button "New friend"
    
    # expect the dropdown menu with list of all friends to show Johny 
  end

end