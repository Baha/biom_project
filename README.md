Schneiderman & Kanade algorithm for Face Detection
--------------------------------------------------

This is an **unoptimized** implementation of the Schneiderman
& Kanade algorithm for Face Detection which can be executed
using MATLAB (tested with version R2012b). This project
has didactic purposes, you can check the internet for an
optimized version if that's what you're looking for.

The main functions allow you to:

1. Train a face detector, given a number of patterns.
2. Apply the trained face detector to an image, given
the name of that image and threshold.

You can do the first by running:

`trainFaceDetector(nPatterns)`

Once you do this, a model for detection will be trained and
stored at folder "config". We already include a model trained
with 256 patterns and an image database that can be obtained from
[Roberto Paredes webpage](http://users.dsic.upv.es/~rparedes/teaching/Biometria/index.html), but you can train your own (although you may
need to tweak some parameters fixed on the code).

After having our model, we can apply it to an image using:

`applyFaceDetector(imageName,threshold)`

This will tag the given image, and store it into a new image
(appending "\_tagged" to its name). You can also use another
function for tagging images from a folder:

`bunchApplyFaceDetector('imageFolderName)`
