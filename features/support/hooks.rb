Before('@feed_endpoint') do
  @blocks_structure = [{cells: 2}, {cells: 2}, {cells: 2}, {rows: 8}]
end

def attach_to_scenario(json_data, attachment_title)
  file_name = 'data/' + UUID.new.generate + '.json'
  File.open(file_name, 'w+') {|f| f.write json_data.to_json}
  embed file_name, 'application/json', attachment_title
end

def extract_case_tag(scenario)
  (scenario.outline? ? scenario.source[2] : scenario).tags.find {|t| t.name.start_with?('@C')}.name[2..-1]
end

def store_results_for_test_rail(scenario, status)
  results_path = Dir.pwd + '/data/test_results.json'
  results = JSON.parse(File.read(results_path))
  case_id = extract_case_tag(scenario)
  results['results'] << {case_id: case_id, status_id: status}
  File.open(results_path, 'w+') do |f|
    f.print(results.to_json)
  end
  # add_run('S792', 'Automation Test Suite API')
  # add_result_for_case('S792', case_id, status)
end

After do |scenario|
  # if ENV['TEST_RAIL_PASS']
  #   status = scenario.failed? ? 5 : 1
  #   store_results_for_test_rail(scenario, status)
  #   @test_rail = TestRail::APIClient.new
  #   test_run_name = 'Genesis QA EnvRun'
  #   test_run_id = @test_rail.add_run('792', test_run_name)
  #   results = JSON.parse(File.read(Dir.pwd + '/data/test_results.json'))['results']
  #   @test_rail.add_results_for_cases(test_run_id, results)
  # end
  # attach_to_scenario(@request_data, 'Request params')
  # data_to_store = @response_data || json_body
  # attach_to_scenario(data_to_store, 'Response body')
  Capybara.reset_sessions!
end