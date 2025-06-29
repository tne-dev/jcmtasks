require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:project).optional }
  it { should have_one_attached(:file) }
  it { should validate_presence_of(:title) }
  it { should allow_values(true, false).for(:is_done) }

  describe '#status?' do
    it 'returns "Complete" when done' do
      task = create(:task, is_done: true)
      expect(task.status?).to eq 'Complete'
    end

    it 'returns "Incomplete" when not done' do
      task = create(:task, is_done: false)
      expect(task.status?).to eq 'Incomplete'
    end
  end

  describe 'scopes' do
    let!(:done_task) { create(:task, title: 'Done', is_done: true) }
    let!(:undone_task) { create(:task, title: 'Todo', is_done: false) }

    it 'searches by title' do
      expect(Task.search_for_title('do')).to match_array([done_task, undone_task])
    end

    it 'filters by status' do
      expect(Task.filter_per_status(true)).to eq [done_task]
    end
  end

  describe '.all_statuses' do
    it 'returns all distinct statuses for a user' do
      user = create(:user)
      create(:task, user: user, is_done: true)
      create(:task, user: user, is_done: false)
      expect(Task.all_statuses(user)).to contain_exactly( ['Completed', true], ['Incomplete', false] )
    end
  end

  describe 'ActiveStorage attachments' do
    it 'has one attached :file' do
      reflection = Task.reflect_on_attachment(:file)
      expect(reflection.macro).to eq :has_one_attached
    end
  end
end
