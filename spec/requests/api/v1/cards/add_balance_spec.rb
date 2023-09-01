# frozen_string_literal: true

RSpec.describe 'Api::V1::Cards' do
  describe 'POST /api/v1/cards/:id/add_balance' do
    subject { post add_balance_api_v1_card_path(card), params: valid_params, as: :json }

    let!(:card) { create(:card, balance: 100.0) }
    let(:valid_params) { { amount: 50.0 } }

    context 'with valid amount' do
      it "updates the card's balance and returns success message" do
        expect { subject }.to change { card.reload.balance }.by(50.0)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({ 'balance' => '150.0', 'message' => 'Balance added successfully' })
      end
    end

    context 'with invalid amount' do
      let(:valid_params) { { amount: 'abc' } }

      it "does not update the card's balance and returns an error message" do
        expect { subject }.not_to change { card.reload.balance }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to eq({ 'error' => 'Amount must be greater than 0' })
      end
    end
  end
end
