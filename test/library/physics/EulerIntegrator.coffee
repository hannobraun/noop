Physics         = load( "Physics" )
EulerIntegrator = load( "EulerIntegrator" )

describe "EulerIntegrator", ->
	it "should perform an euler integration", ->
		body = Physics.createBody()
		body.position     = [  1,  -1 ]
		body.velocity     = [ 10, -10 ]
		body.acceleration = [ 20, -20 ]

		body.mass = 2

		body.forces.push( [ 200, -200 ] )

		EulerIntegrator.integrate( [ body ], 0.1 )

		expect( body.position      ).to.eql( [   3,   -3 ] )
		expect( body.velocity      ).to.eql( [  20,  -20 ] )
		expect( body.acceleration  ).to.eql( [ 100, -100 ] )
		expect( body.forces.length ).to.equal( 0 )
