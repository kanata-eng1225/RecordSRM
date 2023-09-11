document.addEventListener("turbo:load", function() {
  const slider = document.getElementById('stressSlider');
  const output = document.getElementById('sliderOutput');

  if (slider && output) {
    // 初期値を設定
    output.textContent = slider.value;

    // スライダーの値が変更されたときのイベントリスナー
    slider.addEventListener('input', function() {
      output.textContent = slider.value;
    });
  }
});
