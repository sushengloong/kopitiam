class Treat < ActiveRecord::Base
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
end
