document.addEventListener("turbo:load", function() {
  setupModalListeners();
});

// Turbo-Frameが新しい内容を読み込んだ際のイベントリスナーを追加
document.addEventListener("turbo:frame-load", function() {
  setupModalListeners();
});

function openModal() {
  const modal = document.querySelector('[data-modal-target="modal"]');
  modal.classList.remove("hidden"); // hiddenクラスを削除
  document.body.style.overflow = 'hidden';
}

function closeModal() {
  const modal = document.querySelector('[data-modal-target="modal"]');
  modal.classList.add("hidden"); // hiddenクラスを追加
  document.body.style.overflow = 'auto';
}

function selectBoardItem(event) {
  const title = event.currentTarget.getAttribute('data-title');
  const detail = event.currentTarget.getAttribute('data-detail');
  const titleInput = document.querySelector('input[name="stress_record[title]"]');
  const detailTextarea = document.querySelector('textarea[name="stress_record[detail]"]');

  titleInput.value = title;
  detailTextarea.value = detail;

  closeModal();
}

function setupModalListeners() {
  const openButton = document.querySelector('[data-action="open-modal"]');
  const closeButton = document.querySelector('[data-action="close-modal"]');
  const boardItems = document.querySelectorAll('.board-item');

  if (openButton) {
    openButton.addEventListener('click', openModal);
  }

  if (closeButton) {
    closeButton.addEventListener('click', closeModal);
  }

  boardItems.forEach(item => {
    item.removeEventListener('click', selectBoardItem); // 既存のイベントリスナーを削除
    item.addEventListener('click', selectBoardItem);
  });
}