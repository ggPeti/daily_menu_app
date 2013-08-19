require 'spec_helper'

describe DailyMenuApp do
  describe 'VERSION' do
    it 'should not be nil' do
      expect(described_class::VERSION).to_not be_nil
    end
  end
end
