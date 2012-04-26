MainLoop = load( "MainLoop" )

describe "MainLoop", ->
	it "should execute the given function while callNextFrame keeps re-scheduling the function", ->
		numberOfSchedulings = 2
		callNextFrame = ( f ) ->
			while numberOfSchedulings > 0
				numberOfSchedulings -= 1
				f()

		getCurrentTimeInMs = -> 7000

		numberOfCalls = 0
		MainLoop.execute(
			->
				numberOfCalls += 1
			,
			callNextFrame,
			getCurrentTimeInMs )

		expect( numberOfCalls ).to.equal( 3 )

	it "should pass the current time and the passed time into the function (in seconds)", ->
		i = 0
		callNextFrame = ( f ) ->
			i += 1
			switch i
				when 1 then f( 9000 )
				when 2 then f( 9010 )

		getCurrentTimeInMs = -> 8090

		lastCurrentTimeInS = null
		lastPassedTimeInS  = null
		MainLoop.execute(
			( currentTimeInS, passedTimeInS ) ->
				lastCurrentTimeInS = currentTimeInS
				lastPassedTimeInS  = passedTimeInS
			,
			callNextFrame,
			getCurrentTimeInMs )

		expect( lastCurrentTimeInS ).to.equal( 9.01 )
		expect( lastPassedTimeInS  ).to.equal( 0.01 )

	it "should pass zero as passed time in the first iteration", ->
		callNextFrame = ->
		getCurrentTimeInMs = -> 8000

		firstCurrentTimeInS = null
		firstPassedTimeInS  = null
		MainLoop.execute(
			( currentTimeInS, passedTimeInS ) ->
				firstCurrentTimeInS = currentTimeInS
				firstPassedTimeInS  = passedTimeInS
			,
			callNextFrame,
			getCurrentTimeInMs )

		expect( firstCurrentTimeInS ).to.equal( 8 )
		expect( firstPassedTimeInS  ).to.equal( 0 )

	it "should never call with a passed time equivalent to greater than 30 Hz, no matter how much time has passed", ->
		i = 0
		callNextFrame = ( f ) ->
			i += 1
			switch i
				when 1 then f( 8000 )
				when 2 then f( 9000 )

		getCurrentTimeInMs = -> 8000

		thePassedTimeInS = null
		MainLoop.execute(
			( currentTimeInS, passedTimeInS ) ->
				thePassedTimeInS  = passedTimeInS
			,
			callNextFrame,
			getCurrentTimeInMs )

		expect( thePassedTimeInS ).to.equal( 1 / 30 )
