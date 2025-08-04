# frozen_string_literal: true

# name: fortune_gpt
# about: Fortune telling plugin powered by GPT
# version: 0.1
# authors: ChatGPT
# url: https://example.com/fortune_gpt

require_relative "lib/fortune_gpt"

after_initialize do
  ::Discourse::Application.routes.append do
    mount ::FortuneGPT::Engine, at: "/fortune_gpt"
  end
end

