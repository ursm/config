# conding: utf-8

require 'uri'
require 'launchy'

module Termtter::Plugins
  class OpenURL
    class << self
      def exec_proc
        proc {|arg| run(arg) }
      end

      def run(arg)
        Thread.new(arg) do |arg|
          if id = Termtter::Client.typable_id_to_data(arg)
            extract_and_open_uri(Termtter::API.twitter.show(id).text)
          else
            case arg
            when /^@(\w+)/
              user = $1
              statuses = Termtter::API.twitter.user_timeline(user)

              return if statuses.empty?

              extract_and_open_uri(statuses.first.text)
            when /^\d+/
              extract_and_open_uri(Termtter::API.twitter.show(arg).text)
            end
          end
        end
      end

      def extract_and_open_uri(str)
        URI.extract(str, %w(http https)) do |uri|
          Launchy.open(uri)
        end
      end
    end
  end
end

Termtter::Client.register_command(
  :name      => :open_url2,
  :help      => ['open_url2 (TYPABLE|ID|@USER)', 'Open url'],
  :exec_proc => Termtter::Plugins::OpenURL.exec_proc
)
