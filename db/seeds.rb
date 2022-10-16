require 'httparty'
require 'json'

def fetch_comments_by_story_id(story_id, parent_id, _parent_kids)
  puts 'inside fetch comments'
  puts "story id: #{story_id}, parent id: #{parent_id}, len of kids: #{_parent_kids.length}"
  _parent_kids.each do |k|
    url = "https://hacker-news.firebaseio.com/v0/item/#{k}.json?print=pretty"
    fetched_data = HTTParty.get(url).parsed_response
    # puts "story_id #{story_id.to_i}, parent_id: #{parent_id}, kids: #{fetched_data['kids']}"
    @comment = Comment.new(story_id: story_id.to_i, parent_id: parent_id, text: fetched_data['text'], by: fetched_data['by'], time: fetched_data['time'])
    @comment.save

    next unless fetched_data['kids'] && fetched_data['kids'].length > 0

    fetch_comments_by_story_id(story_id.to_i, @comment.id, fetched_data['kids'])
  end
end

def fetch_top10_hackernews_stories
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

    fetch_comments_by_story_id(@story.id, nil, post['kids']) if post['kids'] && post['kids'].length > 0
  end
end

Comment.destroy_all
Story.destroy_all

begin
  puts "\nCalling HackerNews API...\n"
  fetch_top10_hackernews_stories
  puts '\nFinished fetching data from HackerNews\n'
rescue Exception => e
  puts "Failed: fetching HackerNews data: #{e}"
end
