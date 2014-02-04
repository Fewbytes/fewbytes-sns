#!/usr/bin/env ruby -wU

require 'rubygems'
require 'yaml'
require 'aws-sdk'
require 'open3'
require 'trollop'

opts = Trollop.options do
  opt :command, 'command to run', type: :string, short: '-c'
  # opt :sns,      'output to SNS', multi: true
end

def run_command(command)
  sns = AWS::SNS.new
  topic = 'arn:aws:sns:us-east-1:702076609359:shd_test' # !> global variable `$INPUT_RECORD_SEPARATOR' not initialized
  t = sns.topics[topic]
  start_time = Time.now
  t.publish("#{start_time} of #{command}")
  output = Open3.popen3(command) {|stdin, stdout, stderr, wait_thr| stdout.read}
  t.publish("#{output} of #{command}")
  end_time = Time.now
  t.publish("#{end_time} of #{command}")
  duration = end_time - start_time
  t.publish("#{duration} of #{command}")
  # message = {
  #   'output' => output,
  #   'start_time' => start_time,
  #   'end_time' => end_time,
  #   'duration' => duration,
  #   'command' => command
  # }
end

# def sns_config
# AWS Configuration
## config file location
config_file = File.join(File.dirname(__FILE__), 'config.yml')
fail 'no configuration' unless File.exist?(config_file)

## config to YAML
config = YAML.load(File.read(config_file))
fail 'Wrong YAML format' unless config.kind_of?(Hash)
# end
AWS.config(config)

## load config

# Find the topic by using the topic's arn

# Publish the message to the topic

run_command(opts.command)
#   puts "#{d} == #{s}"
# end
