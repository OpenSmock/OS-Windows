"
Native Windows Clipboard
"
Class {
	#name : #WinClipboard,
	#superclass : #WinHandle,
	#pools : [
		'WinBaseConstants',
		'WinClipboardTypes',
		'WinTypes',
		'WinUserConstants'
	],
	#classInstVars : [
		'clipboardFormats',
		'cf_html'
	],
	#category : #'OS-Windows-OpenSmock-Clipboard'
}

{ #category : #constants }
WinClipboard class >> CF_BITMAP [

	^ 2
]

{ #category : #constants }
WinClipboard class >> CF_DIB [

	^ 8
]

{ #category : #constants }
WinClipboard class >> CF_DIBV5 [

	^ 17
]

{ #category : #constants }
WinClipboard class >> CF_DIF [

	^ 5
]

{ #category : #constants }
WinClipboard class >> CF_ENHMETAFILE [

	^ 14
]

{ #category : #constants }
WinClipboard class >> CF_HDROP [

	^ 15
]

{ #category : #constants }
WinClipboard class >> CF_HTML [

	cf_html ifNil: [
		cf_html := self getAndRegisterClipboardFormat: self format_HTML ].
	^ cf_html
]

{ #category : #constants }
WinClipboard class >> CF_LOCALE [

	^ 16
]

{ #category : #constants }
WinClipboard class >> CF_METAFILEPICT [

	^ 3
]

{ #category : #constants }
WinClipboard class >> CF_OEMTEXT [

	^ 7
]

{ #category : #constants }
WinClipboard class >> CF_PENDATA [

	^ 10
]

{ #category : #constants }
WinClipboard class >> CF_TEXT [

	^ 1
]

{ #category : #constants }
WinClipboard class >> CF_UNICODETEXT [

	^ 13
]

{ #category : #constants }
WinClipboard class >> CF_WAVE [

	^ 12
]

{ #category : #constants }
WinClipboard class >> GMEM_MOVEABLE [

	^ 16r0002
]

{ #category : #private }
WinClipboard class >> addClipboardByteData: aByteArray withFormat: aFormat [

	| out array outm |
	self openClipboard.
	out := self
		       globalAlloc: WinClipboard GMEM_MOVEABLE
		       size: aByteArray size.
	array := aByteArray ifNil: [ 
		         self closeClipboard.
		         ^ false ].
	array := array asByteArray.
	outm := self globalLock: out.
	outm
		replaceFrom: 1 to: array size with: array startingAt: 1.
	"	copyAt: 0
		from: array
		size: array size
		startingAt: 1."
	"outm copyFrom: 1 to: 4."
	self globalUnlock: out.
	self setClipboardTextData: aFormat value: out.
	self closeClipboard.
	^ true
]

{ #category : #private }
WinClipboard class >> cleanUp: anObject [

	super cleanUp: anObject.
	self resetClipboard.
]

{ #category : #'api - utils' }
WinClipboard class >> clearClipboard [
	<script>

	self openClipboard.
	self emptyClipboard.
	self closeClipboard
]

{ #category : #private }
WinClipboard class >> clipboardConcreteTypes [
	"Return a list a enumerated types into the current clipboard"
	<script: 'WinClipboard clipboardConcreteTypes inspect'>

	| types |
	types := Dictionary new.
	self clipboardTypes do: [ :e | types at: (self perform: e) put: e ].
	^types
]

{ #category : #private }
WinClipboard class >> clipboardDataValue: aDatum id: anId [
	"Get clipboard content"

	aDatum ifNil:[ ^ nil ].
	aDatum isNull ifTrue: [ ^ nil ].
	
	anId = self CF_TEXT ifTrue:[
		^ aDatum bytesFromCString utf8Decoded
	].

	anId = self CF_HTML ifTrue:[
		^ aDatum bytesFromCString utf8Decoded
	].

	anId = self CF_HDROP ifTrue:[
		^ aDatum readStream
	].

	^ aDatum readStream
]

{ #category : #private }
WinClipboard class >> clipboardTypes [

	^ #( #CF_BITMAP  #CF_DIB  #CF_DIBV5  #CF_DIF  #CF_ENHMETAFILE
	      #CF_HDROP  #CF_HTML  #CF_LOCALE  #CF_METAFILEPICT
	      #CF_OEMTEXT  #CF_PENDATA  #CF_TEXT  #CF_UNICODETEXT
	      #CF_WAVE )
]

{ #category : #'api - utils' }
WinClipboard class >> closeClipboard [
	<script>

	^ self
		ffiCall: #( BOOL CloseClipboard #(  ) )
		module: #user32
]

{ #category : #private }
WinClipboard class >> convertStringToSVG: aString [
	"Use an existing system library to convert String into a SVG"

	"Bloc SVG library"
	(Smalltalk hasClassNamed: #BlSvgConverter) ifTrue:[
		^ BlSvgConverter convertFromString: aString
	].

	^ nil
]

{ #category : #'api - utils' }
WinClipboard class >> currentClipboardEntries [
	"Return a list of entries for the current clipboard"
	<script: 'WinClipboard currentClipboardEntries inspect'>

	| base stop oc types |
	oc := OrderedCollection new.
	base := 0.
	stop := false.
	types := self clipboardConcreteTypes.
	
	self openClipboard.
	[ stop ] whileFalse: [
		base := self enumClipboardFormats: base.
		base = 0 ifTrue: [ 
			stop := true. 
		] ifFalse: [ | entry | 
			entry := WinClipboardEntry new.
			entry id: base.
			entry isSupported: (types includesKey: base).
			entry isSupported ifFalse:[ | type |
				"Try to get the type by the registered list"
				type := self getRegisteredClipboardFormatFromId: base.
				type ifNotNil:[ 
					entry isSupported: true.
					entry type: type.
				]. 
			].
			
			entry isSupported ifTrue:[
				entry type ifNil:[ entry type: (types at: base) ].
				entry datum: (self getClipboardData: base).
				entry data: (self clipboardDataValue: (entry datum) id: base).
			].
			oc add: entry.
		].
	].
	self closeClipboard. 
	^ oc
]

{ #category : #accessing }
WinClipboard class >> currentClipboardFormatIDs [
	"Return a list a numeric types into the current clipboard"
	<script: 'WinClipboard currentClipboardFormatIDs inspect'>

	| base stop oc |
	self openClipboard.
	base := 0.
	stop := false.
	oc := OrderedCollection new.
	[ stop ] whileFalse: [
		base := WinClipboardFormat enumClipboardFormats: base.
		base = 0
			ifTrue: [ stop := true ]
			ifFalse: [ oc add: base ] ].
	self closeClipboard.
	^ oc
]

{ #category : #'api - utils' }
WinClipboard class >> currentClipboardTypes [
	"Return a list a numeric types into the current clipboard"
	<script: 'WinClipboard currentClipboardTypes inspect'>

	| base arret oc |
	self openClipboard.
	base := 0.
	arret := false.
	oc := OrderedCollection new.
	[ arret ] whileFalse: [
		base := self enumClipboardFormats: base.
		base = 0
			ifTrue: [ arret := true ]
			ifFalse: [ oc add: base ] ].
	self closeClipboard.
	^ oc
]

{ #category : #'api - utils' }
WinClipboard class >> emptyClipboard [
	<script>

	^ self
		ffiCall: #( BOOL EmptyClipboard #(  ) )
		module: #user32
]

{ #category : #private }
WinClipboard class >> enumClipboardFormats: aFormat [

	^ self
		  ffiCall: #( UINT EnumClipboardFormats #( UINT aFormat ) )
		  module: #user32
]

{ #category : #private }
WinClipboard class >> findToken: aToken in: aString [

	| list elem |
	list := aString lines.
	list := list select: [:e | '*' , aToken , '*' match: e].
	list size > 0 ifFalse: [^nil].
	elem := list first splitOn: ':'.
	^elem last asNumber
]

{ #category : #format }
WinClipboard class >> format_HTML [

	^ 'HTML Format'
]

{ #category : #format }
WinClipboard class >> format_imageSvgXml [

	^ 'image/svg+xml'
]

{ #category : #format }
WinClipboard class >> format_imageXInkscapeSvg [

	^ 'image/x-inkscape-svg'
]

{ #category : #private }
WinClipboard class >> getAndRegisterClipboardFormat: aFormat [

	| f |
	f := self registerClipboardFormat: aFormat.
	self registeredClipboardFormats at: aFormat put: f.
	^ f
]

{ #category : #private }
WinClipboard class >> getByteClipboardData: aType [

	| datum val length |
	self openClipboard.
	datum := self getClipboardData: aType.
	length := self globalSize: datum.
	"chunk := ByteArray new: length."
	val := datum isNull not
		ifFalse: [ nil ]
		ifTrue: [ 
			datum copyFrom: 1 to: length
			"copyAt: 0
						to: chunk
						size: length
						startingAt: 1."
			"val := chunk" ].
	self closeClipboard.
	^ val
]

{ #category : #private }
WinClipboard class >> getByteClipboardDataFrom: aStringType [

	| type |
	type := self getAndRegisterClipboardFormat: aStringType.
	^self getByteClipboardData: type
]

{ #category : #private }
WinClipboard class >> getClipboardData: aFormat [

	^ self
		  ffiCall: #( void * GetClipboardData #( UINT aFormat ) )
		  module: #user32
]

{ #category : #'api - HTML' }
WinClipboard class >> getHTMLClipboardData [
	<script: 'self getHTMLClipboardData inspect'>
	| datum aStringOrNil |
	self openClipboard.
	datum := self getClipboardData: self CF_HTML.
	aStringOrNil := self clipboardDataValue: datum id: self CF_HTML.
	self closeClipboard.
	^ aStringOrNil
]

{ #category : #'api - HTML' }
WinClipboard class >> getHTMLClipboardDataContent [
	<script: 'self getHTMLClipboardDataContent inspect'>

	| string index lastIndex |
	string := self getHTMLClipboardData.
	string ifNil:[ ^nil ].
	index := self findToken: 'StartFragment' in: string.
	lastIndex := self findToken: 'EndFragment' in: string.
	lastIndex ifNotNil: [ string := string first: lastIndex ].
	index ifNotNil: [ string := string allButFirst: index ].
	^ string
]

{ #category : #'api - bitmap image' }
WinClipboard class >> getPNGClipboardData [
	<script: 'self getPNGClipboardData inspect'>

	^ self getByteClipboardDataFrom: 'PNG'
]

{ #category : #private }
WinClipboard class >> getRegisteredClipboardFormatFromId: anId [

	self registeredClipboardFormats keysAndValuesDo: [ :type :id | id = anId ifTrue:[ ^ type ] ].
	^ nil
]

{ #category : #'api - text' }
WinClipboard class >> getTextClipboardData [

	<script: 'self getTextClipboardData inspect'>
	| datum aStringOrNil |
	self openClipboard.
	datum := self getClipboardData: self CF_TEXT.
	aStringOrNil := self clipboardDataValue: datum id: self CF_TEXT.
	self closeClipboard.
	^ aStringOrNil
]

{ #category : #private }
WinClipboard class >> globalAlloc: flags size: bytes [
	^self ffiCall: #(void* GlobalAlloc(UINT flags, SIZE_T bytes)) module: #kernel32
]

{ #category : #private }
WinClipboard class >> globalLock: hMem [
	^self ffiCall: #(LPVOID GlobalLock(void* hMem)) module: #kernel32
]

{ #category : #private }
WinClipboard class >> globalSize: hMem [
	^self ffiCall: #(SIZE_T GlobalSize(void* hMem)) module: #kernel32
]

{ #category : #private }
WinClipboard class >> globalUnlock: hMem [
	^self ffiCall: #(LPVOID GlobalUnlock(void* hMem)) module: #kernel32
]

{ #category : #'api - utils' }
WinClipboard class >> openClipboard [
	<script>

	self registerClipboardFormat.
	^ self openClipboard: (ExternalAddress fromAddress: 0)
]

{ #category : #private }
WinClipboard class >> openClipboard: aHwnd [
	<script>

	^ self
		  ffiCall: #( bool OpenClipboard #( HWND aHwnd ) )
		  module: #user32
]

{ #category : #'api - bitmap image' }
WinClipboard class >> pasteImageFromDIB [
	<script: 'self pastePNGFromDIB inspect'>

	| bytes |
	bytes := self getByteClipboardData: self CF_DIB.
	bytes
		ifNil: [ ^ nil ]
		ifNotNil: [ ^ self halt:'todo' ]
]

{ #category : #'api - bitmap image' }
WinClipboard class >> pasteImageFromHDROP [
	<script: 'self pasteImageFromHDROP inspect'>

	| bytes |
	bytes := self getByteClipboardData: self CF_HDROP.
	bytes
		ifNil: [ ^ nil ]
		ifNotNil: [ ^ ImageReadWriter formFromStream: bytes readStream ]
]

{ #category : #'api - bitmap image' }
WinClipboard class >> pastePNGFromClipboard [
	<script: 'self pastePNGFromClipboard inspect'>

	| bytes |
	bytes := self getByteClipboardDataFrom: 'PNG'.
	bytes
		ifNil: [ ^ self pasteImageFromHDROP ]
		ifNotNil: [ ^ ImageReadWriter formFromStream: bytes readStream ]
]

{ #category : #'api - SVG' }
WinClipboard class >> pasteSVGFromClipboard [
	<script: 'self pasteSVGFromClipboard inspect'>

	| data |
	data := self getByteClipboardDataFrom: self format_imageSvgXml.
	data ifNil: [ data := self getByteClipboardDataFrom: self format_imageXInkscapeSvg ].
	data ifNil: [ ^ nil ].
	data := data utf8Decoded.
	^ self convertStringToSVG: data
]

{ #category : #'api - utils' }
WinClipboard class >> registerClipboardFormat [
	<script>

	self getAndRegisterClipboardFormat: self format_HTML.
	self getAndRegisterClipboardFormat: self format_imageSvgXml.
	self getAndRegisterClipboardFormat: self format_imageXInkscapeSvg.
]

{ #category : #private }
WinClipboard class >> registerClipboardFormat: aString [

	^ self
		  ffiCall: #( UINT RegisterClipboardFormatA #( LPTSTR aString ) )
		  module: #user32
]

{ #category : #private }
WinClipboard class >> registeredClipboardFormats [

	clipboardFormats ifNil: [ clipboardFormats := Dictionary new ].
	^ clipboardFormats
]

{ #category : #private }
WinClipboard class >> resetClipboard [

	cf_html := nil.
	clipboardFormats := nil
]

{ #category : #private }
WinClipboard class >> setByteClipboardData: aIntType value: aByteArray [
"WinClipboard setClipboardByteData: 15 value: #(55 55 55)"

	^self setClipboardByteData: aByteArray withFormat: aIntType
]

{ #category : #private }
WinClipboard class >> setClipboardByteData: aByteArray withFormat: aFormat [

	self clearClipboard.
	^self addClipboardByteData: aByteArray withFormat: aFormat
]

{ #category : #private }
WinClipboard class >> setClipboardTextData: aFormat value: aString [

	^ self
		  ffiCall: #(void* SetClipboardData( UINT aFormat, char* aString))
		  module: #user32
]

{ #category : #private }
WinClipboard class >> setPNGByteClipboardData: aByteArray [

	| type |
	type := self getAndRegisterClipboardFormat: 'PNG'.
	^self setByteClipboardData: type value: aByteArray
]

{ #category : #'see class side' }
WinClipboard >> seeClassSide [
]
