document.addEventListener('turbo:load', function () {
  // スクロールイベントのリスナーを追加
  window.addEventListener('scroll', function() {
    // 矢印の要素を取得
    const scrollIndicator = document.getElementById('scroll-indicator');

    // 矢印の要素が存在しない場合は処理をスキップ
    if (!scrollIndicator) return;

    // ドキュメントの高さ
    const docHeight = document.documentElement.scrollHeight;
    // ウィンドウの高さ
    const winHeight = window.innerHeight;
    // スクロールされた高さ
    const scrolled = window.scrollY;

    // スクロール位置が、ドキュメントの最下部に近づいたかどうかをチェック
    if (scrolled + winHeight > docHeight - 50) {
      // 矢印を隠す
      scrollIndicator.style.display = 'none';
    } else {
      // それ以外の場合は矢印を表示
      scrollIndicator.style.display = 'block';
    }
  });
});
