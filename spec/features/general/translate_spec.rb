require 'spec_helper'

feature 'page translation', :js=>true do

  background do
    page.driver.remove_cookie("googtrans")
  end

  context 'translation cookie is set to Spanish', :vcr do
    it "displays Spanish-language contents" do
      page.driver.set_cookie("googtrans","/en/es")
      visit('/')
      within("#language-box") do
        all_links = all('a')
        all_links.should_not include "Español"
      end
      expect(page).to have_content("Necesito")
    end
  end

  context 'homepage is translated', :vcr do
    xit "displays a Spanish-language contents" do
      visit('/')
      find_link("Español").click
      within("#language-box") do
        all_links = all('a')
        all_links.should_not include "Español"
      end
      expect(page).to have_content("Necesito")
    end
  end

  context 'results page is translated', :vcr do
    xit "displays a Spanish-language contents" do
      visit('/')
      find_link("Español").click
      find(:css, '#find-btn').click
      delay # give Google Translate a chance to translate page
      expect(page).to have_content("Mostrando")
    end
  end

  context 'page is translated between languages', :vcr do
    xit "displays a Spanish-language, Tagalog-language, and English-language contents" do
      visit('/')
      find_link("Español").click
      expect(page).to have_content("Necesito")
      find_link("Tagalog").click
      expect(page).to have_content("Kailangan ko")
      find_link("English").click
      expect(page).to have_content("I Need")
    end
  end

end