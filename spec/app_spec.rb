require File.expand_path '../spec_helper.rb', __FILE__

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  before(:all) do
    @user = User.new
    @user.id = rand(1..10)
    @user.name = 'dima'
    @user.age = '312'
    @user.email = 'test@asf.qwe'
    @user.created_at = Time.now
    @user.updated_at = Time.now
    @user.save

  end

  it 'shows all posts page' do
    get '/posts'
    expect(last_response).to be_ok
  end

  it 'shows the default index page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'shows the create new user page' do
    get '/users/new'
    expect(last_response).to be_ok
  end

  it 'shows the current user page' do
    @user_id = User.all.first.id
    get "/users/#{@user_id}/"
    expect(last_response).to be_ok
  end

  it 'Create user' do
    post '/users/new', {:name => 'adasd', :email => 'qwe@asd.zc', :age => 32}
  end

  it 'Check user' do
    User.find_by(:name => 'adasd') == 'adasd'
  end

  it 'Change user' do
    @user_id = User.find_by(:name => 'adasd').id
    put "/users/#{@user_id}/edit", {:name => 'zxcv', :email => 'qwe@asd.zc', :age => 32}
  end

  it 'Check user' do
    User.find_by(:name => 'zxcv') == 'zxcv'
  end

  it "Shows user's posts" do
    @user = User.find_by(:name => 'zxcv')
    expect(@user.posts.count).not_to eq(0)
  end

  it 'Create new post' do
    @user_id = User.find_by(:name => 'zxcv').id
    post "/users/#{@user_id}/posts/new/", {:title => '2222222222',
                                           :body => '222222222 2222222222 222222222'}
  end

end


