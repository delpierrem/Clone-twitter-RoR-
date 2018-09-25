require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @baseTitle = "Ruby on Rails"
  end

  test "should get accueil" do
    get root_url
    assert_response :success
    assert_select "title" , "Accueil | #{@baseTitle}"
  end

  test "should get contact" do
    get pages_contact_url
    assert_response :success
    assert_select "title" , "contact | #{@baseTitle}"
  end

  test "should get team" do
    get pages_team_url
    assert_response :success
    assert_select "title" , "team | #{@baseTitle}"
  end

  test "should get services" do
    get pages_services_url
    assert_response :success
    assert_select "title" , "services | #{@baseTitle}"
  end

end
