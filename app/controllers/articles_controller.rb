require 'kramdown'

class ArticlesController < ApplicationController
  before_filter :authorize
  before_action :find_article, only: [:show, :edit, :destroy, :update]
  def _form

  end

  def edit
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    @html = Kramdown::Document.new(@article.content).to_html
    redirect_to article_path(@article)
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def show
    @html = Kramdown::Document.new(@article.content).to_html
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    # *Strong params*: You need to *whitelist* what
    # can be updated by the user
    # Never trust user data!
    params.require(:article).permit(:title, :content)
  end
end
