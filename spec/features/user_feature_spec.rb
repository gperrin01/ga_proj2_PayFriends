require 'rails_helper'

describe 'on the homepage' do 

  let(:user) {User.create name: 'Gui'}


  it 'a user can add a friend' do 
    visit '/'
    binding.pry
    fill_in "name", :with => 'Johny'
    click_button "New friend"
    
    # expect the dropdown menu with list of all friends to show Johny 
  end

end