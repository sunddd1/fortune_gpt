# frozen_string_literal: true

module FortuneGPT
  class FortuneController < ::ApplicationController
    requires_plugin ::FortuneGPT
    before_action :ensure_logged_in
    before_action :ensure_fortune_enabled

    def index
      user_fortune = FortuneGPT::UserFortune.find_by(
        user_id: current_user.id,
        picked_on: Date.today,
      )

      render json: { data: serialize_fortune(user_fortune) }, status: 200
    end

    def create
      today = Date.today
      user_fortune = FortuneGPT::UserFortune.find_by(user_id: current_user.id, picked_on: today)

      if user_fortune
        render json: {
                 errors: [
                   {
                     message: I18n.t("fortune_gpt.errors.already_picked", default: "fortune already picked"),
                   },
                 ],
               },
               status: 409
        return
      end

      fortune = FortuneGPT::Fortune.order("RANDOM()").first

      begin
        user_fortune = FortuneGPT::UserFortune.create!(
          user: current_user,
          picked_on: today,
          fortune: fortune,
        )
      rescue ActiveRecord::RecordNotUnique
        user_fortune = FortuneGPT::UserFortune.find_by(user_id: current_user.id, picked_on: today)
        render json: {
                 errors: [
                   {
                     message: I18n.t("fortune_gpt.errors.already_picked", default: "fortune already picked"),
                   },
                 ],
               },
               status: 409
        return
      end

      render json: { data: serialize_fortune(user_fortune) }, status: 201
    end

    private

    def ensure_fortune_enabled
      raise Discourse::NotFound unless SiteSetting.fortune_gpt_enabled
    end

    def serialize_fortune(user_fortune)
      return nil unless user_fortune

      {
        id: user_fortune.id,
        text: user_fortune.fortune.text,
        picked_on: user_fortune.picked_on,
      }
    end
  end
end
