module "CollisionResponse", [ "Vec2" ], ( Vec2 ) ->
	module =
		handleContacts: ( contacts, bodies, parameters ) ->
			k = parameters.k # spring constant
			b = parameters.b # damping constant

			for contact in contacts
				bodyA = bodies[ contact.bodyIds[ 0 ] ]
				bodyB = bodies[ contact.bodyIds[ 1 ] ]

				relativeVelocity = Vec2.copy( bodyA.velocity )
				Vec2.subtract( relativeVelocity, bodyB.velocity )

				spring = Vec2.copy( contact.normal )
				Vec2.scale(
					spring,
					-k * contact.depth )

				damping = Vec2.copy( contact.normal )
				Vec2.scale(
					damping,
					b * Vec2.dot( contact.normal, relativeVelocity ) )

				force = Vec2.copy( spring )
				Vec2.add( force, damping )
				Vec2.scale( force, 0.5 )

				negativeForce = Vec2.copy( force )
				Vec2.scale( negativeForce, -1 )

				bodyA.forces.push( force )
				bodyB.forces.push( negativeForce )
