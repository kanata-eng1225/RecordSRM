import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.star-label').forEach((label, index, labelArray) => {
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
  }
}
