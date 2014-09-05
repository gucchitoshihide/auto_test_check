require 'rails_helper'

RSpec.describe SkillProfilesController, :type => :controller do
  # must optimize
  before do
    [:article_prof_a, :article_prof_b, :article_prof_c].each do |article|
      eval "@#{article.to_s} = create(article)"
    end
    [:profile_a, :profile_b, :profile_c].each do |profile|
      eval "@#{profile.to_s} = create(profile)"
    end
  end

  describe 'GET #index' do
    context 'record exists' do
      before do
        get :index, nil, {id: 1}
      end
      it { expect(assigns(:profiles).size).to eq(3) }
    end
  end

  describe 'PUT #search' do
    context 'found record because article includes the search word' do
      before do
        params = {search: 'f'}
        put :search, {search: params[:search]}, {id: 1}
      end
      it { expect(assigns(:profiles).size).to eq(1) }
    end

    context 'not found record because of unreasonable' do
      before do
        params = {search: 'qwytnbnb'}
        put :search, {search: params[:search]}, {id: 1}
      end
      it { expect(assigns(:profiles).size).to eq(0) }
    end
  end
end
