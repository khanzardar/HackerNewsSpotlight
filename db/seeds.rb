# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'httparty'
require 'json'

Story.destroy_all

puts "Calling HackerNews API...\n"
url = 'https://hacker-news.firebaseio.com/v0/topstories.json'

fetch_story_resp = HTTParty.get(url, format: :plain)
body = JSON.parse(fetch_story_resp.body)

top_10_posts = body.first(10)

top_10_posts.each do |post_id|
  # post_id = top_10_posts[index]
  puts "Fetching post: #{post_id}"
  post_data_url = "https://hacker-news.firebaseio.com/v0/item/#{post_id}.json"
  fetch_post_resp = HTTParty.get(post_data_url, format: :plain)
  post = JSON.parse(fetch_post_resp.body)

  puts "post fetch response:\n"
  puts fetch_post_resp
  
  @story = Story.new(by: post['by'], total_comment_count: post['descendants'].to_i, hn_story_id: post['id'], score: post['score'].to_i, time: post['time'], title: post['title'], url: post['url'])

  @story.save

end
