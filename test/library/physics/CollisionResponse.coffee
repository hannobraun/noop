Physics           = load( "Physics" )
CollisionResponse = load( "CollisionResponse" )

describe "CollisionResponse", ->
	describe "handleContacts", ->
		parameters =
			k: 100
			b: 5

		it "should apply spring forces to the bodies in contact", ->
			bodyA = Physics.createBody()
			bodyB = Physics.createBody()
			bodyA.velocity = [  1, 0 ]
			bodyB.velocity = [ -1, 1 ]

			bodies =
				"bodyA": bodyA
				"bodyB": bodyB

			contact =
				bodyIds: [ "bodyA", "bodyB" ]
				normal : [ 1, 0 ]
				depth  : 0.5
				point  : [ 0, 0 ]

			CollisionResponse.handleContacts(
				[ contact ],
				bodies,
				parameters )

			expect( bodyA.forces ).to.eql( [ [ -20, 0 ] ] )
			expect( bodyB.forces ).to.eql( [ [  20, 0 ] ] )
