Entities = load( "Entities" )

describe "Entities", ->
	describe "createEntity", ->
		it "should pass the creation arguments to the entity factory", ->
			args         = { a: "a", b: "b" }
			receivedArgs = undefined

			entityFactories =
				"myEntity": ( args ) ->
					receivedArgs = args

			Entities.createEntity( entityFactories, {}, "myEntity", args )

			expect( receivedArgs ).to.eql( args )

		it "should sort the returned components into the appropriate containers", ->
			id = "myId"
			componentA = {}
			componentB = {}

			components =
				"componentA": {}
				"componentB": {}

			entityFactories =
				"myEntity": ( args ) ->
					entity =
						id: id
						components:
							"componentA": componentA
							"componentB": componentB

			Entities.createEntity( entityFactories, components, "myEntity", {} )

			expect( components[ "componentA" ][ id ] ).to.be( componentA )
			expect( components[ "componentB" ][ id ] ).to.be( componentB )

	describe "destroyEntity", ->
		it "should remove an entity from the component containers", ->
			gameState =
				"componentA":
					"a": {}
					"b": {}
				"componentB":
					"a": {}
					"c": {}

			Entities.destroyEntity( gameState, "a" )

			expectedGameState =
				"componentA":
					"b": {}
				"componentB":
					"c": {}
			expect( gameState ).to.eql( expectedGameState )
