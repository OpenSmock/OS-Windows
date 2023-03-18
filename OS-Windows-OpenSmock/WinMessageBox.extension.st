Extension { #name : #WinMessageBox }

{ #category : #'*OS-Windows-OpenSmock' }
WinMessageBox class >> errorMessageBox: lpText title: lpCaption [

	| hWnd uType |
	hWnd := ExternalAddress fromAddress: 0.
	uType := 16r00000010.

	self
		messageBox: hWnd
		text: lpText
		title: lpCaption
		flags: uType
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
		messageBox: hWnd
		text: lpText
		title: lpCaption
		flags: uType
]
