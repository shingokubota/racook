require "rails_helper"

RSpec.describe "ユーザー登録", type: :request do
  before do
    get signup_path
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_success
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーで登録" do
    expect {
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    }.to change(User, :count).by(1)
    redirect_to season_index_path
    follow_redirect!
    # expect(response).to render_template('users/show')
    expect(response).to render_template('seasons/index')
    expect(is_logged_in?).to be_truthy
  end

  it "無効なユーザーで登録" do
    expect {
      post users_path, params: { user: { name: "",
                                         email: "user@example.com",
                                         password: "foobar",
                                         password_confirmation: "barbaz" } }
    }.not_to change(User, :count)
    expect(is_logged_in?).not_to be_truthy
  end
end
