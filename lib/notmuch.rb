module NotMuch 

  class Index
    def initialize(opts={})
      @maildir = "/home/auxesis/mail/inbox"
    end
  
    def search(query)
      output = `notmuch search #{query}`
      output.split("\n").map do |line|
        Message.new(:search => line)
      end
    end

    def show(query)
      output = `notmuch show #{query}`
      Message.new(:show => output)
    end

  end

  class Message 
    attr_reader :subject, :to, :from, :date, :thread_id, :header, :body, :when

    def initialize(opts={})
      @raw_search_result = opts[:search]
      @raw_show_result = opts[:show]

      process_result
    end

    def process_result
      case
      when @raw_search_result
        @subject = @raw_search_result.split(';').last.split('(').first
        @thread_id = @raw_search_result.split.first.split(':').last
        @from = @raw_search_result.split('] ')[1].split(';').first
        @when = @raw_search_result[25..36].strip
      when @raw_show_result 
        lines  = @raw_show_result.split("\n")
        hstart  = lines.index(lines.find {|l| l =~ /header\{/}) + 2
        hfinish = lines.index(lines.find {|l| l =~ /header\}/}) - 1
        @header = lines[hstart..hfinish].join("\n")
        @subject = @header.split("\n").find {|l| l =~ /^Subject:/}.split(':')[1..-1].join(':')
        @from = @header.split("\n").find {|l| l =~ /^From:/}.split(':')[1..-1].join(':')

        bstart = lines.index(lines.find {|l| l =~ /body\{/}) + 2
        bfinish = lines.index(lines.find {|l| l =~ /body\}/}) - 2
        @body = lines[bstart..bfinish].join("\n")
      end
    end

    def short_from
      if @from =~ /@/
        @from.split('@').first
      else
        @from.split.first
      end
    end

  end

end


class String 
  def blank?
    strip.empty?
  end
end

class Object
  def blank?
    nil? || (respond_to?(:empty?) && empty?)
  end
end 

