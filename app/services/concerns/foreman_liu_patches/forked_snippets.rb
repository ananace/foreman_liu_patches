# frozen_string_literal: true

module ForemanLiuPatches
  module ForkedSnippets
    # Always render LiU-forked snippets, but allow rendering upstream/original snippet as well
    def snippet(name, options = {}, variables: {})
      use_upstream = options.delete(:only_upstream) || options.delete(:use_upstream)

      # If the snipped called into itself
      if !use_upstream && request.env[:rendered_from_fork] == name
        Foreman::Logging.logger('app').warn("Snippet 'LiU #{name}' called into itself, falling back to upstream instead of overflowing stack")
        use_upstream = true
      end

      return super if use_upstream

      forked = source.find_snippet("LiU #{name}")
      return super unless forked

      request.env[:rendered_from_fork] = name
      return super("LiU #{name}", options, variables: variables)
    end
  end
end
