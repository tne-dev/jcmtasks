require 'rails_helper'

RSpec.describe TaggedTask, type: :model do
  it { should belong_to(:task) }
  it { should belong_to(:tag) }
end
