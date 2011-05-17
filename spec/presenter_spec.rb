require File.join(File.dirname(__FILE__), 'spec_helper')

describe TestPresenter do

  before { @subject = Post.first }

  describe ".new" do

    it "sets the subject instance variable" do
      presenter = TestPresenter.new @subject
      presenter.subject.should == @subject
    end

    context "when options are passed" do
      before do
        @options   = { :limit => 10 }
        @presenter = TestPresenter.new @subject, @options
      end

      it "sets the options instance variable" do
        @presenter.options.with_indifferent_access.should == @options.with_indifferent_access
      end

      it "makes the options into a Hashie Mash" do
        @presenter.options.should be_a(Hashie::Mash)
      end

    end

    it "calls #finish" do
      TestPresenter.any_instance.should_receive(:finish)
      TestPresenter.new @subject
    end

    context "when a block is given" do
      out = nil
      it "yields self to the block" do
        presenter = TestPresenter.new @subject do |obj|
          out = obj
        end
        presenter.should equal(out)
      end
    end
  end

  describe "#finish" do
    before { @presenter = TestPresenter.new @subject }
    specify { @presenter.collection.should be }
  end

  describe "#maximum_size=" do
    before { @presenter = TestPresenter.new @subject }

    context "when the size is a Fixnum" do
      before do
        @size = 3
        @presenter.maximum_size = @size
      end

      it "sets the maximum size instance variable to the size" do
        @presenter.maximum_size.should eql(@size)
      end

      it "sets the limit option to the size" do
        @presenter.options.limit.should eql(@size)
      end
    end

    context "when the size is not a Fixnum" do
      before do
        @size = size = 4
        @presenter.class_eval do
          self.sizes = { :large => size }
        end
        @presenter.maximum_size = :large
      end

      it "sets the corresponding size" do
        @presenter.maximum_size.should eql(@size)
      end
    end
  end

  describe "#respond_to?" do
    before { @presenter = TestPresenter.new @subject }

    context "given the presenter responds to the method" do
      before { @presenter.stub(:foo) { "ok" } }
      specify { @presenter.respond_to?(:foo).should be_true }
    end

    context "given the presenter does not respond to the method" do
      before { @presenter.stub(:proxy_respond_to?) { |method| false } }

      context "and the collection responds to the method" do
        specify { @presenter.respond_to?(:find).should be_true }
      end

      context "and the collection does not respond to the method" do
        before { @presenter.collection.stub(:respond_to?) { |method| false } }
        specify { @presenter.respond_to?(:foo).should be_false }
      end
    end
  end

  describe "#method_missing" do
    before do
      @presenter = TestPresenter.new @subject
    end

    context "given the collection responds to the method" do

      context "and the method returns an ActiveRecord::Relation" do
        before do
          @presenter.maximum_size = 2
          @presenter.instance_variable_set :@options, :awesome => true
          @method = [:limit, 1]
          @result =  @presenter.method_missing(*@method)
        end
        subject { @result }

        describe "the result" do
          specify { should be_a_kind_of Brentano::Presenter }

          it "should have the same maximum size as receiver" do
            @presenter.maximum_size.should eql(@result.maximum_size)
          end

          it "should have the same options as the receiver" do
            @presenter.options.should eql(@result.options)
          end

          it "should have the collection set to the returned ActiveRecord::Relation" do
            # Use #to_sql to compare the same method on the presenters collection
            @result.collection.to_sql.should eql(@presenter.collection.send(*@method).to_sql)
          end
        end
      end

      context "and the method does not return an ActiveRecord::Relation" do
        describe "the result" do
          it "should be the same as if the method was sent to the collection directly" do
            @presenter.method_missing(:to_a).should eql(@presenter.collection.to_a)
          end
        end
      end
    end
  end

  describe "#as_json" do
    before { @presenter = TestPresenter.new @subject }
    it "delegates to the collection" do
      @presenter.as_json.should eql(@presenter.collection.as_json)
    end
  end

  describe "#to_sql" do
    before { @presenter = TestPresenter.new @subject }
    it "delegates to the collection" do
      @presenter.to_sql.should eql(@presenter.collection.to_sql)
    end
  end

end