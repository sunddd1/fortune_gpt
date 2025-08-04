# frozen_string_literal: true

module FortuneGPT
  class Fortune < ::ActiveRecord::Base
    self.table_name = 'fortune_gpt_fortunes'

    has_many :user_fortunes,
             class_name: 'FortuneGPT::UserFortune',
             foreign_key: 'fortune_gpt_fortune_id'
  end
end
