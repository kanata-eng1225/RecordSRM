function setupModalEvents() {
  const imageModal = document.getElementById('imageModal');
  const imageSelection = document.getElementById('imageSelection');
  const difficultySelect = document.getElementById('difficultySelect');
  const confirmSelectionButton = document.getElementById('confirmSelectionButton');
  const closeModalButton = document.getElementById('closeModal');
  const temporarySelectedImage = document.getElementById('temporarySelectedImage');
  const selectedDifficultyInput = document.getElementById('selectedDifficulty');
  const previewImage = document.getElementById('previewImage');
  const openModalButton = document.getElementById('openModalButton');

  if (openModalButton && imageModal && selectedDifficultyInput && difficultySelect) {
    openModalButton.addEventListener('click', function() {
      imageModal.style.display = 'block';
      updateImageSelection(selectedDifficultyInput.value);
      difficultySelect.value = selectedDifficultyInput.value;
    });
  }

  if (difficultySelect && imageSelection && temporarySelectedImage) {
    difficultySelect.addEventListener('change', function() {
      temporarySelectedImage.value = '';
      updateImageSelection(this.value);
    });
  }

  if (confirmSelectionButton && previewImage && selectedDifficultyInput && difficultySelect) {
    confirmSelectionButton.addEventListener('click', function() {
      if (temporarySelectedImage.value) {
        previewImage.src = temporarySelectedImage.value;
        document.getElementById('selectedImage').value = temporarySelectedImage.value;
      } else {
        const defaultImagePath = document.getElementById(`defaultImagePath${difficultySelect.value}`).dataset.path;
        previewImage.src = defaultImagePath;
        document.getElementById('selectedImage').value = "";
      }
      selectedDifficultyInput.value = difficultySelect.value;
      updateStarRating(difficultySelect.value);
      imageModal.style.display = 'none';
    });
  }

  if (closeModalButton && imageModal) {
    closeModalButton.addEventListener('click', function() {
      imageModal.style.display = 'none';
    });
  }

  if (selectedDifficultyInput) {
    updateStarRating(selectedDifficultyInput.value);
  }
}

function updateImageSelection(difficulty) {
  const imagePathsContainer = document.getElementById(`imagePathsForDifficulty${difficulty}`);
  const imagePaths = imagePathsContainer ? imagePathsContainer.querySelectorAll('span') : [];

  imageSelection.innerHTML = '';
  imagePaths.forEach(pathElement => {
    const imagePath = pathElement.dataset.path;
    if (pathElement.id.startsWith("defaultImagePath")) return;

    const imageElement = document.createElement('img');
    imageElement.src = imagePath;
    imageElement.className = 'modal-image cursor-pointer w-full h-[150px] object-cover';
    imageElement.addEventListener('click', function() {
      temporarySelectedImage.value = this.src;
      document.querySelectorAll('.modal-image').forEach(img => img.classList.remove('border-4', 'border-green-500'));
      this.classList.add('border-4', 'border-green-500');
    });
    imageSelection.appendChild(imageElement);
  });
}

function updateStarRating(difficulty) {
  const starLabels = document.querySelectorAll('.star-label');

  starLabels.forEach((label, index) => {
    if (index < difficulty) {
      label.classList.add('text-yellow-500');
      label.classList.remove('text-gray-400');
    } else {
      label.classList.add('text-gray-400');
      label.classList.remove('text-yellow-500');
    }
  });
}

document.addEventListener('turbo:load', setupModalEvents);
document.addEventListener('turbo:render', setupModalEvents);
