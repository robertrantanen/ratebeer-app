class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating 
        return ratings.inject(0.0){ |sum, r| sum + r.score } / ratings.size
        #sum=0
        #ratings.each do |rating|
        #    sum = sum + rating.score.to_f
        #end
        #return sum / ratings.size
    end
end
