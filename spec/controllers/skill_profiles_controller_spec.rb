require 'rails_helper'

RSpec.describe SkillProfilesController, :type => :controller do
  before do
    [:article, :skill_profile, :user].each do |factory_fixture|
      binding.pry
      FactoryGirl.create(factory_fixture)
    end
  end

  describe 'GET #index' do
    context 'with session' do
      before { login }
      #  get :index, nil, {id: 1}
      it { expect(assigns(:profiles).size).to eq(1) }
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
