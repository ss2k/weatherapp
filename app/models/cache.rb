# this is a cache model to cache postal codes already searched for
# ideally this would be in some sort of cache store such as redis
# but for simplicities sake and to show how a model would work
# i used a model instead of a proper cache store
class Cache < ApplicationRecord
  validates :postal, presence: true
  validates :data, presence: true

  scope :updated_within_last, ->(min) { where('updated_at > ?', min.minutes.ago) }
  
  def self.check_for_recent(postal)
    Cache.updated_within_last(30).find_by(postal: postal)
  end

  def self.create_or_update(postal, data)
    Cache.find_or_initialize_by(postal: postal).update_attribute(:data, data)
  end
end
