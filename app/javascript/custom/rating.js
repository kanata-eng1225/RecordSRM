function setupStarRating() {
  const starLabels = document.querySelectorAll('.star-label');

  starLabels.forEach((label, index) => {
    const radioButton = document.getElementById(`rating_${index + 1}`);

    label.addEventListener('click', (e) => {
      e.preventDefault();
      updateStarColors(index + 1); // 星の色を更新
      updatePreviewImage(label); // プレビュー画像をデフォルトに更新
      radioButton.checked = true; // 対応するラジオボタンを選択
      document.getElementById('selectedDifficulty').value = radioButton.value; // 難易度フィールドを更新
      document.getElementById('selectedImage').value = ""; // 選択された画像をリセット
    });
  });

  // 初期ロード時に星の色を設定
  updateStarColorsOnLoad();
}

// 星の色を更新する関数
function updateStarColors(difficulty) {
  const starLabels = document.querySelectorAll('.star-label');

  starLabels.forEach((label, index) => {
    if (index < difficulty) {
      label.classList.add('text-yellow-500');
      label.classList.remove('text-gray-400');
    } else {
      label.classList.remove('text-yellow-500');
      label.classList.add('text-gray-400');
    }
  });
}

// ページロード時に星の色を設定する関数
function updateStarColorsOnLoad() {
  const selectedDifficulty = document.querySelector('.star-rating:checked') ? parseInt(document.querySelector('.star-rating:checked').value) : 1;
  updateStarColors(selectedDifficulty);
}

// プレビュー画像を更新する関数
function updatePreviewImage(label) {
  const previewImage = document.getElementById('previewImage');
  const defaultImagePath = label.dataset.defaultImagePath;
  previewImage.src = defaultImagePath; // デフォルト画像を設定
}

document.addEventListener("turbo:load", setupStarRating);
document.addEventListener("turbo:render", setupStarRating);
