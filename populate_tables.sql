INSERT INTO tasks (task, description) VALUES ("Secure Craft service","Find food vendor to serve organic menu, w vegan and vegetarian friendly options")





<!--<form action="/new_task" method="post">
  <ul>
  <li>Task:
    <select name="Task">
      <%# @tasks.each do |task| %>
        <option value="<%= #task["id"] %>"
            <%=# task["task"] %>
        </option>
      <% #end %>
    </select>
  </li>

  <li> Description:
    <select name= "Description">
      <%# @tasks.each do |task| %>
        <option value="<%=# description["id"] %>"
          <%= #take["description"] %>
        </option>
        <% end %>
    </select>
  </li>


  <li>Description: <input type="text" name="description"></li>
  <li>Person: <input type="text" name="person_id"</li>
  <li>Movie: <input type="text" name="movie_id"</li>

</form>