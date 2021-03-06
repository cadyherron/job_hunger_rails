require 'rails_helper'

RSpec.describe Lead, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:lead) { build(:lead) }

  it 'is valid with default attributes' do
    expect(lead).to be_valid
  end

  it 'is not valid without name' do
    lead.name = nil
    expect(lead).to_not be_valid
  end

  it 'is not valid without company_id' do
    lead.company_id = nil
    expect(lead).to_not be_valid
  end

  it 'after_create callback creates Activity' do
    expect { lead.save }.to change { Activity.count }.by 2
  end

  describe Lead do
    it { should belong_to(:company) }
    it { should have_many(:recommendations) }
    it { should have_one(:user) }
    it { should validate_length_of(:name) }
    it { should validate_presence_of(:company_id) }
  end
end
