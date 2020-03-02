import 'bootstrap-material-design';
import '@fortawesome/fontawesome-free/js/all';
import 'raty-js';
import starOn from "../images/star-on.png";
import starOff from "../images/star-off.png";

$(document).ready(function () {
  $('body').bootstrapMaterialDesign();

  // For raty-js
  $('.new_rating').raty(
    {
      starOn: starOn,
      starOff: starOff,
      score: 3,
      scoreName: 'review[rate]'
    }
  )

  $('.rating').raty(
    {
      starOn: starOn,
      starOff: starOff,
      readOnly: true,
      score: function () {
        return $(this).attr('data-score');
      }
    }
  )
})
