Class {
	#name : #WinBrowseInfo,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_HWNDOWNER',
		'OFFSET_IIMAGE',
		'OFFSET_LPARAM',
		'OFFSET_LPFN',
		'OFFSET_LPSZTITLE',
		'OFFSET_PIDLROOT',
		'OFFSET_PSZDISPLAYNAME',
		'OFFSET_ULFLAGS'
	],
	#pools : [
		'SmockWinTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs-Support'
}

{ #category : #'field definition' }
WinBrowseInfo class >> BIF_EDITBOX [
	"self BIF_EDITBOX"

	^ 16r00000010
]

{ #category : #'field definition' }
WinBrowseInfo class >> BIF_NEWDIALOGSTYLE [
"self BIF_NEWDIALOGSTYLE"
	^ 16r00000040
]

{ #category : #'field definition' }
WinBrowseInfo class >> BIF_USENEWUI [
	"self BIF_EDITBOX"

	^ ((self BIF_EDITBOX) bitOr: (self BIF_NEWDIALOGSTYLE) )
]

{ #category : #'field definition' }
WinBrowseInfo class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #( HWND              hwndOwner #';'
  PCIDLIST_ABSOLUTE pidlRoot #';'
  LPWSTR            pszDisplayName #';'
  LPCWSTR           lpszTitle #';'
  UINT              ulFlags #';'
  BFFCALLBACK       lpfn #';'
  LPARAM            lParam #';'
  int               iImage #';' )
]

{ #category : #'as yet unclassified' }
WinBrowseInfo class >> getAdvancedBrowseInfo [

	| bi folder title var |
	bi := self new.
	bi hwndOwner: (ExternalAddress fromAddress: 0).
	bi pidlRoot: (ExternalAddress fromAddress: 0).
	folder := FFIExternalArray externalNewType: 'char' size: 260.
	bi pszDisplayName: folder.
	title := 'Sélection d''un répertoire'.
	var := FFIExternalArray externalNewType: 'char' size: title size.
	title doWithIndex: [ :k :i | var at: i put: k ].
	bi lpszTitle: var.

	bi ulFlags: self BIF_USENEWUI. 
	bi lpfn: (ExternalAddress fromAddress: 0).
	bi lParam: (ExternalAddress fromAddress: 0).

	^ bi
]

{ #category : #'as yet unclassified' }
WinBrowseInfo class >> getAdvancedBrowseInfo: aTxt [

	| bi folder title var |
	bi := self new.
	bi hwndOwner: (ExternalAddress fromAddress: 0).
	bi pidlRoot: (ExternalAddress fromAddress: 0).
	folder := FFIExternalArray externalNewType: 'char' size: 260.
	bi pszDisplayName: folder.
	title := aTxt.
	var := FFIExternalArray externalNewType: 'char' size: title size.
	title doWithIndex: [ :k :i | var at: i put: k ].
	bi lpszTitle: var.

	bi ulFlags: self BIF_USENEWUI.
	bi lpfn: (ExternalAddress fromAddress: 0).
	bi lParam: (ExternalAddress fromAddress: 0).

	^ bi
]

{ #category : #'as yet unclassified' }
WinBrowseInfo class >> getBasicBrowseInfo [

	| bi folder title var |
	bi := self new.
	bi hwndOwner: (ExternalAddress fromAddress: 0).
	bi pidlRoot: (ExternalAddress fromAddress: 0).
	folder := FFIExternalArray externalNewType: 'char' size: 260.
	bi pszDisplayName: folder.
	title := 'Sélection d''un répertoire'.
	var := FFIExternalArray externalNewType: 'char' size: title size.
	title doWithIndex: [ :k :i | var at: i put: k ].
	bi lpszTitle: var.
	
	bi ulFlags: self BIF_NEWDIALOGSTYLE.
	bi lpfn: (ExternalAddress fromAddress: 0).
	bi lParam: (ExternalAddress fromAddress: 0).

	^ bi
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> hwndOwner [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HWNDOWNER) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> hwndOwner: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HWNDOWNER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> iImage [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_IIMAGE
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> iImage: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_IIMAGE put: anObject
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lParam [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPARAM) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lParam: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPARAM put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lpfn [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPFN) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lpfn: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPFN put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lpszTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSZTITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> lpszTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSZTITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> pidlRoot [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PIDLROOT) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> pidlRoot: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PIDLROOT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> pszDisplayName [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PSZDISPLAYNAME) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> pszDisplayName: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PSZDISPLAYNAME put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> ulFlags [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_ULFLAGS
]

{ #category : #'accessing - structure variables' }
WinBrowseInfo >> ulFlags: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_ULFLAGS put: anObject
]
