require 'date'
require 'json'

start_date = ARGV[0] || '2025-01-01'
end_date = ARGV[1] || '2025-01-31'

start_date +=" 00:00:00"
end_date +=" 23:59:59"

config_file = File.open("config.json", "r")
$CONFIG = JSON.parse(config_file.read)
config_file.close

output_folder = ARGV[2] || './output/'
Dir.mkdir(output_folder) unless Dir.exist?(output_folder)
Dir.chdir(output_folder)

ONE_HOUR = 3600

system('clear') || system('cls')

start_date = Date.parse(start_date).strftime('%Y-%m-%d %H:%M:%S')
end_date = Date.parse(end_date).strftime('%Y-%m-%d %H:%M:%S')

#start_date = start_date.to_time + 3600

$CONFIG['zone_list'].each do |zone|
  $CONFIG['params'].each do |param|
    file_name = "#{param['name']}-#{zone}.ts"
    tel_file = File.open(file_name, "w")
      tel_file.puts "export const #{param['name']}_#{zone} = ["
      current_time = DateTime.parse(start_date).to_time
      (0..720).each do
        timestamp = DateTime.strptime((current_time.to_i * 1000).to_s, '%Q').to_time
        value = rand(param['min']..param['max']).round(2)
        tel_file.puts "  {timestamp: '#{timestamp}', value: #{value}},"
        current_time += ONE_HOUR
      end
      tel_file.puts "];"
    tel_file.close
  end
end