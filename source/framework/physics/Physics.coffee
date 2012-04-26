define "Physics", [ "Vec2" ], ( Vec2 ) ->
	module =
		parameters:
			collisionResponse:
				k: 10000
				b: 0

		createBody: ->
			body =
				position    : [ 0, 0 ]
				velocity    : [ 0, 0 ]
				acceleration: [ 0, 0 ]

				orientation    : 0
				angularVelocity: 0

				forces: []
				mass  : 1

		integrateOrientation: ( bodies, passedTimeInS ) ->
			for entityId, body of bodies
				body.orientation += body.angularVelocity * passedTimeInS

		applyForces: ( bodies ) ->
			for entityId, body of bodies
				body.acceleration = [ 0, 0 ]

				for force in body.forces
					Vec2.scale( force, 1 / body.mass )
					Vec2.add( body.acceleration, force )

				body.forces.length = 0

		update: ( bodies, passedTimeInS, integrate ) ->
			integrate( bodies, passedTimeInS )
			module.integrateOrientation( bodies, passedTimeInS )
			module.applyForces( bodies )
