define "Camera", [ "Mat3x3", "Vec2", "Transform2d" ], ( Mat3x3, Vec2, Transform2d ) ->
	module =
		createCamera: ->
			camera =
				position  : [ 0, 0 ]
				rotation  : 0
				zoomFactor: 1

		transformRenderables: ( camera, renderables ) ->
			offset = Vec2.copy( camera.position )
			Vec2.scale( offset, -1 )

			transform = Transform2d.identityMatrix()
			t = Transform2d.translationMatrix( offset )
			r = Transform2d.rotationMatrix( camera.rotation )
			s = Transform2d.scalingMatrix( camera.zoomFactor )

			Mat3x3.multiply( transform, s )
			Mat3x3.multiply( transform, r )
			Mat3x3.multiply( transform, t )

			for renderable in renderables
				Vec2.applyTransform( renderable.position, transform )
