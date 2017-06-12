const functions = require('firebase-functions');

// Firebase Setup
const admin = require('firebase-admin');
//const serviceAccount = require('./service-account.json');
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: "https://lostandfound-69075.firebaseio.com"
});

var firebase = require("firebase");

var config = {
  apiKey: "AIzaSyBMCGdZPS1DfqdfL416r-S0mVEVTZ-zlIg",
  authDomain: "lostandfound-69075.firebaseio.com",
  databaseURL: "https://lostandfound-69075.firebaseio.com",
  storageBucket: "gs://lostandfound-69075.appspot.com",
};
firebase.initializeApp(config);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

exports.test = functions.https.onRequest((req, res) => {
  res.send({response :  {success : true}});
});

exports.createUserWithEmail = functions.https.onRequest((req, res) => {
  // Grab the text parameter.
  const email = req.query.email;
  const password = req.query.password;
  const passwordRepeat = req.query.passwordrepeat;
  const name = req.query.nameuser;
  //const urlAvatar = req.query.urlavatar;
  if (password != passwordRepeat)
  {
    res.send({response :  {success : false, errorCode : '', errorMessage : 'Password not equal'}});
    return
  }
  else if (email == null || password == null || passwordRepeat == null || name == null)
  {
      res.send({response :  {success : false, errorCode : '', errorMessage : 'Fields Fail'}});
      return
  }

  admin.auth().createUser({
  email: email,
  emailVerified: false,
  password: password,
  displayName: name,
  //photoURL: urlAvatar,
  disabled: false
  }).then(function(userRecord) {
    //Авторизация
    firebase.auth().signInWithEmailAndPassword(email, password).then(function(firebaseUser) {
        res.send({response :  {success : true, user : firebaseUser}});
     }).catch(function(error) {
      var errorCode = error.code;
      var errorMessage = error.message;
      res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
    });
  }).catch(function(error) {
    var errorCode = error.code;
    var errorMessage = error.message;
    res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
  });
});

exports.addPost = functions.https.onRequest((req, res) => {
  // Grab the text parameter.
  const token = req.query.token;
  if (token == null)
  {
    res.send({response : {success : false, error : 'No token'}});
    return
  }
  admin.auth().verifyIdToken(token).then(function(decodedToken) {
     //get id user
     const iduser = decodedToken.uid;
     //get text
     const itemname = req.query.itemname || "";
     //get price
     const itemprice = parseFloat(req.query.itemprice) || 0;
     //get itemdescription
     const itemdescription = req.query.itemdescription || "";
     //get itemcoordinates
     const itemcoordinates = req.query.itemcoordinates || "";
     //get itemreward
     const itemreward = req.query.itemreward || "";

     //const arrayImageURL = Array(req.query.imagesurl);

      var id = 0;
      admin.database().ref('/system/addedPost').transaction(function (current_value) {
          id = (current_value || 0) + 1;
          // Push it into the Realtime Database then send a response
          //res.send({response :  {success : true, id : id}});
          return (current_value || 0) + 1;
      }).then(snapshot => {
              admin.database().ref('/posts').push({itemname: itemname, itemprice : itemprice, itemdescription : itemdescription, itemcoordinates : itemcoordinates, itemreward : itemreward, id : id, iduser : decodedToken.uid, createdAt : firebase.database.ServerValue.TIMESTAMP}).then(snapshotPost => {
                     res.send({response : {success : true}});
              }).catch(function(error) {
                var errorCode = error.code;
                var errorMessage = error.message;
                res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
              });
      }).catch(function(error) {
        var errorCode = error.code;
        var errorMessage = error.message;
        res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
      });
  }).catch(function(errorToken) {
    // Handle error
    res.send({response : {success : false, error : errorToken}});
  });
});

exports.getUser = functions.https.onRequest((req, res) => {
  // Grab the text parameter.
  const iduser = req.query.id;
  if (iduser == null)
  {
    res.send({response : {success : false, errorCode : "", errorMessage : "No iduser"}});
    return
  }
  admin.auth().getUser(iduser)
    .then(function(userRecord) {
      // See the UserRecord reference doc for the contents of userRecord.
      res.send({response : {success : true, user : userRecord}});
    })
    .catch(function(error) {
      var errorCode = error.code;
      var errorMessage = error.message;
      res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
    });
});

