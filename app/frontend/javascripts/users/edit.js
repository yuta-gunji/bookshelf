$(document).ready(function () {
  var isTargetPage =  $('body[data-controller="users"][data-action="edit"]').length > 0;
  if (isTargetPage) {
    $('#edit_user').on('change', 'input[type="file"]', function (e) {
      var file = e.target.files[0];
      var reader = new FileReader();
      var $preview = $(".preview-image");

      if (file.type.indexOf("image") < 0) {
        return false;
      }

      reader.onload = (function () {
        return function (e) {
          $preview.empty();
          $preview.append($('<img>').attr({
            src: e.target.result,
            class: "user-image edit"
          }));
        };
      })(file);

      reader.readAsDataURL(file);
    });
  }
})
