class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    params[:comment][:feature_id] = params[:feature_id]
    @comment = Comment.new(comment_params)
    @comment.save
    # Configurando los encabezados de respuesta
    response.headers['Content-Type'] = 'application/json'
    # se verifica si hay errores en la creacion del comentario y se envia un mensaje de error o de exito
    if @comment.errors.any?
      render json: {status: 'ERROR', message: 'Comment not saved', data: @comment.errors}, status: :unprocessable_entity
    else
    render json: {status: 'SUCCESS', message: 'Saved comment', data: @comment}, status: :ok
    end
  end

  def index
    @comments = Comment.where(feature_id: params[:feature_id])
    # Configurando los encabezados de respuesta
    response.headers['Content-Type'] = 'application/json'
    if @comments.empty?
      render json: {status: 'ERROR', message: 'No comments found', data: []}, status: :not_found
    else
      render json: {status: 'SUCCESS', message: 'Loaded comments', data: @comments}, status: :ok
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :feature_id)
  end


end
