$(document).ready(function(){
  keywords_filter();
  price_filter();
});

function ajax_filter() {
  var hash             = { price: get_price(), keywords: get_keywords() };
  var section          = $("#section").text();
  var div_with_results = "#" + section;

  // console.log(hash);

  update_browser_history();

  $("#loading").show();

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
      $("#loading").hide();
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

function update_browser_history() {
  var href = "/";

  if (get_price() != undefined) {
    href = href + "?price=" + get_price();
  }
  var array = get_keywords();

  for (var i in array) {
    href = href + "&keywords[]=" + array[i];
  }

  history.pushState({}, '', href);
  // console.log("HREF: " + href);
}
