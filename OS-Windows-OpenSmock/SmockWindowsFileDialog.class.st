"
Smock Windows FileDialog

usage :
- Récupérer un nom de fichier ou rien : 
	SmockWindowsFileDialog openFilename.
- Récupérer un nom de fichier ou rien d'extension connue : 
	SmockWindowsFileDialog openFilename: 'JSON file' extension: '*.json'.
"
Class {
	#name : #SmockWindowsFileDialog,
	#superclass : #Object,
	#pools : [
		'SmockWindowsTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs'
}

{ #category : #primitives }
SmockWindowsFileDialog class >> comDlgExtendedError [
	
	^ self ffiCall: #(DWORD CommDlgExtendedError()) library: #comdlg32
]

{ #category : #opening }
SmockWindowsFileDialog class >> openFilename [

	<script>
	| ofn file |
	ofn := SmockOpenFileName chooseFilename.
	self primOpenFilename: ofn.
	file := ofn lpstrFile bytesFromCString utf8Decoded.
	ofn lpstrFile free.
	ofn lpstrFilter free.
	^ file inspect
]

{ #category : #opening }
SmockWindowsFileDialog class >> openFilename: aFiletype extension: aString [
	| ofn file |
	ofn := SmockOpenFileName
		chooseFilenameType: aFiletype
		extension: aString.
	self primOpenFilename: ofn.
	file := ofn lpstrFile fromCString.
	ofn lpstrFile free.
	ofn lpstrFilter free.
	^ file
]

{ #category : #primitives }
SmockWindowsFileDialog class >> primOpenFilename: aOfnStructure [	
	  
	^ self ffiCall: #(BOOL GetOpenFileNameA(SmockOpenFileName aOfnStructure)) library: #comdlg32 
]
