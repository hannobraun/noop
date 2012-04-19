define "Entities", [], ->
	module =
		createEntity: ( factories, components, type, args ) ->
			entity = factories[ type ]( args )
			for componentName, component of entity.components
				components[ componentName ][ entity.id ] = component

		destroyEntity: ( components, entityId ) ->
			for componentType, componentMap of components
				delete componentMap[ entityId ]
