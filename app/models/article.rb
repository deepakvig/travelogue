class Article < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  validates :title, :content, :presence => true

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  attr_writer :tag_names
  after_save :assign_tags
 
  scope :published, where("articles.published_at IS NOT NULL")
  scope :draft, where("articles.published_at IS NULL")
  scope :recent, lambda { published.where("articles.published_at > ?", 1.week.ago.to_date) }
  scope :where_title, lambda { |term| where("articles.title LIKE ?", "%#{term}%") }

  def long_title
    "#{title} - #{published_at}"
  end

  def published?
    published_at.present?
  end

  def tag_names
    @tag_names || tags.map(&:tag_name).join(' ')
  end
 
  private
    def assign_tags
      if @tag_names
        self.tags = @tag_names.split(/\s+/).map do |name|
          Tag.find_or_create_by_tag_name(name)
        end
      end
    end
end
