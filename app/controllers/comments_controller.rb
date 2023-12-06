class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_consultation, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params.merge(consultation: @consultation))
    if @comment.save
      redirect_to consultation_path(@consultation), notice: 'コメントを投稿しました。'
    else
      redirect_to consultation_path(@consultation), alert: 'コメントの投稿に失敗しました。'
    end
  end

  # 他のアクション...

  private

  def set_consultation
    @consultation = Consultation.find(params[:consultation_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
