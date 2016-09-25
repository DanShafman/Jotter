var config = {
  apiKey: "AIzaSyDruFFUFwU2ghS2zBDhyxaqQQuNThiKfyY",
  databaseURL: "https://jotter-70501.firebaseio.com",
  storageBucket: "otter-70501.appspot.com"
};
firebase.initializeApp(config);


function initApp() {
var currentsnap;
  // Listen for auth state changes.
  firebase.auth().onAuthStateChanged(function(user) {
	  var dbref = firebase.database();
	  //Get most recent snapshot
	  dbref.ref().once('value', function(snapshot) {
	  currentsnap = snapshot.val();
	  console.log(currentsnap);
      }).then(function(){
      	//Check for new user
	      if (!currentsnap[user.uid]){
	      	//Create vars for new user if new user
	      	dbref.ref('/' + user.uid).set({
	      		currentImg: 'none',
	      		activeJot: {
	      			url: 'none',
	      		},
	      		addAccepted: {
	      			image: 'none',
	      			jotId: 'none',
	      		},
	      		Jots: {
	      			testJot: {
	      				cordinates: [0],
	      				img: 'none',
	      				url: 'jotter.joebabbitt.com'
	      			},
	      		}
			});
	      };
		    dbref.ref('/'+ user.uid +'/activeJot').on('child_changed', function(data){	
		      	dbref.ref().once('value', function(csnapshot){currentsnap = csnapshot.val();});
		      	console.log(data.val());
		      	var newtab = createnewtab(data.val(),user,currentsnap);
		    });
        });
      //If change in current url then display it.
  });
}
function createnewtab(url,user,currentsnap){
	var id;
	if(url.slice(0,4) == 'jtrs'){
		id = getQueryVariable('id', url);
		url = 'newjot.html?id='+id;
	}
	else{
		if(currentsnap[user.uid].Jots[url].url){
		id = url;
		url = currentsnap[user.uid].Jots[url].url
		console.log(id);
		}
		else{url = '';}
	}
	chrome.tabs.create({ url: url });
	chrome.browserAction.setPopup({popup: "credentials.html?id="+id});
}
window.onload = function() {
  initApp();
};

function getQueryVariable(variable, url){
       var query = url
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}