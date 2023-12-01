document.addEventListener('turbo:load', function () {
  setTimeout(function () {
    const loadingElement = document.getElementById('loading');
    const contentElement = document.getElementById('recommend-content');
    
    if (loadingElement && contentElement) {
      loadingElement.style.display = 'none';
      contentElement.style.display = 'block';
    }
  }, 2000);
});
