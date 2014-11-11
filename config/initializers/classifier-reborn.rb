ClassifierReborn::Bayes.class_eval do
  def klassify(text)
    # klosest is the classification [name, score] that matches text best
    # score system is 0 .. -x where closer to 0 is a better match
    ranking = classifications(text).sort_by { |a| -a[1] }
    threshold = threshold(ranking.drop(1)) # excluding klosest
    klosest = ranking[0]
    name, score = klosest[0], klosest[1]
    score > threshold ? name : "Not found"
  end

  def threshold(ranking)
    weight = 0.74
    average = ranking.inject(0.0) { |sum, rank| sum + rank[1] } / ranking.size
    average * weight
  end
end