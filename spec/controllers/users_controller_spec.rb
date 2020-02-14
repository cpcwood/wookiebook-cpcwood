RSpec.describe UsersController, type: :controller do
  describe '#new' do
    it 'redirects to posts page if signed in' do
      get(:new, session: { user: true })
      expect(response).to redirect_to('/posts')
    end
  end

  describe '#create' do
    it 'creates new user and saves to database' do
      expect_any_instance_of(User).to receive(:save!)
      get(:create, params: { user: { email: 'test@email.com', password: 'password' }})
    end

    it 'creates new user in the database and saves to session' do
      get(:create, params: { user: { email: 'test@email.com', password: 'password' }})
      expect(session[:user].id).not_to eq(nil)
      expect(session[:user].email).to eq('test@email.com')
      expect(session[:user].password).not_to eq(nil)
    end
  end
end
