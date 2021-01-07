class Beverage < ActiveRecord::Base
    belongs_to :mixer
    belongs_to :alcohol
    belongs_to :tab
end