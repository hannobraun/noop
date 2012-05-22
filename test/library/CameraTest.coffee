module "CameraTest", [ "Camera", "Rendering" ], ( Camera, Rendering ) ->
	describe "Camera", ->
		it "should transform renderable positions", ->
			camera = Camera.createCamera()
			camera.position   = [ 10, 10 ]
			camera.rotation   = Math.PI / 2
			camera.zoomFactor = 2

			renderable = Rendering.createRenderable( "", "" )
			renderable.position = [ 110, 10 ]

			Camera.transformRenderables(
				camera,
				[ renderable ] )

			tolerance = 0.001

			expect( renderable.position[ 0 ] ).to.be.within(
				0 - tolerance, 0 + tolerance )
			expect( renderable.position[ 1 ] ).to.be.within(
				200 - tolerance, 200 + tolerance )

load( "CameraTest" )