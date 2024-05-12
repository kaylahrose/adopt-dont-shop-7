require "rails_helper"

RSpec.describe "the application show page" do

#   1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"


  it "shows an application show page with form attributes" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    # pet_2 = pet = Pet.create(name: "Scrappy", age: 1, breed: "Bull Dog", adoptable: true, shelter_id: shelter.id)

    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "In Progress")

    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)

    visit "applicants/#{applicant_1.id}"

    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content("Full Address: #{applicant_1.street_address} #{applicant_1.city} #{applicant_1.state} #{applicant_1.zip_code}")
    expect(page).to have_content(applicant_1.qualification)
    expect(page).to have_content("Pet Name(s): #{pet_1.name}")
    expect(page).to have_content(applicant_1.application_status)
    expect(page).to have_link("Scooby")
  end

  it "lists matches as search results" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "In Progress")

    visit "/applicants/#{applicant_1.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Scooby"
    click_on("Search")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")


    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
  end

  it "Add a Pet to an Application" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets")

    visit "/applicants/#{applicant_1.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Scooby"
    click_on("Search")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")
    expect(page).to have_button("Adopt this Pet")

    click_on("Adopt this Pet")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")
    expect(page).to have_content("#{pet_1.name}")
  end
end