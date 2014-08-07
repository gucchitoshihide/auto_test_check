require 'rails_helper'

RSpec.describe WeekReportsController, :type => :controller do

  let(:valid_attributes) {
    {
     report_id: 1,
     title:     'a',
     content:   'a',
    }
  }

  let(:invalid_attributes) {
    {
     report_id: 1,
     title:     'a' * 256,
     content:   'a' * 256,
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    context 'valid params and session' do
      before do
        get :index
      end
      it { expect(response).to render_template(:index) }
    end
  end

  describe "GET new" do
    context 'valid params and session' do
      before do
        get :new
      end
      it { expect(response).to render_template(:new) }
    end
  end

  describe "GET show" do
    context 'valid params and session' do
      before do
        get :show, id: valid_attributes[:report_id]
      end
      it { expect(response).to render_template(:show) }
    end
  end

  describe "POST create" do
    context 'valid params and session' do
      before do
        post :create, {report: valid_attributes}
      end
      it { expect(response).to redirect_to(week_reports_url) }
    end

    context 'invalid params and valid session' do
      before do
        post :create, {report: invalid_attributes}
      end
      it { expect(request.flash[:alert] ).to be_present }
      it { expect(response).to render_template(:new) }
    end
  end

end
