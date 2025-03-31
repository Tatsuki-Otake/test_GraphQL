module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true

    field :post, Types::PostType, null: false

    def resolve(title:, body:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "認証されていません" unless user

      post = Post.create!(title: title, body: body, user_id: user.id)

      { post: post }
    end
  end
end
