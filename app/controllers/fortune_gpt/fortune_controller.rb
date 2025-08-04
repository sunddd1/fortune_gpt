# frozen_string_literal: true

module FortuneGPT
  class FortuneController < ::ApplicationController
    requires_plugin ::FortuneGPT

    def index
      render json: { fortune: "Good luck is coming your way" }
    end
  end
end
