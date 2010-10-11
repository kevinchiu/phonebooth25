require 'test_helper'

class TranscriptsControllerTest < ActionController::TestCase
  setup do
    @transcript = transcripts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transcripts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transcript" do
    assert_difference('Transcript.count') do
      post :create, :transcript => @transcript.attributes
    end

    assert_redirected_to transcript_path(assigns(:transcript))
  end

  test "should show transcript" do
    get :show, :id => @transcript.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @transcript.to_param
    assert_response :success
  end

  test "should update transcript" do
    put :update, :id => @transcript.to_param, :transcript => @transcript.attributes
    assert_redirected_to transcript_path(assigns(:transcript))
  end

  test "should destroy transcript" do
    assert_difference('Transcript.count', -1) do
      delete :destroy, :id => @transcript.to_param
    end

    assert_redirected_to transcripts_path
  end
end
