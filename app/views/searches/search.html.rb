<h2>Books search for "test"</h2>

<table class="table table-hover table-inverse">
   #検索対象モデルがUserの時
  <% if @range == "User" %>
    <tbody>
      <% @users.each do |user| %>
        <tr>
          <td><%= user.name %></td>
        </tr>
      <% end %>
    </tbody>
  <% else %>
    #検索対象モデルがUserではない時(= 検索対象モデルがBookの時)
    <tbody>
      <% @books.each do |book| %>
        <tr>
          <td><%= book.title %></td>
          <td><%= book.body %></td>
        </tr>
      <% end %>
    </tbody>
  <% end %>
</table>
#searchesコントローラ内で、検索結果を代入したインスタンス変数(@usersと@books)に対し、each文をつかって1つずつ取り出す
