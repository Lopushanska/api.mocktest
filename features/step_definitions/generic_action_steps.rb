When (/^I use (GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS) for (.*)$/) do |method, url|
  @stock = case method
           when 'GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'
             get_response(method, url)
           else
             wrong_method_error
           end
end

When(/^I make a REST GET call to "(.*?)"$/) do |page|
  @stock = get_response('GET', page)
end