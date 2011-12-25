class Comment < ActiveRecord::Base
  belongs_to :article

  validates :content, :presence => true
  validates :email, :presence => true, :length => { :within => 5..50 },
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validate :article_should_be_published

  def article_should_be_published
    errors.add(:article_id, "is not published yet") if article && !article.published?
  end

end
