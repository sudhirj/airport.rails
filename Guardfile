
guard :shell do
  watch(/^app\/assets\/javascripts\/(.*)\.(js|coffee|scss|html)/) do |parts|
    `cd app/assets/javascripts && make` unless (parts[0].start_with?('app/assets/javascripts/airport.js') || parts[0].start_with?('app/assets/javascripts/app/templates.js'))
  end

  watch(/^app\/assets\/javascripts\/(.*)\.(coffee)/) do |parts|        
      `cd app/assets/javascripts && make test` 
  end
end
