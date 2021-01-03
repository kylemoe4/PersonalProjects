var pages = 0;

$(document).ready(function() {
    function makeApiCall() {
        var quantity = document.getElementById("quantity").value.toString();
        var tagSearch = (document.getElementById("tags").value).split(' ').join('+');
        console.log(quantity + " ; " + tagSearch);
        
        var url ='https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=d5a286974beac7da4c0887f45e4dbcb0&tags='+tagSearch+'&privacy_filter=1&safe_search=1&extras=url_sq&per_page='+quantity+'page='+pages.toString()+'&format=json&nojsoncallback=1'; 

        $.ajax({url:url, dataType:"json"}).then(function(data) {
            function newCard(i) {
                return '<div class="card col-sm-2 m-2"> \
                            <img class="card-img-top p-2" src="'+data.photos.photo[i].url_sq+'" alt="img"> \
                            <div class="card-body"> \
                                <h5 class="card-title">'+data.photos.photo[i].title+'</h5> \
                            </div> \
                        </div>';
            }
            console.log(data);
            var newCards = '';
            for (var i = 0; i < quantity; i++) {
                newCards += newCard(i)
            }
            console.log("page: " + pages);
            pages ++;
            $("#img_display").append(newCards);
        });
        
    }

    $("#query").submit(function(event) {
        event.preventDefault();
        pages=0;
        $("#img_display").html("");
        makeApiCall();
    });

    $(window).scroll(function () {
        if ($(window).scrollTop() >= ($(document).height() - $(window).height())) {
            makeApiCall();
        }
    });
    
});


 