exports.getWallPosts = functions.https.onRequest((req, res) => {
    var lastid = null;
    var countobject = 10;
    if (req.query.countobject != null)
    {
      countobject = req.query.countobject;
    }
    if(req.query.lastid != null)
    {
      lastid = req.query.lastid;
    }
    console.log(lastid);
    // Push it into the Realtime Database then send a response
    var postUserRef = admin.database().ref('/posts')
    var posts = Array()
    var users = Array()
    var result = Array()
    var numberUsers = 0
    if (lastid == null) {
      postUserRef.orderByKey().limitToLast(countobject).once('value',     function(snapshot) {
          var value = snapshot.val();
          if (value)
          {
                snapshot.forEach(function(childSnapshot) {
                      let id_user = childSnapshot.val().iduser;
                      result.push({post : childSnapshot.val(), user : null});
                      admin.auth().getUser(id_user).then(function(user) {
                          numberUsers++;
                          result = result.map(function(obj) {
                              if (obj.post.iduser ==  user.uid)
                              {
                                  var objResult = obj
                                  objResult.user = user
                                  return objResult;
                              }
                              else {
                                return obj;
                              }
                          });
                          if (numberUsers == snapshot.numChildren())
                          {
                               result.reverse();
                               res.send({response : {success : true, posts : result}});
                          }
                          else if (snapshot.numChildren() == 0)
                          {
                               res.send({response : {success : true, posts : []}});
                          }
                      });
                 });
          }
          else {
             res.send({response : {success : true, posts : []}});
          }
      });
    }
    else if (parseInt(lastid - countobject - 1) > 0)
    {
          postUserRef.orderByChild("id").startAt(parseInt(lastid - countobject - 1)).endAt(lastid - 1).once('value',     function(snapshot) {
      	         snapshot.forEach(function(childSnapshot) {
                        let id_user = childSnapshot.val().iduser;
                        result.push({post : childSnapshot.val(), user : null});
                        admin.auth().getUser(id_user).then(function(user) {
                            numberUsers++;
                            result = result.map(function(obj) {
                                if (obj.post.iduser ==  user.uid)
                                {
                                    var objResult = obj
                                    objResult.user = user
                                    return objResult;
                                }
                                else {
                                  return obj;
                                }
                            });
                            if (numberUsers == snapshot.numChildren())
                            {
                                 result.reverse();
                                 res.send({response : {success : true, posts : result}});
                            }
                            else if (snapshot.numChildren() == 0)
                            {
                                 res.send({response : {success : true, posts : []}});
                            }
                        });
        	       });
          }, function(error) {
               // The callback failed.
               res.send({response : {success : false, error : error}});
           });
   }
   else {
     postUserRef.orderByChild("id").startAt(parseInt(lastid - countobject - 1)).endAt(lastid - 1).once('value',     function(snapshot) {
         var value = snapshot.val();
         if (value)
         {
               snapshot.forEach(function(childSnapshot) {
                     let id_user = childSnapshot.val().iduser;
                     result.push({post : childSnapshot.val(), user : null});
                     admin.auth().getUser(id_user).then(function(user) {
                         numberUsers++;
                         result = result.map(function(obj) {
                             if (obj.post.iduser ==  user.uid)
                             {
                                 var objResult = obj
                                 objResult.user = user
                                 return objResult;
                             }
                             else {
                               return obj;
                             }
                         });
                         if (numberUsers == snapshot.numChildren())
                         {
                              result.reverse();
                              res.send({response : {success : true, posts : result}});
                         }
                         else if (snapshot.numChildren() == 0)
                         {
                              res.send({response : {success : true, posts : []}});
                         }
                     });
                });
         }
         else {
            res.send({response : {success : true, posts : []}});
         }
     });
   }
});

exports.authUserWithEmail = functions.https.onRequest((req, res) => {
  // Grab the text parameter.
  const email = req.query.email;
  const password = req.query.password;
  firebase.auth().signInWithEmailAndPassword(email, password).then(function(firebaseUser) {
       // Success
      //  admin.auth().createCustomToken(firebaseUser.uid)
      //  .then(function(customToken) {
      //    // Send token back to client
      //    res.send({response :  {success : true, text :'Successfully auth', user : firebaseUser, token : customToken}});
      //  })
      //  .catch(function(error) {
      //    res.send({response :  {success : false, error : error}});
      //  });
      res.send({response :  {success : true, user : firebaseUser}});
   }).catch(function(error) {
    // An error happened.
    var errorCode = error.code;
    var errorMessage = error.message;
    res.send({response :  {success : false, errorCode : errorCode, errorMessage : errorMessage}});
    // if (errorCode == 'auth/weak-password') {
    //     res.send({response :'The password is too weak.'});
    // } else {
    //     res.send({response : errorMessage});
    // }
  });
});
