module "VelocityVerletIntegratorTest", [ "Physics", "VelocityVerletIntegrator" ], ( Physics, VelocityVerletIntegrator ) ->
	describe "VelocityVerletIntegrator", ->
		it "should perform a velocity verlet integration", ->
			body = Physics.createBody()
			body.position     = [   1,   -1 ]
			body.velocity     = [  10,  -10 ]
			body.acceleration = [ 400, -400 ]

			body.mass = 2

			body.forces.push( [ 400, -400 ] )

			VelocityVerletIntegrator.integrate( [ body ], 0.1 )

			expect( body.position      ).to.eql( [   4,   -4 ] )
			expect( body.velocity      ).to.eql( [  40,  -40 ] )
			expect( body.acceleration  ).to.eql( [ 200, -200 ] )
			expect( body.forces.length ).to.equal( 0 )

load( "VelocityVerletIntegratorTest" )
