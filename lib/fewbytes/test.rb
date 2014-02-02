# require 'trollop'
require 'open3'
# # TODO:

# opts = Trollop.options do
#   opt :config, 'Configuration file location', type:  :string, short: '-c'
# end

# puts opts[:config]

# def syscall(*cmd)
#   begin
#     stdout, stderr, status = Open3.capture3(*cmd)
#     status.success? && stdout.slice!(0..-(1 + $/.size)) 
#   end
# end # !> global variable `$INPUT_RECORD_SEPARATOR' not initialized

# puts syscall('ls')

# system('ls -al', out: ['/tmp/log', 'a'], err: ['/tmp/log.err', 'a'])
output = Open3.popen3("ls") { |stdin, stdout, stderr, wait_thr| stdout.read }
p output
