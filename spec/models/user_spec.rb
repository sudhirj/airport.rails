require 'spec_helper'

describe User do
  it 'should find the last token' do
    user = User.create! name: 'Sudhir', login: 'sudhirj'
    user2 = User.create! name: 'Amrita', login: 'amrita'
    user3 = User.create! name: 'John', login: 'Doe'
    Token.create! token: 't1', user: user
    Token.create! token: 't2', user: user2
    Token.create! token: 't3', user: user

    user.token.should == 't3'
    user2.token.should == 't2'
    user3.token.should == nil
  end
end
