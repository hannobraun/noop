module "VelocityVerletIntegrator", [], ->
	module =
		integrate: ( bodies, passedTimeInS ) ->
			for entityId, body of bodies
				newAcceleration = [ 0, 0 ]
				for force in body.forces
					Vec2.scale( force, 1 / body.mass )
					Vec2.add( newAcceleration, force )
				body.forces.length = 0


				movementFromVelocity = Vec2.copy( body.velocity )
				Vec2.scale( movementFromVelocity, passedTimeInS )

				movementFromAcceleration = Vec2.copy( body.acceleration )
				Vec2.scale( movementFromAcceleration, 0.5 )
				Vec2.scale(
					movementFromAcceleration,
					passedTimeInS*passedTimeInS )

				Vec2.add( body.position, movementFromVelocity )
				Vec2.add( body.position, movementFromAcceleration )


				velocityChange = Vec2.copy( body.acceleration )
				Vec2.add( velocityChange, newAcceleration )
				Vec2.scale( velocityChange, 0.5 )
				Vec2.scale( velocityChange, passedTimeInS )
				Vec2.add( body.velocity, velocityChange )


				body.acceleration = newAcceleration
