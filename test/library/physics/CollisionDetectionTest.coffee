module "CollisionDetectionTest", [ "Physics", "CollisionDetection" ], ( Physics, CollisionDetection ) ->
	describe "CollisionDetection", ->
		describe "buildPairs", ->
			it "should build all possible pairs of collision bodies", ->
				shapes =
					"a": {}
					"b": {}
					"c": {}

				pairs = CollisionDetection.buildPairs( shapes )

				expect( pairs ).to.eql( [
					[ "a", "b" ]
					[ "a", "c" ]
					[ "b", "c" ] ] )

		describe "checkCollision", ->
			bodyA = null
			bodyB = null

			shapeA = CollisionDetection.createCircle( 1 )
			shapeB = CollisionDetection.createCircle( 2 )

			beforeEach ->
				bodyA = Physics.createBody()
				bodyB = Physics.createBody()

			it "should detect a non-collision between two shapes", ->
				bodyA.position = [ 0, 0 ]
				bodyB.position = [ 4, 0 ]

				contacts = CollisionDetection.checkCollisions(
					[ [ 0, 1 ] ],
					[ bodyA, bodyB ],
					[ shapeA, shapeB ] )

				expect( contacts.length ).to.equal( 0 )

			it "should detect a collision between two shapes", ->
				bodyA.position = [ 0, 0 ]
				bodyB.position = [ 2.5, 0 ]

				contacts = CollisionDetection.checkCollisions(
					[ [ 0, 1 ] ],
					[ bodyA, bodyB ],
					[ shapeA, shapeB ] )

				expect( contacts.length ).to.equal( 1 )
				expect( contacts[ 0 ] ).to.eql( {
					bodyIds: [ 0, 1 ]
					normal : [ 1, 0 ]
					depth  : 0.5
					point  : [ 0.75, 0 ] } )

			it "should onlyl check shapes from the list of potential pairs", ->
				bodyA.position = [ 0, 0 ]
				bodyB.position = [ 2.5, 0 ]

				contacts = CollisionDetection.checkCollisions(
					[],
					[ bodyA, bodyB ],
					[ shapeA, shapeB ] )

				expect( contacts.length ).to.equal( 0 )

load( "CollisionDetectionTest" )
