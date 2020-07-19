# frozen_string_literal: true

class Click < ApplicationRecord
  validates :platform, presence: true
  validates :browser, presence: true
  validates :url_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :url
end
