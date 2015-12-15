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

function concatenateEmails (firstname, lastname, domain) {
  return ([
    firstname + "@" + domain,
    firstname + "." + lastname + "@" + domain,
    firstname.charAt(0) + lastname + "@" + domain
  ]);
}

function generateEmails(rowId) {
  var domainInput       = $(rowId + " #domain-input").val();
  var employees         = $(rowId + " #employees #employee-name");
  var emailPropositions = $(rowId + " #email-propositions");
  var emailResults      = [];

  // For checking if the input is blank or contains only white-spaces
  if (domainInput.length === 0 || !domainInput.trim() || $(rowId + " #email-propositions li").length > 0) {
    return (false);
  };

  employees.each(function(index, elem) {
    var fullname  = $(this).text().split(' ');
    var firstname = fullname.shift();
    var lastname  = fullname.join('-');

    // generate emails
    emailResults = concatenateEmails(
      firstname.toLowerCase().latinize(),
      lastname.toLowerCase().latinize(),
      domainInput.toLowerCase().latinize()
    );

    // display email propositions
    emailResults.map(function(elem) {
      emailPropositions.append("<li>" + elem + "</li>");
    })
    
  });
}


