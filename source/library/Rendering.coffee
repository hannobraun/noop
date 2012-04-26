define "Rendering", [], ->
	module =
		# The draw functions were written as needed for specific purposes and
		# then moved into the library. They could use some cleanup.
		drawFunctions:
			"image": ( images, context, renderable ) ->
				image = images[ renderable.resourceId ]
				unless image?
					throw "Image #{ renderable.resourceId } does not exist."

				context.translate(
					renderable.position[ 0 ],
					renderable.position[ 1 ] )
				context.rotate( renderable.orientation + image.orientationOffset )
				context.translate(
					image.positionOffset[ 0 ],
					image.positionOffset[ 1 ] )
				context.drawImage( image.rawImage, 0, 0 )

			"circle": ( shapes, context, renderable ) ->
				shape = shapes[ renderable.resourceId ]

				context.translate(
					renderable.position[ 0 ],
					renderable.position[ 1 ] )
				context.rotate( renderable.orientation )
				context.translate(
					shape.offset[ 0 ],
					shape.offset[ 1 ] )
				context.beginPath()
				context.arc(
					0,
					0,
					shape.circle.radius,
					0,
					Math.PI * 2,
					true )
				context.stroke()

			"ellipse":( _, context, renderable ) ->
				ellipse = renderable.resource

				context.strokeStyle = ellipse.color

				context.translate(
					renderable.position[ 0 ],
					renderable.position[ 1 ] )
				context.rotate(
					renderable.orientation )
				context.scale(
					ellipse.semiMajorAxis / ellipse.semiMinorAxis,
					1 )
				context.beginPath()
				context.arc(
					0,
					0,
					ellipse.semiMinorAxis,
					0,
					2*Math.PI,
					false )
				context.stroke()
				context.closePath()

			"rectangle": ( _, context, renderable ) ->
				rectangle = renderable.resource

				context.fillStyle = rectangle.color || "rgb(255,255,255)"
				context.fillRect(
					renderable.position[ 0 ],
					renderable.position[ 1 ],
					rectangle.size[ 0 ],
					rectangle.size[ 1 ] )

			"rectangleOutline": ( _, context, renderable ) ->
				rectangle = renderable.resource

				context.strokeStyle = rectangle.color || "rgb(0,0,0)"
				context.strokeRect(
					renderable.position[ 0 ],
					renderable.position[ 1 ],
					rectangle.size[ 0 ],
					rectangle.size[ 1 ] )

			"line": ( _, context, renderable ) ->
				line = renderable.resource

				context.strokeStyle = line.color || "rgb(255,255,255)"
				context.beginPath()
				context.moveTo( line.start[ 0 ], line.start[ 1 ] )
				context.lineTo( line.end[ 0 ], line.end[ 1 ] )
				context.closePath()
				context.stroke()

			"text": ( _, context, renderable ) ->
				text = renderable.resource

				context.fillStyle = text.color || "rgb(0,0,0)"
				if text.font?
					context.font = text.font
				if text.bold?
					context.font = "bold #{ context.font }"
				context.fillText(
					text.string,
					renderable.position[ 0 ],
					renderable.position[ 1 ] )
				
		createDisplay: ->
			canvas  = document.getElementById( "canvas" )
			context = canvas.getContext( "2d" )

			# Setting up the coordinate system for the context. The goal here:
			# - (0,0) should be at the center of the canvas.
			# - Positive x should be to the right, positive y downwards.
			# - Each unit should be exactly one pixel.
			context.translate(
			 	canvas.width  / 2,
			 	canvas.height / 2 )
			
			display =
				context: context,
				size   : [ canvas.width, canvas.height ]

		createRenderable: ( type ) ->
			renderable =
				type       : type
				resourceId : null
				resource   : null
				position   : [ 0, 0 ]
				orientation: 0

		render: ( drawFunctions, display, renderData, renderables ) ->
			context = display.context

			width  = display.size[ 0 ]
			height = display.size[ 1 ]
			
			context.clearRect(
				-width  / 2,
				-height / 2,
				width,
				height )

			for renderable in renderables
				context.save()

				type = renderable.type
				drawRenderable = drawFunctions[ type ]
				drawRenderable( renderData[ type ], context, renderable )

				context.restore()
