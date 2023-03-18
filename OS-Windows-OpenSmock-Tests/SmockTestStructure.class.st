"
Struture made for testing structure validation on Pharo 10
"
Class {
	#name : #SmockTestStructure,
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
	#category : #'OS-Windows-OpenSmock-Tests'
}

{ #category : #'field definition' }
SmockTestStructure class >> fieldsDesc [
	"self rebuildFieldAccessors"
	^ #(DWORD lStructSize;
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
    DWORD FlagsEx;)
]

{ #category : #tests }
SmockTestStructure class >> testStructureValidation [
<script>
(FFIExternalStructureType objectClass: self ) tfExternalType validate inspect
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> Flags [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> Flags: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> FlagsEx [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> FlagsEx: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_FLAGSEX put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> dwReserved [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> dwReserved: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_DWRESERVED put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> hInstance [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HINSTANCE) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> hInstance: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HINSTANCE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> hwndOwner [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HWNDOWNER) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> hwndOwner: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HWNDOWNER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lCustData [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LCUSTDATA) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lCustData: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LCUSTDATA put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lStructSize [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lStructSize: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_LSTRUCTSIZE put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpTemplateName [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPTEMPLATENAME) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpTemplateName: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPTEMPLATENAME put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpfnHook [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpfnHook: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_LPFNHOOK put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrCustomFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRCUSTOMFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrCustomFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRCUSTOMFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrDefExt [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRDEFEXT) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrDefExt: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRDEFEXT put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFile [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFile: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFileTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILETITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFileTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILETITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFilter [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRFILTER) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrFilter: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRFILTER put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrInitialDir [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRINITIALDIR) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrInitialDir: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRINITIALDIR put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPSTRTITLE) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> lpstrTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPSTRTITLE put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFileExtension [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEEXTENSION
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFileExtension: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEEXTENSION put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFileOffset [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_NFILEOFFSET
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFileOffset: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_NFILEOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFilterIndex [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nFilterIndex: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NFILTERINDEX put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxCustFilter [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxCustFilter: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXCUSTFILTER put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxFile [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxFile: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILE put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxFileTitle [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> nMaxFileTitle: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_NMAXFILETITLE put: anObject
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> pvReserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PVRESERVED) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SmockTestStructure >> pvReserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PVRESERVED put: anObject getHandle.
]
