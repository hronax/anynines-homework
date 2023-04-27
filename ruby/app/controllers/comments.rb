class CommentController
  def create_comment(article_id, comment)
    new_comment = Comment.new(article_id: article_id, content: comment['content'], created_at: Time.now)
    new_comment.save

    { ok: true, obj: comment }
  rescue StandardError
    { ok: false }
  end

  def update_comment(id, new_data)
    comment = Comment.find_by(id: id)

    return { ok: false, msg: 'Comment could not be found' } if comment.nil?

    comment.content = new_data['content']
    comment.save

    { ok: true, obj: comment }
  rescue StandardError
    { ok: false }
  end

  def delete_comment(id)
    delete_count = Comment.delete(id)

    if delete_count == 0
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  end

  def get_batch(article_id)
    res = Comment.where(article_id: article_id)

    if !res.empty?
      { ok: true, data: res }
    else
      { ok: false, msg: 'Comments not found' }
    end
  rescue StandardError
    { ok: false }
  end
end
