// Brandon Wood
// Hack Copper 2016
// 9/24/16

//initialize app and important variables
firebase = require('firebase');
firebase.initializeApp({
  serviceAccount: './Jotter-3a3867af697a.json',
  databaseURL:'https://jotter-70501.firebaseio.com/'
});

// pyshell= require('python-shell');
//
// pyshell.run('wow.py', function(err)){
//   if(err) throw err;
//   console.log('done')
// }


var db = firebase.database();
var ref = db.ref().child('XCkne1cJDggmbt5yyGa70YoVCkQ2').child('Jots');
var previous;

ref.on("value", function(snapshot){
  var snap = snapshot.val();
  console.log(snap);
  var new_key = kek(snap);
  new_image = snap.new_key.img;
  var coordinates = wow(new_image)
  if(snap.length != previous){
    ref.child('Jots').child(new_key).push(coordinates);
  }

  previous = (snap);

},function(errorObject){
  console.log(errorObject);
});

ref.child('currentImg').on('value', function(snapshot){
  var new_img = snapshot.val();
  var jots = ref.once('value', function(snapshot1){
    return snapshot1.val();
  });

  for(x in jots){
    var old_sauce = [x.coordinates, x];
    var new_sauce = wow(new_img);
    var id;
    if(sauce[0].length != new_sauce.length){
      null;
    }else{
      for(var i = 0; i< new_sauce.length; i++){
        if(old_sauce[0][i] > new_sauce[i] + 5 || old_sauce[0][i] < new_sauce - 5){
          break
        }else if(i == new_sauce.length){
         id = old_sauce[1];
         ref.jots.id.push(coordinates);
        }
      }
    }
  }
}, function(errorObject){
  console.log(errorObject.code);
});

ref.child('addAccepted').on('value', function(snapshot){
  var info = snapshot.val();
  coordinates = wow(info.image);
  var route = ref.once('value', function(snapshot1){
    return snapshot1.val().Jots
  },function(errorObject){
    console.log(errorObject.code);
  });
  var key = info.jotid;
  route.key.coordinates.push(coordinates);

  }, function(errorObject){
  console.log('errorObject')
  }
);
//using to test until opencv is done


function kek(json){
  for(first in json) break;
  return first;
}

function wow(img){
  img = img;}
  coordinates = [0,1,2,3,4,5,6,7];
  return coordinates;
}
//first element
