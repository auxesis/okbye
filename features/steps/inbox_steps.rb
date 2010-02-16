Then /^I should see a list of messages$/ do
  doc = Nokogiri::HTML(response_body)
  doc.search("tr").size.should > 0
end

When /^I follow the first thread$/ do
  doc = Nokogiri::HTML(response_body)
  link = doc.search("tr a").first["id"]

  click_link(link)
end

Then /^I should see an email$/ do
  doc = Nokogiri::HTML(response_body)
  doc.search("pre#header").size.should > 0
  doc.search("pre#body").size.should > 0

end

