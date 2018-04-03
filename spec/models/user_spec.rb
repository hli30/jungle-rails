require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    it 'should create user if password and confirmation match' do 
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'testEmail',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      expect(user.save).to be_truthy
    end

    it 'should fail creating user if password and confirmation mismatch' do
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'testEmail',
        password: 'asdf', 
        password_confirmation: 'fdsa'
      })
      user.valid?
      expect(user.errors.full_messages).to contain_exactly("Password confirmation doesn't match Password")
    end

    it 'should have unique and case insensitive emails' do
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'email',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user2 = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'EMAIL',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user.save

      user2.valid?
      expect(user2.errors[:email]).to contain_exactly("has already been taken")
    end

    it 'should have a first_name' do
      user = User.new({
        first_name: nil,
        last_name: 'testLast',
        email: 'email',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user.valid?
      expect(user.errors[:first_name]).to contain_exactly("can't be blank")
    end

    it 'should have a last_name' do
      user = User.new({
        first_name: 'testFirst',
        last_name: nil,
        email: 'email',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user.valid?
      expect(user.errors[:last_name]).to contain_exactly("can't be blank")
    end

    it 'should have a email' do 
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: nil,
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user.valid?
      expect(user.errors[:email]).to contain_exactly("can't be blank")
    end

    it 'should have a password with minmum length 4' do 
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'testEmail',
        password: 'asd', 
        password_confirmation: 'asd'
      })
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should return a user if credentials are correct' do
      user = User.new({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'testEmail',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })
      user.save
      expect(User.authenticate_with_credentials('', '')).to be_nil
      expect(User.authenticate_with_credentials('testEmail', '')).to be_nil
      expect(User.authenticate_with_credentials('testEmail', 'asdf')).to eql(user)
    end

    it 'should pass if user email has extra whitespaces' do
      user = User.create({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'testEmail',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })

      expect(User.authenticate_with_credentials('  t  estEmail  ', 'asdf')).to eql(user)
    end
    
    it 'should pass if user email has uppercased letters' do
      user = User.create({
        first_name: 'testFirst',
        last_name: 'testLast',
        email: 'teStEmAIL',
        password: 'asdf', 
        password_confirmation: 'asdf'
      })

      expect(User.authenticate_with_credentials('TESTEMAIL', 'asdf')).to eql(user)
    end


  end


end
