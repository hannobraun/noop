define "Collisions", [ "Vec2" ], ( Vec2 ) ->
	module =
		createCircle: ( radius ) ->
			shape =
				type  : "circle"
				radius: radius

		buildPairs: ( shapes ) ->
			entityUsed = {}
			pairs = []

			for entityIdA, shapeA of shapes
				entityUsed[ entityIdA ] = true
				for entityIdB, shapeB of shapes
					unless entityUsed[ entityIdB ]
						pairs.push( [ entityIdA, entityIdB ] )

			pairs

		checkCollision: ( positionA, positionB, shapeA, shapeB ) ->
			sumOfRadii = shapeA.radius + shapeB.radius

			d = Vec2.copy( positionB )
			Vec2.subtract( d, positionA )

			distance = Vec2.length( d )

			collision = sumOfRadii >= distance

			if collision
				normal = Vec2.copy( d )
				Vec2.unit( normal )

				penetrationDepth = sumOfRadii - distance

				point = Vec2.copy( normal )
				Vec2.scale( point, shapeA.radius - penetrationDepth / 2 )
				Vec2.add( point, positionA )

				{
					touches: collision
					normal : normal
					depth  : penetrationDepth
					point  : point }
			else
				{ touches: collision }				
