SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'rails'
require 'active_record'
require 'active_support/core_ext'

require 'brentano'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

  config.before(:all) do
    TestMigration.up
    post = Post.new
    50.times { post.comments << Comment.new }
    post.save
  end

  config.after(:all) do
    TestMigration.down
  end

end