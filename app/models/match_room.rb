class MatchRoom < ApplicationRecord
    has_many :letters 
    has_many :inbox_records
    #has_one :last_letter, -> { order(created_at: :desc).limit(1) }, source: :letters

    # 最後の
    def last_letter
        self.letters.order(created_at: :desc).first
    end
end
