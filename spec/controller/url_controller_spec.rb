require 'rails_helper'

RSpec.describe UrlsController, type: :controller do

  describe "GET #show" do
    before :each do
      @url = create(:url, original_url: "google.com")
      @url.sanitize
      @url.save
    end
    it "assigns the requested url to @url" do
      get :show, params: { short_url: @url.short_url }
      expect(assigns(:url)).to eq @url
    end
    it "redirects to the sanitized url" do
      get :show, params: { short_url: @url.short_url }
      expect(response).to redirect_to(@url.sanitized_url)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      context "with a new url" do
        it "creates a new url entry" do
          expect{
            post :create, params: { url: attributes_for(:url) }
          }.to change(Url, :count).by(1)
        end
      end

    context "invalid attributes" do
      it "does not create a new url entry" do
        expect{
          post :create, params: { url: attributes_for(:url, original_url: nil) }
        }.to_not change(Url, :count)
      end
      it "renders the :index template" do
        post :create, params: { url: attributes_for(:url, original_url: nil) }
        expect(response).to render_template :index
      end
    end
  end
end