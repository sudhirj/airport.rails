class HomeController < ApplicationController
  def index
  end

  def login
    github_config = Airail::Application.config.github
    github = Github.new client_id: github_config[:client_id], client_secret: github_config[:secret]

    unless params[:code]
      scopes = ['user']
      scopes << (params[:private] ? 'repo': 'public_repo')
      return redirect_to(github.authorize_url redirect_uri: login_url, :scope => scopes) unless params[:code]
    end

    token = github.get_token(params[:code]).token
    gh_user = Github.new(oauth_token: token).users.get
    user = User.find_or_create_by_id(gh_user.id, login: gh_user.login, name: gh_user.name)
    Token.create!(token: token, user: user) unless user.token == token
    redirect_to root_url
  end
end
