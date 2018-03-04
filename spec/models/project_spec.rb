require 'rails_helper'
RSpec.describe Project, type: :model do
  it { should belong_to(:client) }
  it { should have_many(:project_users).dependent(:destroy) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
end