Extension { #name : #WinMessageBox }

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> errorMessageBox: lpText title: lpCaption [

	| hWnd uType |
	hWnd := ExternalAddress fromAddress: 0.
	uType := 16r00000010.
	self
		primOpenMessageBox: hWnd
		text: lpText
		title: lpCaption
		flags: uType
]

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> primOpenMessageBox: hWnd text: lpText title: lpCaption flags: uType [

	^ self ffiCall: #( int MessageBoxA #( 
			HWND hWnd , 
			LPCSTR lpText , 
			LPCSTR lpCaption, 
			UINT uType 
		)) module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> testErrorMessage [
	<script>

	self errorMessageBox: 'This is an Error !' title: 'test'
]

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> testWarningMessage [
	<script>

	self warningMessageBox: 'This is a warning' title: 'test'
]

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> warningMessageBox: lpText title: lpCaption [

	| hWnd uType |
	hWnd := ExternalAddress fromAddress: 0.
	uType := 16r00000030.
	self
		primOpenMessageBox: hWnd
		text: lpText
		title: lpCaption
		flags: uType
]
