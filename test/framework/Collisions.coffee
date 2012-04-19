Collisions = load( "Collisions" )

describe "Collisions", ->
	describe "buildPairs", ->
		it "should build all possible pairs of collision bodies", ->
			shapes =
				"a": {}
				"b": {}
				"c": {}

			pairs = Collisions.buildPairs( shapes )

			expect( pairs ).to.eql( [
				[ "a", "b" ]
				[ "a", "c" ]
				[ "b", "c" ] ] )

	describe "checkCollision", ->
		it "should detect a non-collision between two shapes", ->
			positionA = [ 0, 0 ]
			positionB = [ 4, 0 ]
			shapeA = Collisions.createCircle( 1 )
			shapeB = Collisions.createCircle( 2 )

			contact = Collisions.checkCollision(
				positionA,
				positionB,
				shapeA,
				shapeB )

			expect( contact.touches ).to.equal( false )

		it "should detect a collision between two shapes", ->
			positionA = [ 0, 0 ]
			positionB = [ 2.5, 0 ]
			shapeA = Collisions.createCircle( 1 )
			shapeB = Collisions.createCircle( 2 )

			contact = Collisions.checkCollision(
				positionA,
				positionB,
				shapeA,
				shapeB )

			expect( contact ).to.eql( {
				touches: true
				normal : [ 1, 0 ]
				depth  : 0.5
				point  : [ 0.75, 0 ] } )
