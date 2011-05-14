dbconfig = {
  :adapter => 'sqlite3',
  :database => ':memory:'
}

ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Migration.verbose = false

class TestMigration < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true
    create_table :comments, :force => true do |t|
      t.references :post
    end
  end

  def self.down
    drop_table :posts
    drop_table :comments
  end
end

class Post < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
end