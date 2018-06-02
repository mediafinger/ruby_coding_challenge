# frozen_string_literal: true

require "rails_helper"

RSpec.describe Task, type: :model do
  subject(:task) { build(:task) }

  it { expect(task.valid?).to eq(true) }
end
