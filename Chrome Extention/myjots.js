var config = {
  apiKey: "AIzaSyDruFFUFwU2ghS2zBDhyxaqQQuNThiKfyY",
  databaseURL: "https://jotter-70501.firebaseio.com",
  storageBucket: "otter-70501.appspot.com"
};
var currentsnap;
var userid
firebase.initializeApp(config);
function setjots(){
	var jotslist = currentsnap[userid.uid].Jots;
	$.each(jotslist, function(key,value){
		$('#tablebody').append('<tr><td>'+key+'</td><td><a href="'+value.url+'">'+value.url+'</a></td><td>'+value.img+'</td></tr>')
	})
}
function initApp() {
	firebase.auth().onAuthStateChanged(function(user) {
		userid = user;
		var dbref = firebase.database();
		dbref.ref().once('value', function(snapshot) {
		  currentsnap = snapshot.val();
		  var settable = setjots();
		});
	});
}
window.onload = function() {
  initApp();
};