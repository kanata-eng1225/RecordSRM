document.addEventListener('turbo:load', function () {
  const inputElement = document.querySelector('[data-autocomplete-input]');
  const resultsElement = document.getElementById('autocomplete-results');

  function getEndpoint(query) {
    const inputType = inputElement.getAttribute('data-autocomplete-input');
    switch (inputType) {
      case 'stress_record':
        return `/stress_records/search?query=${query}`;
      case 'stress_relief':
        return `/stress_reliefs/search?query=${query}`;
      default:
        console.error('Invalid data-autocomplete-input value:', inputType);
        return null;
    }
  }

  if (inputElement) {
    inputElement.addEventListener('input', function (event) {
      const query = event.target.value;
      const endpoint = getEndpoint(query);

      if (!endpoint || query.length < 2) {
        resultsElement.classList.add('hidden');
        resultsElement.innerHTML = '';
        return;
      }

      fetch(endpoint, { cache: "no-store" })
        .then(response => {
          if (!response.ok) {
            throw new Error(`Network response was not ok: ${response.statusText}`);
          }
          return response.text();
        })
        .then(data => {
          while (resultsElement.firstChild) {
            resultsElement.removeChild(resultsElement.firstChild);
          }
          const div = document.createElement('div');
          div.innerHTML = data;
          resultsElement.appendChild(div);
          resultsElement.classList.remove('hidden');
        })
        .catch(error => {
          console.error('There was a problem with the fetch operation:', error.message);
        });
    });

    resultsElement.addEventListener('click', function(event) {
      const clickedElement = event.target;
      const title = clickedElement.getAttribute('data-result-title');
      if (title) {
        inputElement.value = title;
        resultsElement.innerHTML = '';
        resultsElement.classList.add('hidden');
      }
    });
  }
});

window.executeSearchFunction = function(event) {
  event.preventDefault();

  const inputElement = document.querySelector('[data-autocomplete-input]');
  const query = inputElement.value;
  const endpoint = getEndpoint(query);

  if (endpoint && query.length >= 2) {
    Turbo.visit(endpoint, { action: 'replace', target: 'modal_content' });
  }
}
