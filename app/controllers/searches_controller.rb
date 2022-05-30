class SearchesController < ApplicationController

  def search
    @range = params[:range] #検索モデル

    if @range == "User" #検索モデルUserかBookで条件分岐
      @users = User.looks(params[:search], params[:word]) #検索方法[search]検索ワード[word]
    else　#looksメソッドを使い、検索内容を（searchとwordで）取得し、検索結果を変数に代入する
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
