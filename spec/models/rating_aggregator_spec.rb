# frozen_string_literal: true

require "rails_helper"

RSpec.describe RatingAggregator, type: :model do
  subject(:rating_aggregator) { build(:rating_aggregator) }

  it { expect(rating_aggregator.valid?).to eq(true) }
end
