require 'rspec/autorun'
require 'dotenv'
require_relative '../app/controllers/comments'

describe CommentController do
  let(:controller) { CommentController.new }

  before(:all) do
    require_relative '../config/environment'
    require_relative '../app/models/db_init' # initializes the database schema; uses ENV credentials
  end

  it 'gets all comments for article' do
    result = controller.get_batch(1)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(3)
  end

  it 'adds a test comment to db' do
    comment = { 'content' => 'This comment was created in a unit test' }
    result = controller.create_comment(3, comment)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:obj)
    expect(result[:obj]).to be_truthy
  end

  it 'updates the test comment in db' do
    comment = { 'title' => 'Test Comment', 'content' => 'The comment was updated using Rspec' }
    result = controller.update_comment(4, comment)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:obj)
    expect(result[:obj]).to be_truthy
    expect(result[:obj].id).to eq(4)
  end

  it 'tries to update a non-existent comment in db' do
    comment = { 'title' => 'Non Existent Comment', 'content' => 'The comment was updated using Rspec' }
    result = controller.update_comment(99, comment)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key (:msg)
  end

  it 'deletes the test comment from db' do
    result = controller.delete_comment(4)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:delete_count)
    expect(result[:delete_count]).to eq(1)
  end

  it 'tries to delete a non-existent comment' do
    result = controller.delete_comment(99)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
  end
end
