"
I am an exemple of client which uses the services and can change parameters of a socket component. My services and parameters are defined by the corresponding traits.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyClientComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyClientComponent',
	#classTraits : 'MolMyClientComponent classTrait',
	#category : #'Molecule-Tests-Parameters Resources'
}

{ #category : #services }
MolMyClientComponentImpl >> connect [

	^ self getMolMySocketServicesProvider connect
]

{ #category : #services }
MolMyClientComponentImpl >> disconnect [

	^ self getMolMySocketServicesProvider disconnect
]

{ #category : #'component accessing' }
MolMyClientComponentImpl >> getMolMySocketParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolMySocketParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [self error:'parameters not found'].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolMySocketParameters named:  parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolMyClientComponentImpl >> getMolMySocketServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolMySocketServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [self error:'Services not found'].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMySocketServices named:  servicesSymbol]. 
	^servicesProvider
]

{ #category : #services }
MolMyClientComponentImpl >> send: aMessage [

	^ self getMolMySocketServicesProvider send: aMessage
]

{ #category : #parameters }
MolMyClientComponentImpl >> setIp: anIpAddress [

	^ self getMolMySocketParametersProvider setIp: anIpAddress 
]

{ #category : #parameters }
MolMyClientComponentImpl >> setPort: aPort [

	^ self getMolMySocketParametersProvider setPort: aPort 
]

{ #category : #parameters }
MolMyClientComponentImpl >> setProtocol: aProtocl [

	^ self getMolMySocketParametersProvider setProtocol: aProtocl 
]