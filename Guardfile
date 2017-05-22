require 'colored'
require 'open3'

clearing :on

guard :shell do
  watch(/(.*).swift$/) {|m|
    puts "Running tests..."

    output = ""
    errors = ""
    exit_status = Open3.popen3("swift test") do |stdin, stdout, stderr, wait_thread|
      stdin.close
      output << stdout.read
      errors << stderr.read
      wait_thread.value
    end

    puts output.yellow

    if exit_status.success?
      puts errors.cyan
      puts "✅  Passed ".green
    else
      puts errors.yellow
      puts "💥  Failed".red
    end
  }
end
