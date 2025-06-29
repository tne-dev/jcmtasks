require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:position).only_integer.is_greater_than(0) }

  describe 'callbacks' do
    it 'assigns default position on create' do
      user = create(:user)
      create(:project, user: user, position: 3)
      new_proj = create(:project, user: user)
      expect(new_proj.position).to eq 4
    end
  end

  describe '.search_for_title' do
    it 'finds projects by case-insensitive title' do
      proj = create(:project, title: 'Tasks')
      expect(Project.search_for_title('ask')).to include(proj)
    end
  end
end
