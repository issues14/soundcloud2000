require_relative '../ui/table'

module Soundcloud2000
  module Views
    class TrackView

      def initialize(client, x = 0, y = 0)
        @page = 1
        @client = client
        @tracks = load_tracks(@page)

        @table = initialize_table(x, y)
      end

      def down
        unless @table.down
          @tracks += load_tracks(@page += 1)
          @table.body *tracks

          @table.down
        end
      end

      def up
        @table.up
      end

      def tracks
        @tracks.map { |track| [ track.title, track.user.username, track.duration.to_s ] }
      end

    protected

      def initialize_table(x, y)
        table = UI::Table.new(Curses.lines, Curses.cols, x, y)
        table.header 'Title', 'User', 'Length'
        table.body *tracks

        table
      end

      def load_tracks(page)
        @client.tracks(page)
      end

    end
  end
end