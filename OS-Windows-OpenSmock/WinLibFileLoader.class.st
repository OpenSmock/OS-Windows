Class {
	#name : #WinLibFileLoader,
	#superclass : #FFILibrary,
	#category : #'OS-Windows-OpenSmock-Dialogs'
}

{ #category : #'accessing platform' }
WinLibFileLoader >> macModuleName [
	^ 'libFilesize.dylib'
]

{ #category : #'accessing platform' }
WinLibFileLoader >> unixModuleName [
	^ 'libFilesize.so'
]

{ #category : #'accessing platform' }
WinLibFileLoader >> win32ModuleName [
	^ 'filesize.dll'
]
