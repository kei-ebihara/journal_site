class ArticlesController < ApplicationController
    def show
      # Itemモデルのfindメソッドを使用して、パラメータの値に一致するidのデータを検索している
      # 取得したデータを@itemというインスタンス変数にセットする
      @article = Article.find(params[:id])
    end

    def index
      @articles = Article.all
    end

    def new
      @article = Article.new
    end  



    def create
      @article = Article.new(article_params)

      # 上の行はインスタンスを作っただけ。saveメソッドで保存しないと、消える。
      if @article.save

      # saveの後にshow(商品詳細ページ)に飛ぶ設定をします。
      # これを設定しないと、プログラムが行き場をなくしてエラーが起きます。
      redirect_to @article, notice: "論文を登録しました。"

      # redirect_to "/items"
      # だとindexページにリダイレクトする
      else
        render :new
      end
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])
      @article.update(article_params)
      redirect_to @article
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
    end
 
    private 
    # params.require(key).permit(filter)
    # key
    #   Strong Parameters を適用したい params の key を指定する。
    # filter
    #   Strong Parameters で許可するカラムを指定する。 
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
