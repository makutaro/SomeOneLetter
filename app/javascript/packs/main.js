// ページが読み込まれるたびに呼び出し
$(window).on('turbolinks:load', function() {

// 指定したIDの要素を返却(id名,css要素名)
// 例: (#body,height) => 30px
function fixHeaderPadding(){ 
  let nav_height = $('#header-nav').css('height');
  $('#header').css('padding-bottom', nav_height);
}
    //点滅 1秒span
    setInterval(function(){
      $(".flash").fadeOut(1500).fadeIn(1500);
    },3000);



  // nav-barの高さに合わせてheaderのpaddingを自動調整
  fixHeaderPadding() 
  console.log(Date.now() + " #header padding-bottom =>" + $('#header').css('padding-bottom'));

  // hello-modalがあれば呼び出し
  if($('#hello-modal').length){
      $('#hello-modal').modal("show")
    }
    
  // form_validataion 
  var forms = document.querySelectorAll('.needs-validation')
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('change', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()  // フォーム送信をキャンセル
          event.stopPropagation() // イベント伝搬をストップ
        }
        form.classList.add('was-validated')
      }, false)
    })

// letterの確認モーダル呼び出し
window.ShowPreviewModal = function(t,e){

  e.preventDefault()  // フォーム送信をキャンセル
  e.stopPropagation() // イベント伝搬をストップ
  
  // formのvalueを取得
  var form = $(t).parent().parent();
  var title   = form.find('[name = form-title]').val();
  var content = form.find('[name=form-content]').val();
  var room_id = form.find('[name=form-room-id]').val();

  if(title!="" && content!=""){
    // previewの値を操作
    $("#preview-title"  ).html(title);
    $("#preview-content").html(content.replace(/\n/g, '<br>'));
    $("#preview-room-id").html(room_id);

    // formのfieldをセット
    $("#preview-field-title"        ).val(title);
    $("#preview-field-content"      ).val(content);
    $("#preview-field-match_room_id").val(room_id);

    //モーダル起動
    $("#preview-modal"  ).modal("show");
  }else{
    form.addClass('was-validated');
    
  }
}
})