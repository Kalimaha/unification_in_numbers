require 'csv'

# Import budget data.
csv_text = File.read('public/csv/budget.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Budget.create!(row.to_hash)
end

# Import population data.
csv_text = File.read('public/csv/population.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Population.create!(row.to_hash)
end

# Import tax data.
csv_text = File.read('public/csv/taxes.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Tax.create!(row.to_hash)
end