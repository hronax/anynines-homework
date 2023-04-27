require 'active_record'

DB = ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV['DB_NAME'],
  host: ENV['DB_HOST'],
  username: ENV['DB_USER'],
  password: ENV['DB_PASS'],
)

ActiveRecord::Base.connection.create_table(:articles, primary_key: 'id', force: true) do |t|
    t.string :title
    t.string :content
    t.string :created_at
end

ActiveRecord::Base.connection.create_table(:comments, primary_key: 'id', force: true) do |t|
    t.bigint :article_id
    t.string :created_at
    t.text :content
    t.string :author_name
end

require_relative 'article'
require_relative 'comment'

Article.create(title: 'Title ABC', content: 'Lorem Ipsum', created_at: Time.now)
Article.create(title: 'Title ZFX', content: 'Some Blog Post', created_at: Time.now)
Article.create(title: 'Title YNN', content: 'O_O_Y_O_O', created_at: Time.now)

Comment.create(article_id: 1, content: 'Lorem Ipsum 1', created_at: Time.now)
Comment.create(article_id: 1, content: 'Lorem Ipsum 2', created_at: Time.now)
Comment.create(article_id: 1, content: 'Lorem Ipsum 3', created_at: Time.now)
Comment.create(article_id: 2, content: 'Lorem Ipsum 4', created_at: Time.now)
Comment.create(article_id: 2, content: 'Lorem Ipsum 5', created_at: Time.now)

puts "Article count in DB: #{Article.count}"

