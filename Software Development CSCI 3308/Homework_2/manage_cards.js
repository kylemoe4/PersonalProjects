var tweets = [0,0,0];

function addTweet(index) {
	var tweet = "<div class='card' id='tweet"+index+"-"+tweets[index]+"'><div class='card-body'><button type='button' class='btn btn-danger btn-circle btn-sm righty' onclick='removeTweet("+index+","+tweets[index]+")'><strong>-</strong></button><center><h2>TWEET</h2></center></div></div>";
	document.getElementById("interest"+index).innerHTML += tweet;
	tweets[index] += 1;
}

function removeTweet(index,tweet) {
	document.getElementById("tweet"+index+"-"+tweet).remove();
}