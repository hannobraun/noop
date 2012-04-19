define "Vec2", [], ->
	module =
		copy: ( v ) ->
			[ v[ 0 ], v[ 1 ] ]

		scale: ( v, s ) ->
			v[ 0 ] *= s
			v[ 1 ] *= s

		add: ( v1, v2 ) ->
			v1[ 0 ] += v2[ 0 ]
			v1[ 1 ] += v2[ 1 ]

		subtract: ( v1, v2 ) ->
			v1[ 0 ] -= v2[ 0 ]
			v1[ 1 ] -= v2[ 1 ]

		dot: ( v1, v2 ) ->
			v1[ 0 ]*v2[ 0 ] + v1[ 1 ]*v2[ 1 ]

		length: ( v ) ->
			Math.sqrt( v[ 0 ]*v[ 0 ] + v[ 1 ]*v[ 1 ] )

		squaredLength: ( v ) ->
			v[ 0 ]*v[ 0 ] + v[ 1 ]*v[ 1 ]

		unit: ( v ) ->
			length = module.length( v )
			v[ 0 ] /= length
			v[ 1 ] /= length

		applyTransform: ( v, t ) ->
			[ x, y ] = v
			v[ 0 ] = x*t[ 0 ][ 0 ] + y*t[ 0 ][ 1 ] + 1*t[ 0 ][ 2 ]
			v[ 1 ] = x*t[ 1 ][ 0 ] + y*t[ 1 ][ 1 ] + 1*t[ 1 ][ 2 ]
