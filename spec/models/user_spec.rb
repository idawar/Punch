require 'rails_helper'
RSpec.describe User, type: :model do
  it { should have_many(:project_users).dependent(:destroy) }
  it { should have_many(:projects) }
  it { should have_many(:products) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role) }
  it { should validate_uniqueness_of(:email) }
end