#!/usr/bin/ruby

# full path to named stats file
namedStatsFile = "/Users/fzurell/TEMP/ganglia-add-ons/named.stats"

metrics_array = [
  "queries resulted in successful answer",
  "queries resulted in authoritative answer",
  "queries resulted in non authoritative answer",
  "queries resulted in nxrrset",
  "queries caused recursion"]

def get_file_as_string(filename,ms)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    ms.each { |m|
        if Regexp.compile(".*" + m + ".*").match(line)
          metric = line.chomp.split("\s",2)
          # puts "Metric: " + metric[1] + " => " + metric[0]
          puts "gmetric -u 'req/sec' -tuint16 -n 'BIND9 " + m + "' -v " + metric[0]
        end
      }
    
  end
  return data
end


puts get_file_as_string(namedStatsFile,metrics_array)