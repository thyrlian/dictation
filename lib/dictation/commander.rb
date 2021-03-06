require 'optparse'

module Dictation
  class Commander
    class << self
      def order(args)
        options = {}
        commands = {
            'new' => OptionParser.new do |opts|
              opts.banner = set_banner('new')

              opts.on('-d', '--dictate TTS', 'Specify two-letters language code for dictation') do |tts|
                options[:dictate] = tts.downcase
              end

              opts.on('-v', '--verify TTS', 'Specify two-letters language code for verification') do |tts|
                options[:verify] = tts.downcase
              end
            end,

            'add' => OptionParser.new do |opts|
              opts.banner = set_banner('add')

              opts.on('-l', '--language LANGUAGE', 'Specify the target language file for adding more words') do |language|
                options[:language] = language
              end
            end,

            'dictate' => OptionParser.new do |opts|
              opts.banner = set_banner('dictate')

              opts.on('-l', '--language LANGUAGE', 'Specify the language for dictation') do |language|
                options[:language] = language
              end

              opts.on('-b', '--begin WORD', 'Begin with given word') do |word|
                options[:word_begin] = word
              end

              opts.on('-e', '--end WORD', 'End with given word') do |word|
                options[:word_end] = word
              end

              opts.on('-s', '--start LINE', Integer, 'Start with given line') do |line|
                options[:line_start] = line
              end

              opts.on('-f', '--finish LINE', Integer, 'Finish with given line') do |line|
                options[:line_finish] = line
              end
            end,

            'verify' => OptionParser.new do |opts|
              opts.banner = set_banner('verify')

              opts.on('-l', '--language LANGUAGE', 'Specify the language for dictation') do |language|
                options[:language] = language
              end

              opts.on('-b', '--begin WORD', 'Begin with given word') do |word|
                options[:word_begin] = word
              end

              opts.on('-e', '--end WORD', 'End with given word') do |word|
                options[:word_end] = word
              end

              opts.on('-s', '--start LINE', Integer, 'Start with given line') do |line|
                options[:line_start] = line
              end

              opts.on('-f', '--finish LINE', Integer, 'Finish with given line') do |line|
                options[:line_finish] = line
              end
            end
        }
        valid_cmds = ['new', 'add', 'dictate', 'verify']
        if valid_cmds.include?(args[0])
          commands[args.shift].order!
          options
        else
          puts "Unknown commands [#{args[0]}], only support #{valid_cmds.inspect}."
        end
      end

      def get_caller_file_name
        caller[-1].match(/\S+\.rb/)
      end

      def set_banner(cmd)
        "Usage: #{get_caller_file_name} #{cmd} [options]"
      end
    end

    private_class_method :new, :get_caller_file_name, :set_banner
  end
end