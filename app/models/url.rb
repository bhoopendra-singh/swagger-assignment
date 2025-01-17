class Url < ApplicationRecord
  validates :long_url, presence: true, format: URI::regexp(%w[http https])

  before_create :generate_short_url

  private

  def generate_short_url
    self.short_url = loop do
      token = SecureRandom.alphanumeric(6)
      break token unless Url.exists?(short_url: token)
    end
  end

end
