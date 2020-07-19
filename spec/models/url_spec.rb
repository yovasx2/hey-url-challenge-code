# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { should have_many(:clicks) }
    it { should validate_presence_of(:original_url) }
    it { should validate_presence_of(:short_url) }
    it { should allow_value('http://foo.com').for(:original_url) }
    it { should_not allow_value('htt://bar.com').for(:original_url) }
    it { should allow_value('Q1W2e').for(:short_url) }
    it { should_not allow_value('!@@!#@#').for(:short_url) }
  end
end
