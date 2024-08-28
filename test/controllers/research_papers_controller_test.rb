require "test_helper"

class ResearchPapersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get research_papers_new_url
    assert_response :success
  end

  test "should get create" do
    get research_papers_create_url
    assert_response :success
  end

  test "should get show" do
    get research_papers_show_url
    assert_response :success
  end
end
