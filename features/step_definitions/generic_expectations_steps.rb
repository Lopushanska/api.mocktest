Then (/^I see response code (\d+)$/) do |response_code|
  expect(@stock.code).to eq response_code
end

Then (/^I see 200 response code$/) do
  expect(@stock.code).to eq 200
end

Then(/^The response code should be (.*?)$/) do |res_code|
  expect(@stock.code).to eq res_code.to_i
end