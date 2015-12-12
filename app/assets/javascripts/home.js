'use strict';

function updateCheckBox(id) {
  var startupId    = id.split('-')[1];
  var checkBoxtype = id.split('-')[0];
  var checked      = $(id).prop("checked");

  // PUT request data
  var startup_info = {
    startup: {
      done: checked
    }
  };

  var request = $.ajax({
    url:    "/startups/" + startupId,
    contentType: "application/json",
    method: "PUT",
    data: JSON.stringify(startup_info)
  });

  request.done(function( msg ) {
    alert("sucessfully saved !");
  });
   
  request.fail(function( jqXHR, textStatus ) {
    alert("Request failed");
  });
}