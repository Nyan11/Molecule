"
window spec after click on search in MolActionMenu
"
Class {
	#name : #SpMolSearch,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'models',
		'elements',
		'relation',
		'edges',
		'inspectable',
		'popup',
		'droplist',
		'label',
		'showComponent',
		'legend'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
SpMolSearch class >> defaultSpec [
	<spec: #default>
	^ SpBoxLayout newTopToBottom 
	 add: (SpBoxLayout newLeftToRight
			add: #label withConstraints: [ :c | c height: self toolbarHeight ];
			add: #droplist) withConstraints: [ :c | c height: self toolbarHeight ];
		add: #currentCanvas
	yourself.
]

{ #category : #specs }
SpMolSearch class >> open [
	<script: 'self new openWithSpec'>
]

{ #category : #initialization }
SpMolSearch >> configure: canvas [
	| icon |
	self models: SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
		
	self relation: [ :cls | cls dependentClasses ].
	self elements: models.
	
	canvas addAll: elements.
	"canvas addAll: shapes."
	
	self edges: RSEdgeBuilder line.
	edges canvas: canvas .
	edges connectToAll: relation.

	"color: '35978F'"
	canvas edges @ RSHighlightable red .
	canvas nodes @ RSHighlightable red withEdges.
	
	RSForceBasedLayout on: elements.
	
	inspectable := RSMolEvents new.
	
	icon := RSBitmap new 
		model: 'component'; 
		"form: (Smalltalk ui icons iconNamed: #systemIcon); "
		form: MolIcon new icon;
		size: 10.
		
	legend := MolLegend new. legend legend: RSLegend new container: canvas items:{icon} title: 'Shapes Legend' onDemand: 'Legend of graphic' .
	
	elements @ inspectable .
	canvas @ RSCanvasController.
	
]

{ #category : #initialization }
SpMolSearch >> connectPresenters [
	currentCanvas script: [ :canvas |
		self configure: canvas. ].
]

{ #category : #accessing }
SpMolSearch >> droplist: aDroplist [
	aDroplist
		label: 'Roassal Packages';
		items: models.
]

{ #category : #accessing }
SpMolSearch >> edges: someEdges [
	edges := someEdges.
	edges moveBehind.
	edges borderColor: '80CDC1'.
	edges withBorderAttachPoint.
]

{ #category : #accessing }
SpMolSearch >> elements [
	^elements
]

{ #category : #accessing }
SpMolSearch >> elements: someElements [
	elements := someElements collect: 
		[ :m | 
		|icon |
		icon := RSBitmap new 
		model:m; 
		"form: (Smalltalk ui icons iconNamed: #systemIcon); "
		form: MolIcon new icon;
		size: 10.
		self popup:m.
		icon @ RSDraggable @ popup
		 ] as: RSGroup. 
	
	
]

{ #category : #'as yet unclassified' }
SpMolSearch >> initialize [
	super initialize.
	
	
	
	
	
]

{ #category : #initialization }
SpMolSearch >> initializePresenters [
	| components |
			
	currentCanvas := self instantiate: SpRoassalPresenter.
	label := self instantiate: SpLabelPresenter.
	droplist := self instantiate: SpDropListPresenter.
	
	label label: 'select a component : '.
	
	components := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	showComponent := SpMolShowComponent new.

	droplist items: components.
	droplist	whenSelectedItemChangedDo: [:item | showComponent component: item. showComponent openWithSpec ].
]

{ #category : #initialization }
SpMolSearch >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: 'Search Components';
	initialExtent: 900@600.
			
		
]

{ #category : #accessing }
SpMolSearch >> models [
	^models 
]

{ #category : #accessing }
SpMolSearch >> models: someObjects select: aBlock [
	models := someObjects select: aBlock
	
]

{ #category : #accessing }
SpMolSearch >> popup: aComponent [

	| molPopup |
	
	molPopup := MolPopup new.
	popup := RSPopup new.
	molPopup popup: popup title: aComponent.
		
]

{ #category : #'as yet unclassified' }
SpMolSearch >> relation: aBlock [
	relation := aBlock
]