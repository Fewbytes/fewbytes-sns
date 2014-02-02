#!/usr/bin/env ruby

require 'rubygems'
require 'yaml'
require 'aws-sdk'
require 'open3'

output = Open3.popen3("uptime") { |stdin, stdout, stderr, wait_thr| stdout.read }

config_file = File.join(File.dirname(__FILE__), 'config.yml')
# fail 'Not Working' if File.exist?(config_file)

config = YAML.load(File.read(config_file))
# fail 'Wrong YAML format' if config.kind_of?(Hash)
AWS.config(config)
 # !> global variable `$INPUT_RECORD_SEPARATOR' not initialized
# Topic's arn can be found in AWS Management, under Topic Details.
# (topic_arn, message) = ARGV
# unless topic_arn && message
#   fail 'Usage: publish.rb <TOPIC_ARN> <MESSAGE>'
# end

# Get an instance of the SNS interface using the default configuration
sns = AWS::SNS.new

# Find the topic by using the topic's arn
t = sns.topics['arn:aws:sns:us-east-1:702076609359:shd_test']
puts "Now publishing to '#{t.name}' topic the following message:"
puts "\"#{output}\""

# Publish the message to the topic
t.publish(output)

puts "\nMessage published"
# ~> -:13:in `read': No such file or directory @ rb_sysopen - ./config.yml (Errno::ENOENT)
# ~>  from -:13:in `<main>'
