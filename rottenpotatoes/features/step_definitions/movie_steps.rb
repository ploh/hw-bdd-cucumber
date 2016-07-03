Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body).to match /#{e1}.*#{e2}/m
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    field = "ratings[#{rating}]"
    if uncheck
      step "I uncheck \"#{field}\""
    else
      step "I check \"#{field}\""
    end
  end
end

Then /I should see all of the movies/ do
  expect(page.find(:xpath, '//table[./thead/tr[contains(., "Movie Title")]]').all('tbody tr').size).to eq Movie.count
end
