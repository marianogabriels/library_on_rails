require 'rails_helper'

RSpec.describe "API::V1::Books", type: :request do
  let!(:books) { FactoryBot.create_list(:book, 10) }
  let(:book_id) { books.first.id }
  let(:valid_attributes) { { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', genre: 'Fiction', isbn: '9780743273565', total_copies: 3 } }

  describe "GET /api/v1/books" do
    before { get '/api/v1/books' }

    it 'returns books' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/books/:id" do
    before { get "/api/v1/books/#{book_id}" }

    context 'when the record exists' do
      it 'returns the book' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(book_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:book_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  describe "POST /api/v1/books" do
    context 'when the request is valid' do
      before { post '/api/v1/books', params: { book: valid_attributes } }

      it 'creates a book' do
        json = JSON.parse(response.body)
        expect(json['title']).to eq('The Great Gatsby')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "DELETE /api/v1/books/:id" do
    before { delete "/api/v1/books/#{book_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'deletes the book' do
      expect(Book.find_by(id: book_id)).to be_nil
    end
  end
end
