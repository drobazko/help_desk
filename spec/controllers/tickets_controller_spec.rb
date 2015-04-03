require 'spec_helper'

describe TicketsController, :type => :controller do 
  let(:department) { create(:department) }

  let!(:tickets) do
    (1..5).collect { create(:ticket, department: department) } +
      [create(:ticket, department: nil), create(:ticket, department: create(:department))]
  end

  let(:ticket) { tickets.first }
  let(:invalid_ticket) { build(:invalid_ticket) }
  let(:john_valid_attributes) { attributes_for(:ticket, customer_name: "John Johnson") }
  let(:valid_attributes) { attributes_for(:ticket) }
  let(:invalid_attributes) { attributes_for(:invalid_ticket) }
  let(:spam_attributes) { attributes_for(:spam_ticket) }

  describe "GET #index" do
    context "not signed user" do
      it "list of tickets should redirect" do
        get :index
        expect(response).to redirect_to(new_staff_session_path)
      end
    end        
  
    context 'signed as member who is allowed to view tickets applied only to his department' do
      login_as 'member'

      it "populates an array of tickets of a particular department" do
        @current_user.update(department: ticket.department)

        get :index 
        expect(assigns(:tickets)).to eq tickets[0...-1]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end  

    context 'signed as admin who is allowed to view all tickets' do
      login_as 'admin'

      it "populates an array of tickets of all departments" do
        get :index 
        expect(assigns(:tickets)).to match_array(tickets)
      end
    end
  end

  describe "GET #new" do
    before { get :new }
    it "assigns a new Ticket to @ticket" do
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { get :edit, token: ticket.token }

    it "assigns the requested contact to @ticket" do
      expect(assigns(:ticket)).to eq ticket
    end
    
    it "render the #edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new ticket in the database" do
        expect{
          post :create, ticket: valid_attributes
        }.to change(Ticket, :count).by(1)
      end

      it "redirects to tickets#show" do
        post :create, ticket: valid_attributes
        expect(response).to redirect_to show_tickets_path(assigns[:ticket].token)
      end
    end

    context "with invalid attributes" do
      before { post :create, ticket: invalid_attributes }

      it "does not save the new ticket in the database" do
        expect(Ticket.exists?(body: invalid_ticket[:body])).to be_falsey
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    context "with spam content" do
      before { post :create, ticket: spam_attributes }

      it "throws out the error" do
        expect(assigns(:ticket).spam?).to be_truthy
      end
      
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before { patch :update, token: ticket.token, ticket: john_valid_attributes }

      it "locates the requested @ticket" do
        expect(assigns(:ticket)).to eq(ticket)
      end

      it "changes @ticket's attributes" do
        ticket.reload
        expect(ticket.customer_name).to eq("John Johnson")
      end

      it "redirects to the updated ticket" do
        expect(response).to redirect_to(show_tickets_path(ticket.token))
      end
    end

    context "with invalid attributes" do
      it "does not change ticket's attributes" do
        patch :update, token: ticket.token, ticket: attributes_for(:ticket, customer_name: nil, body: "Help!")
        ticket.reload
        expect(ticket.body).to_not eq("Help!")
      end

      it "renders the :edit template" do
        patch :update, token: ticket.token, ticket: attributes_for(:invalid_ticket)
        expect(response).to render_template :edit
      end
    end
  end
  
  describe "GET #take" do
    login_as 'member'

    it "assigns ticket to a particular staff member" do
      xhr :get, :take, id: ticket
      expect(ticket.reload.taken_tickets).to eq(@current_user) 
    end
  end
end

