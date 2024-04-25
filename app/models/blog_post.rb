class BlogPost < ApplicationRecord
    has_rich_text :content

    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user
    has_many :comments, dependent: :destroy

    scope :sorted, -> { order(published_at: :desc, updated_at: :desc )}
    scope :draft, -> { where(published_at: nil) }
    scope :published, -> { where("published_at <= ?", Time.current) }
    scope :scheduled, -> { where("published_at > ?", Time.current) }
    scope :get_mine, -> (user_id) { where(user_id: user_id) }

    def draft?
        published_at.nil?
    end

    def published?
        published_at? and published_at <= Time.current
    end

    def scheduled?
        published_at? and published_at > Time.current
    end
end
