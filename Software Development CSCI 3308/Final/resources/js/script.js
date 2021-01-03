function makeApiCall() {
	$("#card_view").html('');
	var searchTag = (document.getElementById("tags").value).split(' ').join('+');
	console.log(searchTag);
	var url = 'http://universities.hipolabs.com/search?name='+searchTag;

	$.ajax({url:url,dataType:"json"}).then(function(data) {
		console.log(data);
		var newCards = generateCards(data);
		$("#card_view").html(newCards);
	});
}

function generateCards(data) {
	var cards = '';
	for (var i = 0; i < data.length; i++) {
		cards +='<div class="card col-2 m-2 p-3"> \
				 	<h4>'+data[i].name+'</h4> \
				 	<h5 style="color:darkgray">'+data[i].country+'</h5> \
				 	<a href="'+data[i].web_pages[0]+'" class="btn btn-warning m-1">School Website</a> \
				 	<button type="button" class="btn btn-primary m-1" data-toggle="modal" data-target="#reviewModal" data-whatever="'+data[i].name+'">Review</button> \
				 </div>';
	}
	return cards;
}

$("#reviewModal").on("show.bs.modal", function(event) {
	var button = $(event.relatedTarget);
	var univ = button.data('whatever');
	var modal = $(this);
  	modal.find('.modal-body #university_name').val(univ);
  	modal.find('.modal-body #university_name').prop("readonly",true);
});