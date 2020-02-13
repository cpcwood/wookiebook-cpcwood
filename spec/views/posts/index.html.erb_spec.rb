require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before(:each) do
    user = User.create!(email: 'test@abc.com', password: 'password')
    assign(:posts, [
             Post.create!(user_id: user.id, post_content: 'test message'),
             Post.create!(user_id: user.id, post_content: 'test message 2')
           ])
  end

  it 'renders a list of posts' do
    render
  end
end