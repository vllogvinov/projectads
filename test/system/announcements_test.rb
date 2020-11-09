require "application_system_test_case"

class AnnouncementsTest < ApplicationSystemTestCase
  setup do
    @announcement = announcements(:one)
  end

  test "visiting the index" do
    visit announcements_url
    assert_selector "h1", text: "Announcements"
  end

  test "creating a Announcement" do
    visit announcements_url
    click_on "New Announcement"

    fill_in "Content", with: @announcement.content
    fill_in "Status", with: @announcement.status_id
    fill_in "Title", with: @announcement.title
    fill_in "Type", with: @announcement.type
    fill_in "User", with: @announcement.user_id
    click_on "Create Announcement"

    assert_text "Announcement was successfully created"
    click_on "Back"
  end

  test "updating a Announcement" do
    visit announcements_url
    click_on "Edit", match: :first

    fill_in "Content", with: @announcement.content
    fill_in "Status", with: @announcement.status_id
    fill_in "Title", with: @announcement.title
    fill_in "Type", with: @announcement.type
    fill_in "User", with: @announcement.user_id
    click_on "Update Announcement"

    assert_text "Announcement was successfully updated"
    click_on "Back"
  end

  test "destroying a Announcement" do
    visit announcements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Announcement was successfully destroyed"
  end
end
