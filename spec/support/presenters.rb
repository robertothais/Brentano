class TestPresenter < Brentano::Presenter

  self.sizes = {
    :large => 4
  }

  def relation
    subject.comments
  end

end

module CustomFinisher

  def finish
    super do |with|
      with.absolute_limit = false
      with.allowed_scopes = [ :by_rank ]
    end
  end

end