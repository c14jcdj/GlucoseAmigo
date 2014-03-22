require 'spec_helper'

describe SessionsController do
  let(:account_params) do
    {
    username: CoolFaker::Character.name,
    email: Faker::Internet.email,
    password: 'captainarmando',
    password_confirmation: 'captainarmando'
    }
  end

  let!(:account) do
    Account.create(account_params)
  end

  describe 'logging in' do
    context 'the login page' do
      it 'should respond' do
        get :new
        expect(response).to be_ok
      end
    end

    context 'with the right password' do
      it 'should log me in if I have correct info' do
        expect {
          post :create, {
                        username: account.username,
                        password: account.password
                        }
        }.to change {request.session[:user_id]}.to account.id
      end
    end
    context 'with the wrong password' do
      it 'should log me in if I have correct info' do
        expect {
          post :create, {
                        username: account.username,
                        password: 'not the password'
                        }
        }.to_not change {request.session[:user_id]}
      end
    end
  end

  describe 'logging out' do
    it 'should log out when getting on the destroy route' do
      request.session[:user_id] = account.id
      expect {
        delete :destroy, { id: account.id }
      }.to change {request.session[:user_id]}
    end
  end
end