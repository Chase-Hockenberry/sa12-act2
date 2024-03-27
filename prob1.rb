require 'httparty'
require 'json'

class Repo
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize(username)
    @username = username
  end

  def get_repos
    response = self.class.get("/users/#{@username}/repos")
    JSON.parse(response.body)
  end

  def most_starred_repo
    repos = get_repos

    most_starred = repos.max_by { |repo| repo['stargazers_count'] }
    {
      name: most_starred['name'],
      description: most_starred['description'],
      stars: most_starred['stargazers_count'],
      url: most_starred['html_url']
    }
  end
end

username = 'Chase-Hockenberry'
github_repo = Repo.new(username)
most_starred_repo = github_repo.most_starred_repo

puts "Name: #{most_starred_repo[:name]}"
puts "Description: #{most_starred_repo[:description]}"
puts "Stars: #{most_starred_repo[:stars]}"
puts "URL: #{most_starred_repo[:url]}"
