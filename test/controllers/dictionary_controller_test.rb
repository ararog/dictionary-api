require "test_helper"
require 'faker'

class DictionaryControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can search dictionary" do
    get "/dictionary", params: { q: 'macac'}
    assert_response :success
  end

  test "can add new dictionary entry" do
    word = Faker::Lorem.characters(number: 15)

    post "/dictionary",
      params: { word: word }
    assert_response :success

    get "/dictionary", params: { q: word }
    assert_response :success

    matches = @response.parsed_body
    assert_equal word, matches[0]
  end

  test "can delete existing dictionary entry" do
    word = Faker::Lorem.characters(number: 15)

    post "/dictionary",
      params: { word: word }
    assert_response :success

    word = word
    delete "/dictionary/#{word}"
    assert_response :success

    get "/dictionary", params: { q: word }
    assert_response :success

    matches = @response.parsed_body
    assert_empty matches
  end
end
