require 'rails_helper'

RSpec.describe Cache, type: :model do
  context 'validations' do
    it 'needs a postal' do
      cache = Cache.new(data: {})

      expect(cache).not_to be_valid
    end
  end

  describe '#create_or_update' do
    it 'creates a new cache if it doesnt exist' do
      postal = '12345'
      data = { 'min' => 40 }

      Cache.create_or_update(postal, data)

      expect(Cache.last.postal).to eq postal
      expect(Cache.last.data).to eq data
    end

    it 'updates existing cache if it does exist' do
      postal = '10001'
      data = { 'max' => 32 }

      c = Cache.create!(postal: postal, data: data)

      new_data = { 'max' => 45}

      Cache.create_or_update(postal, new_data)

      expect(c.reload.data).to eq new_data
    end
  end

  describe '#check_for_recent' do
    let(:cache) { Cache.create!(postal: '10101', data: {'max' => 45}) }
    
    it 'returns a cache if it was within last 30 minutes' do
      cache.updated_at = Time.now
      cache.save!
      
      expect(Cache.check_for_recent('10101')).to eq cache
    end

    it 'wont return cache if it was not within last 30 minutes' do
      cache.updated_at = 1.hour.ago
      cache.save!

      expect(Cache.check_for_recent('10101')).to be_nil
    end
  end
end