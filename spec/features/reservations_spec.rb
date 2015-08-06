require 'rails_helper'

feature 'Reservations', :type => :feature do

  scenario "Can see current reservations" do

    reservation = create(:reservation)
    visit reservations_path
    expect(page).to have_content 'Current reservations'
    expect(page).to have_content reservation.table_number

  end

  scenario "Can create new reservations" do

    visit reservations_path
    click_link 'Create Reservation'
    expect(page).to have_content 'New reservation form:'

    fill_in 'Table number', with: 12345
    find('#reservation_start_time_4i').find(:xpath, 'option[1]').select_option
    find('#reservation_end_time_4i').find(:xpath, 'option[2]').select_option
    click_button 'Create'

    expect(page).to have_content 'Reservation created'
    expect(page).to have_content 12345

    visit reservations_path
    expect(page).to have_content 12345
  end

  scenario "Can edit reservations" do

    visit reservations_path
    click_link 'Create Reservations'
    expect(page).to have_content 'New reservation form:'

    fill_in 'Table number', with: 12345
    find('#reservation_start_time_4i').find(:xpath, 'option[1]').select_option
    find('#reservation_end_time_4i').find(:xpath, 'option[2]').select_option
    click_button 'Create'

    expect(page).to have_content 12345

    click_link 'Edit'
    expect(page).to have_content 'Edit reservation form'

    fill_in 'Table number', with: 54321
    click_button 'Update'
    expect(page).to have_content 'Reservation updated'
    expect(page).to have_content 54321

  end

  scenario "Can destroy reservations" do

    visit reservations_path
    click_link 'Create Reservations'
    expect(page).to have_content 'New reservation form:'

    fill_in 'Table number', with: 12345
    find('#reservation_start_time_4i').find(:xpath, 'option[1]').select_option
    find('#reservation_end_time_4i').find(:xpath, 'option[2]').select_option
    click_button 'Create'

    expect(page).to have_content 12345

    click_link 'Delete'
    expect(page).to have_content 'Reservation destroyed'

    expect(page).to have_content 'Current reservations'
    expect(page).not_to have_content 12345

  end

end
