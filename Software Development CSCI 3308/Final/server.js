var express = require('express'); //Ensure our express framework has been added
var app = express();
var bodyParser = require('body-parser'); //Ensure our body-parser tool has been added
app.use(bodyParser.json());              // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

//Create Database Connection
var pgp = require('pg-promise')();

let dbConfig = {
	host: 'localhost',
	port: 5432,
	database: 'FinalExam',
	user: 'postgres',
	password: 'Minimoe4'
};

//const isProduction = process.env.NODE_ENV === 'production';
//dbConfig = isProduction ? process.env.DATABASE_URL : dbConfig;
let db = pgp(dbConfig);

// set the view engine to ejs
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/'));

app.get('/', function(req, res) {
	res.redirect("/home");
});

app.get('/home', function(req, res) {
	res.render('pages/main',{
		my_title:'Home Page',
	});
});
app.post('/reviews', function(req, res) {
	var getReview = req.body.review_text;
	var getUniv = req.body.university_name;
	var currentTime = Date.now()/1000.0;
	var insert_statement = 'insert into reviews(university_name,review,review_date) \
		values(\''+getUniv+'\',\''+getReview+'\',to_timestamp(\''+currentTime+'\'));';
	var allReviews = 'select * from reviews';

	//console.log(req.body);
	db.task('get-everything', task => {
		return task.batch([
			task.any(insert_statement),
			task.any(allReviews)
		]);
	})
	.then(info => {
		/*res.render('pages/reviews', {
			my_title: "Reviews",
			reviews: info[1],
		})*/
		res.redirect('/reviews');
	})
	.catch(err => {
        console.log('error', err);
		res.redirect('/reviews');
    });
});
app.get('/reviews', function(req,res) {
	var allReviews = 'select * from reviews';
	db.any(allReviews)
	.then(data => {
		res.render('pages/reviews',{
			my_title: "Reviews",
			reviews: data,
		})
	})
	.catch(err => {
		console.log('error',err);
		res.render('pages/reviews',{
			my_title: "Reviews",
			reviews: '',
		})
	});
});

/*const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, () => {
	console.log(`Express running → PORT ${server.address().port}`);
});*/

app.listen(3000);
console.log('3000 is the magic port');
