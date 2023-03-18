Class {
	#name : #SmockMessageBoxDialog,
	#superclass : #Object,
	#pools : [
		'SmockWindowsTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs'
}

{ #category : #actions }
SmockMessageBoxDialog class >> openErrorMessageDialog: aString caption: aString2 [

	| hWnd uType |
	hWnd := ExternalAddress fromAddress: 0.
	uType := 16r00000010.
	self
		primOpenMessageDialog: aString
		caption: aString2
		window: hWnd
		type: uType
]

{ #category : #actions }
SmockMessageBoxDialog class >> openWarningMessageDialog: aString caption: aString2 [

	| hWnd uType |
	hWnd := ExternalAddress fromAddress: 0.
	uType := 16r00000030.
	self
		primOpenMessageDialog: aString
		caption: aString2
		window: hWnd
		type: uType
]

{ #category : #primitives }
SmockMessageBoxDialog class >> primOpenMessageDialog: aString caption: aString2 window: hWnd type: uType [

	^ self
		  ffiCall: #( int MessageBoxA #( HWND hWnd , LPCSTR aString , LPCSTR aString2, UINT uType ) )
		  library: #user32
]

{ #category : #'sample messages' }
SmockMessageBoxDialog class >> sampleErrorMessage [
	<script>

	self openErrorMessageDialog: 'This is an Error !' caption: 'test'
]

{ #category : #'sample messages' }
SmockMessageBoxDialog class >> sampleWarningMessage [
	<script>

	self openWarningMessageDialog: 'This is a warning' caption: 'test'
]
