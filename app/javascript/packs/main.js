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
  // const i = document.getElementById('scroll-inner');
  // i.scrollTo(0, i.scrollHeight);
})

// letterの確認モーダル呼び出し
window.ShowPreviewModal = function(e){
  // formのvalueを取得
  var form = $(e).parent().parent();
  var title   = form.find('[name = form-title]').val();
  var content = form.find('[name=form-content]').val();
  var room_id = form.find('[name=form-room-id]').val();

  // previewの値を操作
  $("#preview-title"  ).html(title);
  $("#preview-content").html(content);
  $("#preview-room-id").html(room_id);

  // formのfieldをセット
  $("#preview-field-title"        ).val(title);
  $("#preview-field-content"      ).val(content);
  $("#preview-field-match_room_id").val(room_id);

  //モーダル起動
  $("#preview-modal"  ).modal("show");
}

// // Example starter JavaScript for disabling form submissions if there are invalid fields
// (function () {
//   'use strict'

//   // Fetch all the forms we want to apply custom Bootstrap validation styles to
//   var forms = document.querySelectorAll('.needs-validation')

//   // bootstrap_validation
//   Array.prototype.slice.call(forms)
//     .forEach(function (form) {
//       form.addEventListener('submit', function (event) {
//         if (!form.checkValidity()) {
//           event.preventDefault()
//           event.stopPropagation()
//         }
//         form.classList.add('was-validated')
//       }, false)
//     })
// })