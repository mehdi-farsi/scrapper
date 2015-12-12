'use strict';

$(document).ready(function() {
    $('#startup-table').DataTable();
} );

function updateCheckBox(id) {
  var startupId    = id.split('-')[1];
  var checkBoxtype = id.split('-')[0].substr(1);
  var checked      = $(id).prop("checked");

  // PUT request data
  var startupInfo = { startup: { } };
  startupInfo["startup"][checkBoxtype.toString()] = checked;

  var request = $.ajax({
    url:    "/startups/" + startupId,
    contentType: "application/json",
    method: "PUT",
    data: JSON.stringify(startupInfo)
  });

  request.done(function( msg ) {
    alert("sucessfully saved !");
  });
   
  request.fail(function( jqXHR, textStatus ) {
    alert("Request failed");
  });
}