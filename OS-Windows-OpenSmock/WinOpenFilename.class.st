"
Structure de base OPENFILENAME
"
Class {
	#name : #WinOpenFilename,
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
		'SmockWinTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs-Support'
}

{ #category : #private }
WinOpenFilename class >> buildStringFilenameTypes: aTypenameList extensions: anExtensionList allFilesOption: aBoolean [
	"Build a string with a list of displayed files"

	| string |
	string := String new.
	
	"Option : Add All files option"
	aBoolean ifTrue:[
		string := string , 'All' , 0 asCharacter asString , '*.*', 0 asCharacter asString.
	].
	
	"Only build list with same number of arguments"
	(aTypenameList notNil and:[anExtensionList notNil and:[aTypenameList size = anExtensionList size]]) ifTrue:[
		1 to: aTypenameList size do:[ :i | 
			string := string , (aTypenameList at: i) , 0 asCharacter asString , (anExtensionList at: i) , 0 asCharacter asString.
		].
	].
	
	string := string , 0 asCharacter asString.
	
	^ string
]

{ #category : #constructor }
WinOpenFilename class >> chooseFilenameTypes: aTypenameList extensions: anExtensionList allFilesOption: aBoolean [

	| ofn szFile str buf |
	ofn := self new.
	ofn lStructSize: self structureSize.
	szFile := FFIExternalArray externalNewType: 'char' size: 260.
	ofn hwndOwner: (ExternalAddress fromAddress: 0).
	ofn lpstrFile: szFile.
	szFile at: 1 put: 0 asCharacter.
	ofn nMaxFile: szFile size.

	str := self buildStringFilenameTypes: aTypenameList extensions: anExtensionList allFilesOption: aBoolean.

	buf := FFIExternalArray externalNewType: 'char' size: str size.
	str doWithIndex: [ :k :i | buf at: i put: k ].
	ofn lpstrFilter: buf.
	ofn nFilterIndex: 2.
	ofn nMaxFileTitle: 0.
	^ ofn
]

{ #category : #'field definition' }
WinOpenFilename class >> fieldsDesc [
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
WinOpenFilename >> Flags [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> Flags: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> FlagsEx [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> FlagsEx: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> dwReserved [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> dwReserved: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> hInstance [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HINSTANCE) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> hInstance: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HINSTANCE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> hwndOwner [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HWNDOWNER) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> hwndOwner: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HWNDOWNER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lCustData [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LCUSTDATA) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lCustData: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LCUSTDATA put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lStructSize [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lStructSize: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE put: anObject
]

{ #category : #'accessing structure variables' }
WinOpenFilename >> lpEditInfo [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPEDITINFO) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
WinOpenFilename >> lpEditInfo: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPEDITINFO put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpTemplateName [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPTEMPLATENAME) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpTemplateName: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPTEMPLATENAME put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpfnHook [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpfnHook: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrCustomFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRCUSTOMFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrCustomFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRCUSTOMFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrDefExt [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRDEFEXT) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrDefExt: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRDEFEXT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFile [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFile: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFileTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILETITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFileTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILETITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrInitialDir [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRINITIALDIR) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrInitialDir: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRINITIALDIR put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
WinOpenFilename >> lpstrPrompt [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRPROMPT) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
WinOpenFilename >> lpstrPrompt: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRPROMPT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRTITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> lpstrTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRTITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFileExtension [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEEXTENSION
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFileExtension: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEEXTENSION put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFileOffset [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEOFFSET
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFileOffset: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFilterIndex [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nFilterIndex: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxCustFilter [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxCustFilter: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxFile [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxFile: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxFileTitle [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> nMaxFileTitle: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE put: anObject
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> pvReserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PVRESERVED) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
WinOpenFilename >> pvReserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PVRESERVED put: anObject getHandle.
]
