require 'rubygems'
require 'yaml'
require 'aws-sdk'

#require File.expand_path(File.dirname(__FILE__) + '/../samples_config')


config_file = File.join(File.dirname(__FILE__), "config.yml")
unless File.exist?(config_file)
  puts <<END
To run the samples, put your credentials in config.yml as follows:

access_key_id: YOUR_ACCESS_KEY_ID
secret_access_key: YOUR_SECRET_ACCESS_KEY

END
  exit 1
end

config = YAML.load(File.read(config_file))

unless config.kind_of?(Hash)
  puts <<END
config.yml is formatted incorrectly.  Please use the following format:

access_key_id: YOUR_ACCESS_KEY_ID
secret_access_key: YOUR_SECRET_ACCESS_KEY

END
  exit 1
end

AWS.config(config)


# Topic's arn can be found in AWS Management, under Topic Details.
(topic_arn, message) = ARGV
unless topic_arn && message
  puts "Usage: publish.rb <TOPIC_ARN> <MESSAGE>"
  exit 1
end

# Get an instance of the SNS interface using the default configuration
sns = AWS::SNS.new

# Find the topic by using the topic's arn
t = sns.topics[topic_arn]
puts "Now publishing to '#{t.name}' topic the following message:"
puts "\"#{message}\""

# Publish the message to the topic
t.publish(message)

puts "\nMessage published"

