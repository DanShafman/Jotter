Jotter <img src="https://raw.githubusercontent.com/josephbabbitt/Jotter/master/Chrome%20Extention/icons/icon128.png">
====================================================
Made by: [Joseph Babbitt](http://www.github.com/josephbabbitt), [Dan Shafman](https://github.com/DanShafman), [Eric Jiang](https://github.com/Eric4Jiang), and [Brandon Wood](https://github.com/Brandonfrommechanical)

#What it is

A way to maximize your notetaking space and offload what you can't fit into the cloud.

#How it works

An symbol is captured via an iphone camera app. Then transfered to a server. A computer running node.js grabs the image and uses a python script that we made using OpenCV and point regognition to convert it into mathimatical points. Then, that computer uploads those points to the database. A chrome extention running on the users computer then opens a page to assign the symbol to a link. At that point, any time the symbol is rescanned by the camera app it automatically opens the predetermined link on the computer.

####The TL;DR version of what you just read

We do a bunch of processing so that you can just scan and have your link appear like magic.

#What we used

1. Swift and an iphone app
2. Firebase
3. Open CV
4. Pyhton
5. Node.js
6. Chrome extentions

