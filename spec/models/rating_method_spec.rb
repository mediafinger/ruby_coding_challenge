# frozen_string_literal: true

require "rails_helper"

RSpec.describe RatingMethod, type: :model do
  subject(:rating_method) { build(:rating_method) }

  it { expect(rating_method.valid?).to eq(true) }
end
