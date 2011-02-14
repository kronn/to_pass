set :major,  1, "Major Enhancements"
# set :general, 0, General Enhancements (or so)
set :bug,   -1, "Bug Fixes"
set :minor, -2, "Minor Enhancements, Refactorings and Cleanups"
set :admin, -3, "Administrative Changes"

on /(Bug|bug|fix |fixed)/ do
  :bug
end

on /move|change|corrected/ do
  :minor
end
on /cleanup|housekeeping|refactor|extract|abstract/ do
  :minor
end

on /(^updated|TODO)/ do
  :admin
end
on /bump|tag|Merge branch/i do
  :admin
end
on /comment|year|github/ do
  :admin
end

# on /^(\w+):/ do |word|
#   word.to_sym
# end
#
# on /\[(\w+)\]\s*$/ do |word|
#   word.to_sym
# end

