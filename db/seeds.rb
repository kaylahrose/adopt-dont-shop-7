ApplicantPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Applicant.destroy_all




# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    
pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
pet_2 = pet = Pet.create(name: "Scrappy", age: 1, breed: "Bull Dog", adoptable: true, shelter_id: shelter.id)

applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "In Progress")

# app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)