json.extract! comment, :id, :user_id, :recipe_id, :message, :created_at, :updated_at
json.url recipe_comment_url(comment, format: :json)
