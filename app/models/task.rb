class Task < ApplicationRecord
  include PgSearch::Model

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  has_many :interest_tasks
  has_many :interests, through: :interest_tasks, dependent: :destroy
  has_many :user_tasks
  has_many :users, through: :user_tasks

  # app/models/task.rb
class Task < ApplicationRecord
  # Assuming you have a column called image_title in your tasks table
  def unsplash_image_url

    response = HTTParty.get("https://api.unsplash.com/search/photos?query=#{CGI.escape(image_title)}&client_id=YOUR_UNSPLASH_API_KEY")
    if response.code == 200 && !response.parsed_response["results"].empty?
      response.parsed_response["results"][0]["urls"]["regular"]
    else
      # If no image found, return a default image URL or handle it as per your requirement
      'https://example.com/default-image.jpg'
    end
  end
end


  pg_search_scope :global_search,
    against: [:title, :description],
    associated_against: {
      interests: [:title]
    },
    using: {
      tsearch: { prefix: true }
    }
end
