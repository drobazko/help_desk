require 'spec_helper'

feature "Ticket management" do
  background do
    create(:status)
    visit root_path
  end

  scenario "ticket creation"do
    fill_in 'Customer Name', with: "Sample Name"
    fill_in 'Ticket Body', with: "Sample Body"
    click_button "Create a Ticket"
    expect(last_email).to have_content("Ticket have been received.")
    expect(page).to have_content("Ticket created successfully. Message sent.")
  end
end