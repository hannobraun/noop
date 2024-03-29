module "ImagesTest", [ "Images" ], ( Images ) ->
	imageDataFrom = ( image ) ->
		canvas = document.createElement( "canvas" )
		canvas.width  = image.width
		canvas.height = image.height

		context = canvas.getContext( "2d" )
		context.drawImage( image, 0, 0 )

		imageData = context.getImageData( 0, 0, canvas.width, canvas.height )
		imageData.data

	expect.Assertion.prototype.lookLikeThisArray = ( array ) ->
		looksLikeThisArray = true

		for element, index in array
			if this.obj[ index ] != element
				looksLikeThisArray = false

		this.assert(
			looksLikeThisArray,
			"expected something",
			"expected not something" )


	describe "Images", ->
		it "should load the given images and pass them to the callback", ( done ) ->
			imagePaths = [
				"test/resources/1x1red.png"
				"test/resources/1x1green.png" ]

			Images.loadImages imagePaths, ( images ) ->
				red   = imageDataFrom( images[ imagePaths[ 0 ] ] )
				green = imageDataFrom( images[ imagePaths[ 1 ] ] )

				expect( red   ).to.lookLikeThisArray( [ 255,    0, 0, 255 ] )
				expect( green ).to.lookLikeThisArray( [    0, 255, 0, 255 ] )
				done()

		it "should create an image data structure from the images", ->
			rawImages =
				"some/image.png":
					width : 16
					height: 64
				"other/image.png":
					width : 32
					height: 32

			images = Images.process( rawImages )

			expectedImages =
				"some/image.png":
					rawImage: rawImages[ "some/image.png" ]
					positionOffset: [ -8, -32 ]
					orientationOffset: 0
				"other/image.png":
					rawImage: rawImages[ "other/image.png" ]
					positionOffset: [ -16, -16 ]
					orientationOffset: 0
			expect( images ).to.eql( expectedImages )

load( "ImagesTest" )
