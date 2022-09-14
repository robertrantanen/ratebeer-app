module RatingAverage
    extend ActiveSupport::Concern
   
    def average_rating 
        return ratings.inject(0.0){ |sum, r| sum + r.score } / ratings.size
    end
end