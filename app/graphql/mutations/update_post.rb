module Mutations
  class UpdatePost < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :body, String, required: false

    field :post, Types::PostType, null: true
    field :errors, [String], null: false

    def resolve(id:, title: nil, body: nil)
      post = Post.find_by(id: id)
      return { post: nil, errors: ['Post not found'] } unless post

      if post.update(title: title, body: body)
        { post: post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
