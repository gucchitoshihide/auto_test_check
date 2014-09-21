require 'rails_helper'

RSpec.describe SkillProfilesController, :type => :controller do
  before { FactoryGirl.create(:user) }

  describe 'GET #index' do
    subject do
      get(:index)
      response
    end

    context 'with session' do
      before do
        login_at(:index)
        @size_skill_profile = SkillProfile.all.size
      end
      it { expect(assigns(:profiles)).not_to be_nil }
      it { expect(assigns(:profiles)[0]).to be_a(SkillProfile)}
    end

    context 'without session' do
      it { expect(assigns(:profiles)).to be_nil }
    end
  end

#  describe 'PUT #search' do
#    context 'found record because article includes the search word' do
#      before do
#        params = {search: 'f'}
#        put :search, {search: params[:search]}, {id: 1}
#      end
#      it { expect(assigns(:profiles).size).to eq(1) }
#    end
#
#    context 'not found record because of unreasonable' do
#      before do
#        params = {search: 'qwytnbnb'}
#        put :search, {search: params[:search]}, {id: 1}
#      end
#      it { expect(assigns(:profiles).size).to eq(0) }
#    end
#  end
end
