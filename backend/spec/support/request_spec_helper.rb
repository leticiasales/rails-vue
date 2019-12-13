module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def auth_headers(user_id)
    token = ApplicationHelper.encode(user_id: @user.id)
    {
        'Authorization': "Bearer #{token}"
    }
  end
end