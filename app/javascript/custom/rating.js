function setupStarRating() {
  const starLabels = document.querySelectorAll('.star-label');

  starLabels.forEach((label, index) => {
    const radioButton = document.getElementById(`rating_${index + 1}`);
    if (radioButton && radioButton.checked) {
      label.classList.add('text-yellow-500');
      label.classList.remove('text-gray-400');
    } else {
      label.classList.add('text-gray-400');
      label.classList.remove('text-yellow-500');
    }

    label.addEventListener('click', (e) => {
      e.preventDefault();
    });
  });
}

document.addEventListener("turbo:load", setupStarRating);
document.addEventListener("turbo:render", setupStarRating);
