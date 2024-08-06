class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  # GET /articles
  def index
    @articles = Article.order(published_at: :desc)
    render json: @articles
  end

  # GET /articles/:id
  def show
    if @article
      render json: @article
    else
      render json: { error: 'Article not found' }, status: :not_found
    end
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    
    if @article.save
      #byebug
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PUT /articles/:id and # PATCH /articles/:id
  def update
    render json: { error: 'Method not allowed' }, status: :method_not_allowed
  end


  # DELETE /articles/:id
  def destroy
    render json: { error: 'Method not allowed' }, status: :method_not_allowed
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :category, :published_at)
  rescue ActionController::ParameterMissing
    {}
  end
end
