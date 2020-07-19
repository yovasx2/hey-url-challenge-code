# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  validates :original_url, presence: true, format: URI.regexp(%w[http https]), uniqueness: true
  validates :short_url, presence: true, format: /\A[a-zA-Z0-9]{1,5}\z/, uniqueness: true

  has_many :clicks

  def shorten(length = 5)
    loop do
      self.short_url = SecureRandom.alphanumeric(length)
      break self.short_url unless Url.where(short_url: self.short_url).exists?
    end
  end
end
