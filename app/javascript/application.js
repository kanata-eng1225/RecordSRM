// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
  document.querySelectorAll('.star-label').forEach((label, index, labelArray) => {
    label.addEventListener('click', (e) => {
      const radioButton = document.getElementById(`rating_${index + 1}`);
      radioButton.checked = true;

      labelArray.forEach((starLabel, starIndex) => {
        if (starIndex <= index) {
          starLabel.textContent = "★";
          starLabel.classList.remove('text-gray-400');
          starLabel.classList.add('text-yellow-500');
        } else {
          starLabel.textContent = "★";
          starLabel.classList.remove('text-yellow-500');
          starLabel.classList.add('text-gray-400');
        }
      });
    });
  });
});
