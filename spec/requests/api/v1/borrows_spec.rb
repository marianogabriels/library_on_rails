require 'rails_helper'

RSpec.describe "API::V1::Borrows", type: :request do
  let!(:users) { FactoryBot.create_list(:user, 2) }
  let!(:books) { FactoryBot.create_list(:book, 2) }
  let!(:borrow1) { FactoryBot.create(:borrow, user: users.first, book: books.first) }
  let!(:borrow2) { FactoryBot.create(:borrow, user: users.last, book: books.last) }
  let(:borrow_id) { borrow1.id }
  let(:valid_attributes) { { borrow: { user_id: users.first.id, book_id: books.last.id, due_at: 2.weeks.from_now } } }

  describe "GET /api/v1/borrows" do
    before { get '/api/v1/borrows' }

    it 'returns borrows' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/borrows/:id" do
    before { get "/api/v1/borrows/#{borrow_id}" }

    context 'when the record exists' do
      it 'returns the borrow' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(borrow_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:borrow_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Borrow/)
      end
    end
  end

  describe "POST /api/v1/borrows" do
    context 'when the request is valid' do
      before { post '/api/v1/borrows', params: valid_attributes }

      it 'creates a borrow' do
        json = JSON.parse(response.body)
        expect(json['user_id']).to eq(users.first.id)
        expect(json['book_id']).to eq(books.last.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "PATCH /api/v1/borrows/:id/mark_as_returned" do
    before { patch "/api/v1/borrows/#{borrow_id}/mark_as_returned" }

    it 'marks the borrow as returned' do
      json = JSON.parse(response.body)
      expect(json['returned_at']).not_to be_nil
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /api/v1/borrows/:id" do
    before { delete "/api/v1/borrows/#{borrow_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'deletes the borrow' do
      expect(Borrow.find_by(id: borrow_id)).to be_nil
    end
  end
end
