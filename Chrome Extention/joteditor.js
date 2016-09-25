//add variables
var config = {
  apiKey: "AIzaSyDruFFUFwU2ghS2zBDhyxaqQQuNThiKfyY",
  databaseURL: "https://jotter-70501.firebaseio.com",
  storageBucket: "otter-70501.appspot.com"
};
var uid;
var type;
firebase.initializeApp(config);
var id = getQueryVariable('id');
//get user data
firebase.auth().onAuthStateChanged(function(user){uid = user.uid});
 var dbref = firebase.database();
function initApp() {
  dbref.ref().once('value', function(snapshot) {
  currentsnap = snapshot.val();
  console.log(currentsnap);
  $('.jotid').text('"'+id+'"');

  //load stuff
var storage = localStorage.getItem(uid+id+'notes');
console.log(storage);
console.log(uid+id+'notes');
$('#textarea').val(storage);
Materialize.toast('Alright, you\'re set. Enjoy your jot.', 4000);

  });
$(document).ready(function(){
	$('#save').click(function(){
		var url = $('#url').val();
		dbref.ref('/' +uid+'/Jots/'+id).update({
			url: 'joteditor.html?id='+id
		});
		localStorage.setItem(uid+id+"notes", $('#textarea').val());
		Materialize.toast('Alright, you\'re set. It has saved', 4000);
	})
});
}
window.onload = function() {
  initApp();
};
function getQueryVariable(variable){
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}