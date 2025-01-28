"
A WinOpenFilenameTest is a test class for testing the behavior of WinOpenFilename
"
Class {
	#name : #WinOpenFilenameTest,
	#superclass : #TestCase,
	#category : #'OS-Windows-OpenSmock-Tests-Dialogs-Support'
}

{ #category : #tests }
WinOpenFilenameTest >> testBuildCharPointer [

	| txt buf |
	txt := 'this is a string'.
	self assert: txt size = 16.
	buf := WinOpenFilename buildCharPointerWith: txt.
	self assert: (buf size = 17).
	self assert:((buf at: 17) = 0 asCharacter).
]
