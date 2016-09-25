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
  });
$(document).ready(function(){
	$('#addimgsrc').click(function(){
		dbref.ref('/' +uid+'/currentImgSrc/').update({
				src: $('#imgsrc').val()
		});	
	});
	$('#checkimgsrc').click(function(){
		dbref.ref('/' +uid+'/checkSrc/').update({
				src: $('#checksrc').val()
		});
	});
	$('#dummyjot').click(function(){
		dbref.ref('/' +uid).update({
      		activeJot: {
      			url: 'jtrs&id=testJot',
      		},
      		Jots: {
      			testJot: {
      				cordinates: [0],
      				img: 'none',
      				url: 'none'
      			},
      		}
		});
	})
})
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