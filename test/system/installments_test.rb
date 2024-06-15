require "application_system_test_case"

class InstallmentsTest < ApplicationSystemTestCase
  setup do
    @installment = installments(:one)
  end

  test "visiting the index" do
    visit installments_url
    assert_selector "h1", text: "Installments"
  end

  test "should create installment" do
    visit installments_url
    click_on "New installment"

    fill_in "Amount", with: @installment.amount
    fill_in "Date", with: @installment.date
    fill_in "Student", with: @installment.student_id
    click_on "Create Installment"

    assert_text "Installment was successfully created"
    click_on "Back"
  end

  test "should update Installment" do
    visit installment_url(@installment)
    click_on "Edit this installment", match: :first

    fill_in "Amount", with: @installment.amount
    fill_in "Date", with: @installment.date
    fill_in "Student", with: @installment.student_id
    click_on "Update Installment"

    assert_text "Installment was successfully updated"
    click_on "Back"
  end

  test "should destroy Installment" do
    visit installment_url(@installment)
    click_on "Destroy this installment", match: :first

    assert_text "Installment was successfully destroyed"
  end
end
