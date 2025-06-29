require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should have_many(:tags).dependent(:destroy) }

  describe '#full_name' do
    it 'concatenates last and first name' do
      user = build(:user, first_name: 'Jane', last_name: 'Doe')
      expect(user.full_name).to eq 'Doe Jane'
    end
  end

  describe '#welcome_msg' do
    it 'returns a greeting including full name' do
      user = build(:user, first_name: 'Jane', last_name: 'Doe')
      expect(user.welcome_msg).to eq 'Welcome Doe Jane!'
    end
  end
end
