Physics = load( "Physics" )

describe "Physics", ->
	describe "integrateOrientation", ->
		it "should integrate the orientation", ->
			body = Physics.createBody()
			body.angularVelocity = 10

			Physics.integrateOrientation( [ body ], 0.1 )

			expect( body.orientation ).to.equal( 1 )

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
				bodies: [ "bodyA", "bodyB" ]
				normal: [ 1, 0 ]
				depth : 0.5
				point : [ 0, 0 ]

			Physics.handleContacts(
				[ contact ],
				bodies,
				parameters )

			expect( bodyA.forces ).to.eql( [ [ -20, 0 ] ] )
			expect( bodyB.forces ).to.eql( [ [  20, 0 ] ] )
