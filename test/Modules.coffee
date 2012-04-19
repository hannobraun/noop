describe "Modules", ->
	beforeEach ->
		delete window.modules
	
	it "should define a simple module without dependencies", ->
		moduleLoaded = false
		define "Module", [], ->
			moduleLoaded = true

		load( "Module" )

		expect( moduleLoaded ).to.equal( true )

	it "should pass a module's dependency into a module", ->
		dependencyModule = ""

		define "Dependency", [], ->
			"dependency"

		define "Module", [ "Dependency" ], ( Dependency ) ->
			dependencyModule = Dependency

		load( "Module" )

		expect( dependencyModule ).to.equal( "dependency" )

	it "should load every module only once", ->
		timesLoaded = 0

		define "Dependency", [], ->
			timesLoaded += 1

		define "ModuleA", [ "Dependency" ], ->

		define "ModuleB", [ "Dependency" ], ->

		define "MainModule", [ "ModuleA", "ModuleB" ], ->

		load( "MainModule" )

		expect( timesLoaded ).to.equal( 1 )

	it "should throw an error, if two modules are defined with the same id", ->
		define "Module", [], ->

		caughtError = try
			define "Module", [], ->
			false
		catch error
			true

		expect( caughtError ).to.equal( true )

	it "should throw a nice error message, if a a module is loaded that doesn't exist", ->
		define "Module", [], ->

		error = try
			load( "NonExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "NonExistingModule" )

	it "should throw a nice error message, if a dependency does not exist", ->
		define "ExistingModule", [ "NonExistingModule" ], ->

		error = try
			load( "ExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "ExistingModule" )
		expect( error ).to.contain( "NonExistingModule" )
