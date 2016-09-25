firebase = require('firebase');
firebase.initializeApp({
  serviceAccount: './Jotter-3a3867af697a.json',
  databaseURL:'https://jotter-70501.firebaseio.com/'
});

var db = firebase.database();
var ref = db.ref().child('OytASjm6DGZ269pvDdpDxKT5PPF2');
var previous;
counter = 0;
ref.child('currentImgSrc').on('value', function(screenshot){
   var total = screenshot.val();
   var link = total.src
   var data = erics(link);
   var name = "coord" + counter
   var wow = "jtrs&id=" + name
   ref.child('jots').update({name: data, url: wow});
   counter++
   total.activejot.set({name: data, url: wow})
 }, function(errorObject){
   console.log(errorObject.code);
 })

 ref.on('value', function(screenshot){
   var total = screenshot.val();
   var image = total.checksrc.src;
   var data = erics(image);
   var jots = total.jots;
   for(x in jots){
     counter = 0
     for (dat in x){
       if (data + 5 > dat || data-5 < dat){
         total.activejot.set(x)
       }
     }
   }
 }, function(errorObject){
   console.log(errorObject);
 })
// ref2.once('value', function(screen2){
//   var overall = screen2.val();
//   var niche = overall.currentImgSrc;
//   var calc = erics(niche);
//   console.log(calc);
//   for(x in overall.Jots){
//     if(x.coordinates == calc){
//       console.log(x)
//       break;
//     }else{
//       console.log(x.coordinates)
//     }
//   }
// }, function(errorObject){
//   console.log(errorObject);
// })
//
//
function f(json){
  for(first in json) break;
  return first;
}
function erics(image){
  return 'wow';
}
// -----------------------------------------------------------------------------------------
// start of code for adding additional identifiers
// ref2.child('addaccepted')on('value', function(snapshot){
//   var new = snapshot.val();
//
//   var  all = ref2.once('value', function(screen2){
//     return screen2.val();
//   }, function(errorObject){
//     console.log(errorObject.code);
//   });
// }, function(errorObject){
//   console.log(errorObject);
// })
