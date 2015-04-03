require 'spec_helper'

describe Ticket do  
  let(:ticket) { build(:ticket) }
  let(:invalid_ticket) { build(:invalid_ticket) }
  let(:spam_ticket) { build(:spam_ticket) }
  
  it { should validate_presence_of :customer_name }
  it { should validate_presence_of :customer_email }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :body }

  it { ticket.should be_valid }
  it { invalid_ticket.should_not be_valid }

  it "is spam" do
    expect(spam_ticket.spam?).to be_truthy
  end

  it "isn't spam" do
    expect(ticket.spam?).to be_falsey
  end

  describe "filter tickets only by a staff owned department" do
    let(:staff) { create(:member_staff) } 
    let(:department) { create(:department) }

    let!(:tickets) do
      (1..2).collect { create(:ticket, department: staff.department) } << create(:ticket, department: department)
    end

    context "matching tickets" do
      it "returns a sorted array of results that match" do
        expect(Ticket.with_department(staff)).to eq tickets[0...-1]
      end
    end

    context "non-matching tickets" do
      it "returns a sorted array of results that don't match" do
        expect(Ticket.with_department(staff)).to_not include tickets.last
      end
    end
  end

  it "creates a new customer staff for new ticket" do
    ticket = create(:ticket)
    expect(ticket.staff.email).to eq ticket.customer_email
  end

  it "tracks changes of status" do
    create_list(:status, 2)
    ticket = create(:ticket)
    ticket.status = Status.second
    ticket.save
    expect(ticket.histories).to exist
  end
end 
