require_relative '../controllers/comments'

class CommentRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @comments_controller = CommentController.new
  end

  before do
    content_type :json
  end

  get('/:article_id/comments') do
    summary = @comments_controller.get_batch(params[:article_id])

    if summary[:ok]
      { comments: summary[:data] }.to_json
    else
      { msg: 'Could not get comments.' }.to_json
    end
  end

  post('/:article_id/comments') do
    payload = JSON.parse(request.body.read)
    summary = @comments_controller.create_comment(payload, params[:article_id])

    if summary[:ok]
      { msg: 'Comment created' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:article_id/comments/:id') do
    payload = JSON.parse(request.body.read)
    summary = @comments_controller.update_comment(params['id'], payload)

    if summary[:ok]
      { msg: 'Comment updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:article_id/comments/:id') do
    summary = @comments_controller.delete_comment(params['id'])

    if summary[:ok]
      { msg: 'Comment deleted' }.to_json
    else
      { msg: 'Comment does not exist' }.to_json
    end
  end
end
