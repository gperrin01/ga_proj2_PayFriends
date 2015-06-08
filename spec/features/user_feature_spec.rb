requuire 'rails_helper'

describe 'on the homepage' do 

  it 'a user can add a friend fromm the homepage' do 
    visit '/'
    click_link "Add friend"
    fill_in "Name" with 'Johny'
    click_button "Create friend"
    
    # expect the dropdown menu with list of all friends to show Johny 
  end

end