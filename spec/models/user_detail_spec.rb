require 'rails_helper'

describe UserDetail do
  let!(:subject) { create(:user_detail) }

  it { is_expected.to belong_to(:user) }
end
