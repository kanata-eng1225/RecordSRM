// スクロールイベントにリスナーを追加
document.addEventListener('DOMContentLoaded', function() {
  window.addEventListener('scroll', toggleScrollIndicator);
  toggleScrollIndicator(); // 初期表示時の状態を設定
});

function toggleScrollIndicator() {
  const indicator = document.getElementById('scroll-indicator');
  if (!indicator) return;

  // ページの最下部に達しているかどうかをチェック
  const bottomOfPage = window.innerHeight + window.pageYOffset >= document.body.offsetHeight - 2;

  // 最下部に達したら、アニメーションを停止する
  if (bottomOfPage) {
    indicator.classList.add('opacity-0');
    indicator.classList.remove('animate-bounce');
  } else {
    indicator.classList.remove('opacity-0');
    indicator.classList.add('animate-bounce');
  }
}
