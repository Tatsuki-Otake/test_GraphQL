module Mutations
  class DeletePost < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(id:)
      post = Post.find_by(id: id)
      return { success: false, errors: ['Post not found'] } unless post

      if post.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: post.errors.full_messages }
      end
    end
  end
end
