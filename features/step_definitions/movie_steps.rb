# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    #debugger
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rating|
    if uncheck == nil
    #use result of steps in web_steps.rb
      check("ratings_#{rating}") #found by inspecting html
    else
      uncheck("ratings_#{rating}")
    end
  end
end

Given(/^I press 'Refresh'$/) do
  click_button('Refresh')
end

#Then I should see the movies with the ratings: PG, R
Then /I should( not)? see the movies with the (.*)s: (.*)/ do |notsee, filter, list|
  list.split(", ").each do |item|  
    @movies = Movie.where(filter=>item)
    @movies.each do |movie|
      if page.respond_to? :should
        if (notsee == nil) then page.should have_content(movie.title)
        else page.should have_no_content(movie.title) end
      else
        if (notsee == nil) then assert page.has_content?(movie.title)
        else assert page.has_no_content?(movie.title) end
      end
    end
  end
end

Then /I should( not)? see the movies with the previous (.*)s/ do |notsee, filter|
    #session.nil? ? @filters = Movie.all_ratings : @filters = session[:sort]
    #debugger
    @filters = Movie.all_ratings
    step("I should#{notsee} see the movies with the #{filter}s: #{@filters}")
    pending
end
