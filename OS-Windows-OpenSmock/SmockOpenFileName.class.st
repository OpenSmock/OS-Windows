"
Structure de base OPENFILENAME
"
Class {
	#name : #SmockOpenFileName,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_DWRESERVED',
		'OFFSET_FLAGS',
		'OFFSET_FLAGSEX',
		'OFFSET_HINSTANCE',
		'OFFSET_HWNDOWNER',
		'OFFSET_LCUSTDATA',
		'OFFSET_LPFNHOOK',
		'OFFSET_LPSTRCUSTOMFILTER',
		'OFFSET_LPSTRDEFEXT',
		'OFFSET_LPSTRFILE',
		'OFFSET_LPSTRFILETITLE',
		'OFFSET_LPSTRFILTER',
		'OFFSET_LPSTRINITIALDIR',
		'OFFSET_LPSTRTITLE',
		'OFFSET_LPTEMPLATENAME',
		'OFFSET_LSTRUCTSIZE',
		'OFFSET_NFILEEXTENSION',
		'OFFSET_NFILEOFFSET',
		'OFFSET_NFILTERINDEX',
		'OFFSET_NMAXCUSTFILTER',
		'OFFSET_NMAXFILE',
		'OFFSET_NMAXFILETITLE',
		'OFFSET_PVRESERVED'
	],
	#pools : [
		'SmockWindowsTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialog'
}

{ #category : #'field definition' }
SmockOpenFileName class >> chooseFilename [
"self chooseFilename"
| ofn szFile str buf |
ofn := self new.
ofn lStructSize: self structureSize.
szFile := FFIExternalArray externalNewType: 'char' size: 260.
ofn hwndOwner: (ExternalAddress fromAddress: 0).
ofn lpstrFile: szFile.
szFile at: 1 put: (0 asCharacter).
ofn nMaxFile: szFile size.
str := ('All',0 asCharacter asString,'*.*',0 asCharacter asString, 0 asCharacter asString).
buf := FFIExternalArray externalNewType: 'char' size: str size.
str doWithIndex: [ :k :i | buf at: i put: k ].
ofn lpstrFilter: buf.  
ofn nFilterIndex: 0.
ofn nMaxFileTitle: 0.
^ofn

]

{ #category : #'field definition' }
SmockOpenFileName class >> chooseFilenameType: aTypename extension: aString [
	"self chooseFilenameType: 'Texte' extension: 'txt'"

	| ofn szFile str buf |
	ofn := self new.
	ofn lStructSize: SmockOpenFileName structureSize.
	szFile := FFIExternalArray externalNewType: 'char' size: 260.
	ofn hwndOwner: (ExternalAddress fromAddress: 0).
	ofn lpstrFile: szFile.
	szFile at: 1 put: 0 asCharacter.
	ofn nMaxFile: szFile size.
	str := 'All' , 0 asCharacter asString , '*.*'
		, 0 asCharacter asString , aTypename , 0 asCharacter asString , aString , 0 asCharacter asString, 0 asCharacter asString.
	buf := FFIExternalArray externalNewType: 'char' size: str size.
	str doWithIndex: [ :k :i | buf at: i put: k ].
	ofn lpstrFilter: buf.
	ofn nFilterIndex: 2.
	ofn nMaxFileTitle: 0.
	^ ofn
]

{ #category : #'field definition' }
SmockOpenFileName class >> defaultAllFilename [
| ofn szFile str buf |
ofn := self new.
ofn lStructSize: SmockOpenFileName structureSize.
szFile := FFIExternalArray externalNewType: 'char' size: 100.
"ofn hwndOwner: WinWindow pharoWindow."
ofn hwndOwner: 0.
ofn lpstrFile: szFile.
szFile at: 1 put: (0 asCharacter).
ofn nMaxFile: szFile size.
str := ('All',0 asCharacter asString,'*.*',0 asCharacter asString,'TEXT',0 asCharacter asString,'*.TXT',0 asCharacter asString).
buf := FFIExternalArray externalNewType: 'char' size: str size.
str doWithIndex: [ :k :i | buf at: i put: k ].
ofn lpstrFilter: buf.  
ofn nFilterIndex: 1.
ofn nMaxFileTitle: 0.

^ofn

]

{ #category : #'field definition' }
SmockOpenFileName class >> fieldsDesc [
	"self rebuildFieldAccessors"
	^ #(
    DWORD lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    LPCSTR lpstrFilter;
    LPSTR lpstrCustomFilter;
    DWORD nMaxCustFilter;
    DWORD nFilterIndex;
    LPSTR lpstrFile;
    DWORD nMaxFile;
    LPSTR lpstrFileTitle;
    DWORD nMaxFileTitle;
    LPCSTR lpstrInitialDir;
    LPCSTR lpstrTitle;
    DWORD Flags;
    WORD nFileOffset;
    WORD nFileExtension;
    LPCSTR lpstrDefExt;
   	 LPARAM lCustData;
    LPOFNHOOKPROC lpfnHook;
    LPCSTR lpTemplateName;
    void *pvReserved;
    DWORD dwReserved;
    DWORD FlagsEx;
	)
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> Flags [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> Flags: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> FlagsEx [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> FlagsEx: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> dwReserved [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> dwReserved: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> hInstance [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HINSTANCE) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> hInstance: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HINSTANCE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> hwndOwner [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HWNDOWNER) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> hwndOwner: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HWNDOWNER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lCustData [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LCUSTDATA) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lCustData: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LCUSTDATA put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lStructSize [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lStructSize: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE put: anObject
]

{ #category : #'accessing structure variables' }
SmockOpenFileName >> lpEditInfo [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPEDITINFO) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
SmockOpenFileName >> lpEditInfo: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPEDITINFO put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpTemplateName [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPTEMPLATENAME) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpTemplateName: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPTEMPLATENAME put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpfnHook [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpfnHook: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrCustomFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRCUSTOMFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrCustomFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRCUSTOMFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrDefExt [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRDEFEXT) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrDefExt: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRDEFEXT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFile [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFile: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFileTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILETITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFileTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILETITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrInitialDir [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRINITIALDIR) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrInitialDir: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRINITIALDIR put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SmockOpenFileName >> lpstrPrompt [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRPROMPT) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
SmockOpenFileName >> lpstrPrompt: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRPROMPT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRTITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> lpstrTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRTITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFileExtension [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEEXTENSION
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFileExtension: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEEXTENSION put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFileOffset [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEOFFSET
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFileOffset: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFilterIndex [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nFilterIndex: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxCustFilter [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxCustFilter: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxFile [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxFile: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxFileTitle [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> nMaxFileTitle: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE put: anObject
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> pvReserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PVRESERVED) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockOpenFileName >> pvReserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PVRESERVED put: anObject getHandle.
]
