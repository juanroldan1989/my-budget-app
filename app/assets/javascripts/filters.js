$(document).ready(function(){
  $("#loader").loader();

  keywords_filter();
  price_filter();
});

function ajax_filter() {
  var hash             = { price: get_price(), keywords: get_keywords() };
  var section          = $("#section").text();
  var div_with_results = "ul#" + section;

  // console.log(hash);

  $("#loader").loader("show");

  $.ajax({
    type    : "GET",
    beforeSend: function(xhr){
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },
    url      : "/" + section + "/filter",
    data     : hash,
    success  : function(data){
      $(div_with_results).html("");
      $(div_with_results).html(data);
      $(div_with_results).listview("refresh");
      $("#loader").loader("hide");
    }
  });
}

function get_keywords() {
  var keywords = new Array();
  $("[data-behavior~=keywords-filter]").each(function() {
    if ($(this).is(":checked")) {
      keywords.push($(this).data("value"));
    }
  });
  return keywords;
}

function get_price() {
  var element = "input[name=price-radio]:checked";
  var selected = $(element).val();

  return selected;
}

function keywords_filter() {
  $("[data-behavior~=keywords-filter]").on("change", function() {
    ajax_filter();
  });
}

function price_filter() {
  $("[data-behavior~=price-filter]").on("change", function() {
    ajax_filter();
  });
}
