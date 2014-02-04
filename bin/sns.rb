#!/usr/bin/env ruby -wU

require 'rubygems'
require 'yaml'
require 'aws-sdk'
require 'open3'
require 'trollop'
require 'json'

opts = Trollop.options do
  opt :execute, 'command to run',           short: '-e'
  opt :config,  'config file location',     short: '-c'
  opt :topic,   'SNS topic',                short: '-t'
end

def get_output(command)
  Open3.popen3(command) { |stdin, stdout, stderr, wait_thr| stdout.read }
end

def send_to_sns(topic ,msg)
  sns = AWS::SNS.new
  sns.topics[topic].publish(msg)
end

def aws_config(file)
  fail 'wrong location' unless File.exist?(file)
  config = YAML.load(File.read(file))
  fail 'Wrong YAML format' unless config.kind_of?(Hash)
  AWS.config(config)
end

def duration(block)
  {
    'start' => Time.new,
    'output' =>  block.call,
    'stop' => Time.new
  }
end

block = -> do
  aws_config(opts.config)
  get_output(opts.execute)
end

send_to_sns(opts.topic, duration(block).to_json )
