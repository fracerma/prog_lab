require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#admin' do
  let(:acting_admin) { User.create(roles: %w(admin)) }
  subject(:admin_ability) { Ability.new(acting_admin) }

  describe 'on Category' do
    let(:Category) { Category.create }

    it { is_expected.to be_able_to(:read, Category) }
    it { is_expected.to be_able_to(:create, Category) }
    it { is_expected.to be_able_to(:update, Category) }
    it { is_expected.to be_able_to(:destroy, Category) }
  end

=begin
  describe 'on Review' do
    let(:review) { Review.create }

    it { is_expected.to be_able_to(:read, review) }
    it { is_expected.to be_able_to(:create, review) }
    it { is_expected.to be_able_to(:destroy, review) }
  end
=end
end
