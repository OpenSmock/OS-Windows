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

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_BITMAP [
^2
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_DIB [
^8
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_DIBV5 [
^17
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_DIF [
^5
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_ENHMETAFILE [
^14
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_HDROP [
^15
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_HTML [

	cf_html isNil
		ifTrue: [cf_html := self getRegisteredClipboardFormat: 'HTML Format'].
	^cf_html
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_LOCALE [
^16
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_METAFILEPICT [
^3
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_OEMTEXT [
^7
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_PENDATA [
^10
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_TEXT [
^1
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_UNICODETEXT [
^13
]

{ #category : #'as yet unclassified' }
WinClipboard class >> CF_WAVE [
^12
]

{ #category : #'as yet unclassified' }
WinClipboard class >> GMEM_MOVEABLE [
^16r0002
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
WinClipboard class >> clearClipboard [
<script>
	self openClipboard.
	self emptyClipboard.
	self closeClipboard.
]

{ #category : #'as yet unclassified' }
WinClipboard class >> clipboardTypes [

	^ #( #CF_BITMAP  #CF_DIB  #CF_DIBV5  #CF_DIF  #CF_ENHMETAFILE
	      #CF_HDROP  #CF_HTML  #CF_LOCALE  #CF_METAFILEPICT
	      #CF_OEMTEXT  #CF_PENDATA  #CF_TEXT  #CF_UNICODETEXT
	      #CF_WAVE )
]

{ #category : #'as yet unclassified' }
WinClipboard class >> closeClipboard [
<script> 
	^self ffiCall: #(BOOL CloseClipboard()) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> emptyClipboard [
<script> 
	^self ffiCall: #(BOOL EmptyClipboard()) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> enumClipboardFormats: aFormat [
	^self ffiCall: #(UINT EnumClipboardFormats(UINT aFormat)) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> enumClipboardTypes [
<script: 'WinClipboard enumClipboardTypes inspect'>
	| base arret oc |
	WinClipboard openClipboard.
	base := 0.
	arret := false.
	oc := OrderedCollection new.
	[ arret ] whileFalse: [ 
		base := WinClipboard enumClipboardFormats: base.
		base = 0
			ifTrue: [ arret := true ]
			ifFalse: [ oc add: base ] ].
	WinClipboard closeClipboard.
	^ oc
]

{ #category : #'as yet unclassified' }
WinClipboard class >> enumConcreteClipboardTypes [

	<script: 'WinClipboard enumConcreteClipboardTypes inspect'>
| oc types | 
oc := self enumClipboardTypes.
types := Dictionary new.
self clipboardTypes do: [ :e | types at: (self perform: e) put: e ].
oc := oc collect: [ :e | (types includesKey: e) ifTrue: [ types at: e ]  ifFalse: [ e ] ].
^oc
]

{ #category : #'as yet unclassified' }
WinClipboard class >> findToken: aToken in: aString [

	| list elem |
	list := aString getLines.
	list := list select: [:e | '*' , aToken , '*' match: e].
	list size > 0 ifFalse: [^nil].
	elem := list first splitOn: ':'.
	^elem last asNumber
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
WinClipboard class >> getByteClipboardDataFrom: aStringType [

	| type |
	type := self getRegisteredClipboardFormat: aStringType.
	^self getByteClipboardData: type
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getClipboardData: aFormat [
	^self ffiCall: #(void* GetClipboardData( UINT aFormat)) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getHTMLClipboardData [
	<script: 'self getHTMLClipboardData inspect'>
	| datum val |
	self openClipboard.
	datum := self getClipboardData: self CF_HTML.
	val := datum isNull
		       ifTrue: [ nil ]
		       ifFalse: [ datum fromBasicCString ].
	self closeClipboard.
	^ val
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getHTMLClipboardDataContent [
	<script: 'self getHTMLClipboardDataContent inspect'>

	| data index lastIndex dataOri |
	dataOri := self getHTMLClipboardData.
	dataOri ifNil: [ ^ nil ].
	data := dataOri utf8Decoded.
	index := self findToken: 'StartFragment' in: data.
	lastIndex := self findToken: 'EndFragment' in: data.
	data := dataOri.
	lastIndex ifNotNil: [ data := data first: lastIndex ].
	index ifNotNil: [ "index := index + '<!--StartFragment -->' size." 
		data := data allButFirst: index ].
	^ data utf8Decoded
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getPNGClipboardData [
	<script: 'self getPNGClipboardData inspect'>
	^ self getByteClipboardDataFrom: 'PNG'
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getRegisteredClipboardFormat: aFormat [

	| f |
	f := self registerClipboardFormat: aFormat.
	self registeredClipboardFormats at: aFormat put: f.
	^f
]

{ #category : #'as yet unclassified' }
WinClipboard class >> getTextClipboardData [

	<script: 'self getTextClipboardData inspect'>
	| datum val |
	self openClipboard.
	datum := self getClipboardData: self CF_TEXT.
	val := datum isNull not
		       ifFalse: [ nil ]
		       ifTrue: [ datum fromCString ].
	self closeClipboard.
	^ val
]

{ #category : #'as yet unclassified' }
WinClipboard class >> globalAlloc: flags size: bytes [
	^self ffiCall: #(void* GlobalAlloc(UINT flags, SIZE_T bytes)) module: #kernel32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> globalLock: hMem [
	^self ffiCall: #(LPVOID GlobalLock(void* hMem)) module: #kernel32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> globalSize: hMem [
	^self ffiCall: #(SIZE_T GlobalSize(void* hMem)) module: #kernel32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> globalUnlock: hMem [
	^self ffiCall: #(LPVOID GlobalUnlock(void* hMem)) module: #kernel32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> openClipboard [
<script>
^self openClipboard: (ExternalAddress fromAddress: 0).
]

{ #category : #'as yet unclassified' }
WinClipboard class >> openClipboard: aHwnd [
<script> 
	^self ffiCall: #(bool OpenClipboard( HWND aHwnd )) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> pastePNGFromClipboard [

	<script: 'self pastePNGFromClipboard inspect'>
	| bytes |
	bytes := self getByteClipboardDataFrom: 'PNG'.
	bytes isNil
		ifTrue: [ ^ self pastePNGFromHDROP ]
		ifFalse: [ ^ ImageReadWriter formFromStream: bytes readStream ]
]

{ #category : #'as yet unclassified' }
WinClipboard class >> pastePNGFromDIB [

	<script: 'self pastePNGFromDIB inspect'>
	| bytes |
	bytes := self getByteClipboardData: self CF_DIB.
	bytes isNil
		ifTrue: [ ^ nil ]
		ifFalse: [ 
			^ self halt: 'TODO']
]

{ #category : #'as yet unclassified' }
WinClipboard class >> pastePNGFromHDROP [

	<script: 'self pastePNGFromHDROP inspect'>
	| bytes |
	bytes := self getByteClipboardData: self CF_HDROP.
	bytes isNil
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ ImageReadWriter formFromStream: bytes readStream ]
]

{ #category : #'as yet unclassified' }
WinClipboard class >> pasteSVGFromClipboard [

	<script: 'self pasteSVGFromClipboard inspect'>
	| data |
	data := self getByteClipboardDataFrom: 'image/svg+xml'.
	data ifNil: [ 
		data := self getByteClipboardDataFrom:
			        'image/x-inkscape-svg' ].
	data ifNil: [ ^ nil ].
	data := data utf8Decoded.
	^ BlSvgConverter convertFromString: data
]

{ #category : #'as yet unclassified' }
WinClipboard class >> registerClipboardFormat: aString [
	^self ffiCall: #(UINT RegisterClipboardFormatA(LPTSTR aString)) module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> registeredClipboardFormats [

	clipboardFormats isNil ifTrue: [clipboardFormats := Dictionary new].
	^clipboardFormats
]

{ #category : #'as yet unclassified' }
WinClipboard class >> resetClipboard [
cf_html := nil.
clipboardFormats := nil.
]

{ #category : #'as yet unclassified' }
WinClipboard class >> resetHTML [
^self resetClipboard
]

{ #category : #'as yet unclassified' }
WinClipboard class >> setByteClipboardData: aIntType value: aByteArray [
"WinClipboard setClipboardByteData: 15 value: #(55 55 55)"

	^self setClipboardByteData: aByteArray withFormat: aIntType
]

{ #category : #'as yet unclassified' }
WinClipboard class >> setClipboardByteData: aByteArray withFormat: aFormat [

	self clearClipboard.
	^self addClipboardByteData: aByteArray withFormat: aFormat
]

{ #category : #'as yet unclassified' }
WinClipboard class >> setClipboardTextData: aFormat value: aString [

	^ self
		  ffiCall: #(void* SetClipboardData( UINT aFormat, char* aString))
		  module: #user32
]

{ #category : #'as yet unclassified' }
WinClipboard class >> setPNGByteClipboardData: aByteArray [

	| type |
	type := self getRegisteredClipboardFormat: 'PNG'.
	^self setByteClipboardData: type value: aByteArray
]
