define "EulerIntegrator", [], ->
	module =
		integrate: ( bodies, passedTimeInS ) ->
			for entityId, body of bodies
				newAcceleration = [ 0, 0 ]
				for force in body.forces
					Vec2.scale( force, 1 / body.mass )
					Vec2.add( newAcceleration, force )
				body.forces.length = 0

				body.acceleration = newAcceleration

				velocityChange = Vec2.copy( body.acceleration )
				Vec2.scale( velocityChange, passedTimeInS )
				Vec2.add( body.velocity, velocityChange )

				positionChange = Vec2.copy( body.velocity )
				Vec2.scale( positionChange, passedTimeInS )
				Vec2.add( body.position, positionChange )
