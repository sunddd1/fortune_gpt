# frozen_string_literal: true

fortunes = [
  "행운이 가득한 하루가 될 거예요!",
  "오늘은 새로운 도전을 시도해보세요.",
  "반가운 소식을 듣게 될 것입니다.",
  "작은 친절이 큰 기쁨을 가져다줄 거예요.",
  "오랜 친구와의 만남이 즐거움을 선사할 것입니다."
]

fortunes.each do |text|
  FortuneGPT::Fortune.find_or_create_by!(text: text)
end
