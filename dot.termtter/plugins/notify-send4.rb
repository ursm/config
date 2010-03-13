# coding: utf-8

require 'cgi'
require 'fileutils'
require 'forwardable'
require 'uri'

require 'RMagick'

module Termtter::Plugins
  class NotifySend
    extend Forwardable

    def self.plugin_config
      config.plugins.notify_send
    end

    plugin_config.set_default :icon_cache_dir, File.join(Termtter::CONF_DIR, 'tmp', 'user_profile_images')
    plugin_config.set_default :icon_size, 32
    plugin_config.set_default :display_sec, 10

    def self.exec_proc
      proc {|statuses, event|
        new(Termtter::Client.logger).run(statuses, event)
      }
    end

    def initialize(logger)
      @logger = logger
    end

    def_delegators 'self.class', :plugin_config

    def run(statuses, event)
      return unless event == :update_friends_timeline

      Thread.start do
        statuses.each do |s|
          begin
            notify_send s.text, s.user
          rescue Exception => e
            @logger.error e
          end
        end
      end
    end

    def notify_send(text, user)
      for_me = /@#{config.user_name}(?:[\s:]|$)/ =~ text

      system(
        'notify-send',
        '--icon',        icon_path(user.screen_name, user.profile_image_url),
        '--urgency',     for_me ? 'critical' : 'normal',
        '--expire-time', (for_me ? 0 : plugin_config.display_sec * 1000).to_s,
        user.screen_name,
        CGI.escapeHTML(text).gsub(URI.regexp(%w(http https)), '<a href="\0">\0</a>')
      )
    end

    def icon_path(user_name, image_uri)
      cache_dir = plugin_config.icon_cache_dir

      path_prefix = File.join(cache_dir, user_name + '-')
      path = path_prefix + image_uri.split('/')[-2] + File.extname(image_uri)

      unless File.exist?(path)
        FileUtils.mkdir_p cache_dir
        FileUtils.rm Dir.glob(path_prefix + '*')

        File.open(path, 'wb') do |f|
          f << fetch_icon(image_uri)
        end
      end

      path
    end

    def fetch_icon(image_uri)
      http = Net::HTTP::Proxy(*config.proxy.__values__.values_at(:host, :port, :user_name, :password))
      uri = URI.parse(URI.escape(image_uri))
      image = http.get(uri.host, uri.path, uri.port)
      size = plugin_config.icon_size

      Magick::Image.from_blob(image).first.resize_to_fill(size, size).to_blob
    end
  end
end

Termtter::Client.register_hook(
  :name      => :notify_send4,
  :points    => [:output],
  :exec_proc => Termtter::Plugins::NotifySend.exec_proc
)
