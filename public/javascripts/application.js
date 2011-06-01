//Useful links:
// http://code.google.com/apis/maps/documentation/javascript/reference.html#Marker
// http://code.google.com/apis/maps/documentation/javascript/services.html#Geocoding
// http://jqueryui.com/demos/autocomplete/#remote-with-cache
      
//maps
var geocoder;
var map;
var marker;
    
function initialize(){
//MAP
  var latlng = new google.maps.LatLng(38.858399,-77.453364);
  var options = {
    zoom: 16,
    center: latlng,
    mapTypeControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
        
  map = new google.maps.Map(document.getElementById("map_canvas"), options);
        
  //GEOCODER
  geocoder = new google.maps.Geocoder();
        
  marker = new google.maps.Marker({
    map: map,
    draggable: true
  });
				
}

//show autocomplete fields in div
function addMessage(msg){
    $('#msgs').text(msg+"  ");
}
//split list
function split( val ) {
  return val.split( /,\s*/ );
}
//extract the last item
function extractLast( term ) {
  return split( term ).pop();
}
//remove element from the array
Array.prototype.remove = function (value)
{
    for (var i = 0; i < this.length; )
    {
        if (this[i] === value)
        {
            this.splice(i, 1);
        }
        else
        {
           ++i;
        }
    }
}



$(document).ready(function() { 
var a=[];
$('input:checkbox').change(function() {
  a.push($(this).val());
  if (!$(this).is(':checked'))
      a.remove($(this).val())
$('#list_view_loading').show();
var urltosend =  "/search/filters.json?firstsearch="+$("#location").val()+"&search="+a.join(",")
   $.ajax({

      url: urltosend,
      success: function(data){
        $("#results").children('li').each(function(){
                $('#results li').remove();
        });
        $.each(data, function(i, item) {

var listData = '<li class="search_result"><div id="room_details"><h2 class="room_title"><a href="/rooms/' + item.id+ '" class="name">'+item.title+
          '</a></h2><p class="address">'+item.fulladdress+'</p> </div> <div class="price" <div class="price_data"><sup class="currency_if_required"</sup>' +
          '<div class="currency_with_sup"><sup>$</sup>'+item.cost+'</div></div><div class="price_modifier">Per hour</div></div></li>';
          $('#results').append(listData);
        });
      },complete: function(){ $('#list_view_loading').hide(); }
   });
});


$("#room_event_tokens").val($("#room_event_tokens").data("pre"));
 $("#room_event_tokens")
      .bind( "keydown", function( event ) {
				if ( event.keyCode === $.ui.keyCode.TAB &&
						$( this ).data( "autocomplete" ).menu.active ) {
					event.preventDefault();
				}
			})
      .autocomplete({

        // Set the source option to a function that performs the search,
        // and calls a response function with the matched entries.
        source: function(req, responseFn) {
            //addMessage("search on: '" + req.term + "'<br/>");


         // response( $.ui.autocomplete.filter(
          //  availableTags, extractLast( request.term ) ) );  
           // responseFn( $.ui.autocomplete.filter(
            //wordlist, extractLast( req.term ) ) );
//$.getJSON( "/events.json", {
//						term: extractLast( req.term )
//					}, responseFn);          
				$.ajax({
					url: "/events.json",
					dataType: "json",
					data: {
						q: extractLast(req.term)
					},
					success: function( data ) {
						responseFn( $.map( data, function( item ) {
							return {
								label: item.name +" "+ "("+ item.count + ")", //+ (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
								value: item.name
							}
						}));
					}
				});
        },
      autoFocus: true,
      select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
        // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( ", " );
        return false;
        }      
    });



  $('#location').click(function() {
      $(this).val('');
    });
  initialize();
				  
  $(function() {
    $("#address").autocomplete({
      //Th:is bit uses the geocoder to fetch address values
      source: function(request, response) {
        geocoder.geocode( {'address': request.term }, function(results, status) {
          response($.map(results, function(item) {
            return {
              label:  item.formatted_address,
              value: item.formatted_address,
              latitude: item.geometry.location.lat(),
              longitude: item.geometry.location.lng()
            }
          }));
        })
      },
      //This bit is executed upon selection of an address
      select: function(event, ui) {
        //$("#latitude").val(ui.item.latitude);
        //$("#longitude").val(ui.item.longitude);
        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
        marker.setPosition(location);
        map.setCenter(location);
      }
    });
  });
	
  //Add listener to marker for reverse geocoding
  
});
