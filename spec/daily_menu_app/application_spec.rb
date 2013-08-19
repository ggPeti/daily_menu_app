require 'spec_helper'
require 'rack/test'
require 'time'

describe DailyMenuApp::Application do
  include Rack::Test::Methods

  def app
    described_class
  end

  describe '/menus/' do
    let(:location) { '/menus/Foo/Bar' }

    context 'when no location found' do
      it 'should respond with an error' do
         get(location)

         expect(last_response).to_not be_ok
         expect(last_response.status).to eq(404)
      end
    end

    context 'when there is a configuration for the location' do
      context 'when no menus could be fetched' do
        before do
          DailyMenu.stub(:menus_for) { [] }
        end

        it 'should respond an empty JSON object' do
          get(location)

          expect(last_response).to be_ok
          expect(last_response.content_type).to match(/application\/json/)
          expect(last_response.body).to eq('{}')
        end
      end

      context 'when menus could be fetched' do
        let(:restaurant_name) { 'Example Restaurant' }
        let(:restaurant) { double('Restaurant', name: restaurant_name) }
        let(:time) { DateTime.now }
        let(:entry) { double('Entry', content: 'Menu', time: time) }

        before do
          DailyMenu.stub(:menus_for) { [[restaurant, entry]] }
        end

        it 'should respond with a JSON object' do
          get(location)

          expect(last_response).to be_ok
          expect(last_response.content_type).to match(/application\/json/)
          response = JSON.parse(last_response.body)

          expect(response).to have_key(restaurant_name)
          expect(response[restaurant_name]).to have_key('menu')
          expect(response[restaurant_name]).to have_key('date')
        end
      end
    end
  end

end
