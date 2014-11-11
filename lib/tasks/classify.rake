namespace :classify do
  desc "Trains classifier engine to classify meds"
  task seed_data: :environment do
    madeleine_classifier = SnapshotMadeleine.new("bayes_data") {
      ClassifierReborn::Bayes.new
    }

    type_1 = File.open('lib/assets/diabetes_type_1.txt').read
    type_2 = File.open('lib/assets/diabetes_type_2.txt').read

    madeleine_classifier.system.add_category("Type 1 Diabetes")
    madeleine_classifier.system.add_category("Type 2 Diabetes")

    madeleine_classifier.system.train("Type 1 Diabetes", type_1)
    madeleine_classifier.system.train("Type 2 Diabetes", type_2)

    madeleine_classifier.take_snapshot
  end

end