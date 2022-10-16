# HackerNews Spotlight
- rails db:seed to seed the database prior to startup
- Using ActiveJob to enqueue a recurring hourly fetch
-- rails c
-- FetchHackerNewsDataHourlyJob.perform_now
- rails server --binding=0.0.0.0
