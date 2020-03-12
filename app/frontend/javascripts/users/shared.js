$(document).ready(function () {
  var isTargetPage =
    $('body[data-controller="users"][data-action="show"]').length > 0 ||
    $('body[data-controller="users"][data-action="reviews"]').length > 0 ||
    $('body[data-controller="users"][data-action="followings"]').length > 0 ||
    $('body[data-controller="users"][data-action="followers"]').length > 0;

  if (isTargetPage) {
    var actionName = $('body').attr('data-action');
    $(`#${actionName}-nav-item`).addClass('bg-white');
  }
})
