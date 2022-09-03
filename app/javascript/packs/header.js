// 指定したIDの要素を返却(id名,css要素名)
// 例: (#body,height) => 30px
function fixHeaderPadding(){ 
  let nav_height = $('#header-nav').css('height');
  $('#header').css('padding-bottom', nav_height);
}

// ページが読み込まれるたびに呼び出し
$(window).on('turbolinks:load', function() {
  fixHeaderPadding() //nav-barの高さに合わせてheaderのpaddingを自動調整
  console.log(Date.now() + " #header padding-bottom =>" + $('#header').css('padding-bottom'));

  // scroll-innerタグ
  const i = document.getElementById('scroll-inner');
  i.scrollTo(0, i.scrollHeight);
});

$(window).scroll(function () {
});
