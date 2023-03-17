"
Types spécifiques a l'utilisation du clipboard
"
Class {
	#name : #WinClipboardTypes,
	#superclass : #SharedPool,
	#classVars : [
		'SIZE_T'
	],
	#category : #'OS-Windows-OpenSmock'
}

{ #category : #initialization }
WinClipboardTypes class >> initBasicTypes [

	SIZE_T := #uint.
]

{ #category : #initialization }
WinClipboardTypes class >> initialize [

	self
		initBasicTypes.
]
