# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do

    it { should belong_to(:url) }
    it { should validate_presence_of(:platform) }
    it { should validate_presence_of(:browser) }
    it { should validate_presence_of(:url_id) }
    it { should validate_numericality_of(:url_id).only_integer }
    it { should validate_numericality_of(:url_id).is_greater_than(0) }
  end
end
