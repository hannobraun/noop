define "Loader", [ "Images", "Game" ], ( Images, Game ) ->
	Images.loadImages Game.imagePaths, ( rawImages ) ->
		images = Images.process( rawImages )
		Game.initGame( images )
