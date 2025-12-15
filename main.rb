require 'date'
require 'json'
require_relative 'tools'

#Configure program

start_date = (ARGV[0] || '2025-01-01') + " 00:00:00"
end_date = (ARGV[1] || '2025-01-31') + " 23:59:59"

ONE_HOUR = 3600

config_file = File.open("config.json", "r")
$CONFIG = JSON.parse(config_file.read)
config_file.close

system('clear') || system('cls')

#---------------------------------------------------------------------------------------------
# Create output folder if it doesn't exist
output_folder = ARGV[2] || './output/'
Dir.mkdir(output_folder) unless Dir.exist?(output_folder)
Dir.chdir(output_folder)

# Clear output folder if it exists
clear_output = true
if (clear_output)
  if Dir.exist?(output_folder)
    Dir.foreach(output_folder) do |file|
      next if file == '.' || file == '..'
      File.delete(File.join(output_folder, file))
    end
  end
end

start_date = Date.parse(start_date).strftime('%Y-%m-%d %H:%M:%S')
end_date = Date.parse(end_date).strftime('%Y-%m-%d %H:%M:%S')

#current_date = DateTime.parse(DateTime.now.to_s).strftime('%A').to_i

$CONFIG['zone_list'].each do |zone|
  puts "Generating telemetry for zone: #{zone['name']} (Type: #{zone['type']})"
  set_model zone['type']
  next if $zone_data_model.nil?
  $CONFIG['params'].each do |param|
    file_name = "#{param['name']}-#{zone['name']}.ts"
    tel_file = File.open(file_name, "w")
      tel_file.puts "export const #{param['name']}_#{zone['name']} = ["

      current_time = DateTime.parse(start_date).to_time
      (0..720).each do
        day = current_time.strftime('%A').to_i + 1
        hour = current_time.strftime('%H').to_i

        

        timestamp = DateTime.strptime((current_time.to_i * 1000).to_s, '%Q').to_time
        value = rand(param['min']..param['max']).round(2)
        tel_file.puts "  {timestamp: '#{timestamp}', value: #{value}},"
        current_time += ONE_HOUR
      end
      tel_file.puts "];"
    tel_file.close
  end
end