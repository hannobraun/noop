module "PhysicsTest", [ "Physics" ], ( Physics ) ->
	describe "Physics", ->
		describe "integrateOrientation", ->
			it "should integrate the orientation", ->
				body = Physics.createBody()
				body.angularVelocity = 10

				Physics.integrateOrientation( [ body ], 0.1 )

				expect( body.orientation ).to.equal( 1 )

load( "PhysicsTest" )
