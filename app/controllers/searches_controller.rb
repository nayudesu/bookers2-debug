class SearchesController < ApplicationController
  before_action :authenticate_user! #全てのアクションの前に、ユーザーがログインしているかどうか確認する

  def search
    @range = params[:range] #検索モデル
    @search = params[:search]
    @word =  params[:word]
    
    if @range == 'User' #検索モデルUserかBookで条件分岐
      @records = User.looks(@search, @word) #検索方法[search]検索ワード[word]
    else #search_forメソッドを使い、検索内容を（searchとwordで）取得し、検索変数に代入する
      @records = Book.looks(@search, @word)
    end
      
  end
end
