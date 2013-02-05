def copy_all_files
  locales.each {|locale| copy_file_from_js_project(locale)}
end

def locales
  Dir["js-cldr-timezones/lib/assets/javascripts/js_cldr/*"].map { |path| path =~ /([\w-]+)_cldr_timezones\.js/ && $1 }
end

def copy_file_from_js_project(locale)
  js_file = read_js_file(locale)
  js_file = modify_first_line_of_file(js_file, locale)
  write_file_to_npm_project(js_file, locale)
end

def read_js_file(locale)
  File.read("js-cldr-timezones/lib/assets/javascripts/js_cldr/#{locale}_cldr_timezones.js")
end

def modify_first_line_of_file(js_file, locale)
  js_file.gsub("var #{locale}_cldr_timezones_hash = {", "var #{locale}_cldr_timezones_hash = exports.#{locale}_cldr_timezones_hash = {")
end

def write_file_to_npm_project(js_file, locale)
  File.open("npm-cldr-timezones/cldr_timezones/#{locale}_cldr_timezones.js", "w") {|target| target << js_file}
end

copy_all_files