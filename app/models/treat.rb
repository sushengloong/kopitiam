class Treat < ActiveRecord::Base
  after_create :refresh_topic_treat_score

  belongs_to :user
  belongs_to :topic

  class TreatName
    KOPI = 'kopi'
    KOPI_O = 'kopi-o'
    TEH = 'teh'
    TEH_O = 'teh-o'
    MILO = 'milo'
    BARLEY = 'barley'
    BEER = 'beer'
  end

  private

  def refresh_topic_treat_score
    topic.treat_score += value
    topic.save
  end
end
