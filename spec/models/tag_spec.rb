require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:tasks).through(:tagged_tasks) }
  it { should validate_presence_of(:title) }

  describe '.search_for_title' do
    it 'finds tags by title case-insensitive' do
      tag = create(:tag, title: 'Urgent')
      expect(Tag.search_for_title('urge')).to include(tag)
    end
  end
end
