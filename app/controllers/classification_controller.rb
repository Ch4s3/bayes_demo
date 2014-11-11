class ClassificationController < ApplicationController
  def train
    category = params["category"]
    words = params["words"]
    bayes = SnapshotMadeleine.new('bayes_data') { ClassifierReborn::Bayes.new }
    current_categories = bayes.system.categories
    if category.in?(current_categories)
      bayes.system.train(category, words)
    else
      bayes.system.add_category(category)
      bayes.system.train(category, words)
    end
    bayes.take_snapshot
    flash['success'] = "You just trained #{category}! Wow!"
    redirect_to root_path
  end

  def classify
    respond_to do |format|
      words = params['words']
      bayes = SnapshotMadeleine.new('bayes_data') { ClassifierReborn::Bayes.new }
      @classification = bayes.system.klassify(words)

      format.js
    end
  end

  def index
    bayes = SnapshotMadeleine.new('bayes_data') { ClassifierReborn::Bayes.new }
    @categories = bayes.system.categories
  end
end
