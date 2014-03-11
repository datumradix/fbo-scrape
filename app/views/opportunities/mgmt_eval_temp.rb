<div class="radio">
    <%= form_for(@management_evaluation) do |f| %>
      <% if @management_evaluation.errors.any? %>
        <div id="error_explanation">
          <h2><%= pluralize(@management_evaluation.errors.count, "error") %> prohibited this management_evaluation from being saved:</h2>
          <ul>
          <% @management_evaluation.errors.full_messages.each do |msg| %>
            <li><%= msg %></li>
          <% end %>
          </ul>
        </div>
      <% end %>
      <div class="radio">
        <%= f.radio_button(:evaluation, "Watchlist") %>
        <%= f.label :evaluation, "Watchlist" %>
        <%= f.radio_button(:evaluation, "Red Team Evaluate") %>
        <%= f.label :evaluation, "Red Team Evaluate" %>
        <%= f.radio_button(:evaluation, "Escalate") %>
        <%= f.label :evaluation, "Escalate" %>
        <%= f.radio_button(:evaluation, "Pass") %>
        <%= f.label :evaluation, "Pass" %>
        <%= f.hidden_field :opportunity_id, value: @opportunity.id %><br>
        <%= f.submit  "Submit", :class => "btn btn-default"%>
      </div>
    <% end %>
    </div>