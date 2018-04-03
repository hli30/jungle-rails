require 'rails_helper'

RSpec.feature "Add items to cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Clicking on add link adds item to cart" do
    visit root_path

    page.first('.actions').find_link("Add").click

    save_screenshot

    # expect(page.find_link(href: '/cart')).to have_content "1"
    expect(page.find_link(href: '/cart')).to have_content "1"

  end 

end
