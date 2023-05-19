require 'rails_helper'

RSpec.describe 'v1/houses', type: :request do
  describe 'v1/houses' do
    context 'when houses are available' do
      it 'returns all houses' do
        get v1_houses_url

        expect(response).to be_successful
      end
    end
  end
end
