class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]


  def index
    @blogs = Blog.all     #一覧表示（初期表示)
#    binding.pry          #Debug mode
#    raise                #Debug mode
  end
  
  def new                 #新規登録画面表示
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new    #form自動生成のためにインスタンス生成
    end

  end
  
  def show                #詳細画面表示(レコード番号指定)
    @blog = Blog.find(params[:id])
  end
  
  def create              #新規登録アクション（POST）
    @blog = Blog.new(blog_params) #モデルの作成(newアクションに引き渡す)
    if @blog.save         #モデルの登録
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'        #新規登録画面を表示（パラメータを引き継ぐ）
    end
  end
  
  def edit                #編集画面表示
  #  @blog = Blog.find(params[:id])
  end
  
  def update              #更新アクション(POST)
  #  @blog = Blog.find(params[:id]) #モデルの作成(updateアクションに引き渡す)
    if @blog.update(blog_params)   #モデルの登録
      # 一覧画面へ遷移して"ブログを更新しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      # 入力フォームを再描画します。
      render 'edit'        #編集画面を表示（パラメータを引き継ぐ）
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  def destroy           #削除画面表示
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"  
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  # idをキーとして値を取得するメソッド
  def set_blog
    @blog = Blog.find(params[:id])
  end
    
    
end
