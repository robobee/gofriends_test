require 'rails_helper'

describe ReservationsController do

  let(:reservation) { create(:reservation) }

  describe 'GET #show' do

    it 'assigns the requested reservation to @reservation' do
      get :show, id: reservation
      expect(assigns(:reservation)).to eq reservation
    end

    it 'renders the :show template' do
      get :show, id: reservation
      expect(response).to render_template :show
    end

  end

  describe 'GET #index' do

    it 'populates array of all reservations' do
      one = create(:reservation, table_number: 1)
      two = create(:reservation, table_number: 2)

      get :index
      expect(assigns(:reservations)).to match_array([one, two])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #new' do

    it 'assigns a new reservation to @reservation' do
      get :new
      expect(assigns(:reservation)).to be_a_new(Reservation)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do

    it 'assigns the requested reservation to @reservation' do
      one = create(:reservation)
      
      get :edit, id: one
      expect(assigns(:reservation)).to eq one
    end

    it 'renders the :edit template' do
      one = create(:reservation)
      
      get :edit, id: one
      expect(response).to render_template :edit
    end

  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves the new reservation to database' do
        expect{
          post :create, reservation: attributes_for(:reservation)
        }.to change(Reservation, :count).by(1)
      end

      it 'redirects to reservatons#show' do
        post :create, reservation: attributes_for(:reservation)
        expect(response).to redirect_to reservation_path(assigns[:reservation])
      end

    end

    context 'with invalid attributes' do

      it 'does not save the new reservation to database' do
        expect{
          post :create, reservation: attributes_for(:invalid_reservation)
        }.not_to change(Reservation, :count)
      end
      it 're-renders the :new template' do
        post :create, reservation: attributes_for(:invalid_reservation)
        expect(response).to render_template :new
      end

    end

  end

  describe 'PATCH #update' do
    before :each do
      @reservation = create(:reservation, table_number: 5)
    end

    context 'with valid attributes' do

      it 'locates the requested @reservation' do
        patch :update, id: @reservation, reservation: attributes_for(:reservation)
        expect(assigns(:reservation)).to eq(@reservation)
      end

      it 'updates the reservation in the database' do
        patch :update, id: @reservation,
          reservation: attributes_for(:reservation, table_number: 10)

        @reservation.reload
        expect(@reservation.table_number).to eq(10)
      end

      it 'redirects to the updated reservaton' do
        patch :update, id: @reservation, reservation: attributes_for(:reservation)
        expect(response).to redirect_to @reservation
      end

    end

    context 'with invalid attributes' do

      it 'does not update the reservation in the database' do
        patch :update, id: @reservation,
          reservation: attributes_for(:invalid_reservation)
        @reservation.reload
        expect(@reservation.table_number).to eq(5)
      end

      it 're-renders the :edit template' do
        patch :update, id: @reservation,
          reservation: attributes_for(:invalid_reservation)
        expect(response).to render_template(:edit)
      end

    end

  end

  describe 'DELETE #destroy' do

    before :each do
      @reservation = create(:reservation)
    end

      it 'deletes the reservation from database' do
        expect{
          delete :destroy, id: @reservation
        }.to change(Reservation, :count).by(-1)
      end

      it 'redirects to reservations#index' do
        delete :destroy, id: @reservation
        expect(response).to redirect_to reservations_url
      end

  end

end
