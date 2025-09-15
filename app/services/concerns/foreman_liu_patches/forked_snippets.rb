# frozen_string_literal: true

module ForemanLiuPatches
  module ForkedSnippets
    # Always render LiU-forked snippets, but allow rendering upstream/original snippet as well
    def snippet(name, options = {}, variables: {})
      unless options.delete :only_upstream
        forked = source.find_snippet("LiU #{name}")

        return super("LiU #{name}", options, variables: variables) if forked
      end

      super
    end
  end
end
