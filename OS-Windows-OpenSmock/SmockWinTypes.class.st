"
OpenFilename types
"
Class {
	#name : #SmockWinTypes,
	#superclass : #WinTypes,
	#classVars : [
		'BFFCALLBACK',
		'LONG_PTR',
		'LPOFNHOOKPROC',
		'PCIDLIST_ABSOLUTE',
		'PIDLIST_ABSOLUTE'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs-Support'
}

{ #category : #'private - initialization' }
SmockWinTypes class >> initKnownTypes [

	super initKnownTypes.

	BOOL := #bool.
	DWORD := #ulong.
	VOID := #void.

	LONG_PTR := #long.
	LPARAM := 'void *'.
	LPOFNHOOKPROC := LONG_PTR.

	HANDLE := #'void*'.
	HWND := #'void*'.
	PCIDLIST_ABSOLUTE := #'void*'.
	PIDLIST_ABSOLUTE := #'void*'.
	BFFCALLBACK := #'void*'
]

{ #category : #'private - initialization' }
SmockWinTypes class >> initStringTypes [

	super initStringTypes.

	LPTSTR := 'char*'.
	LPWSTR := 'char*'.
	LPCWSTR := 'char*'.
	LPCSTR := 'char*'.
	LPSTR := 'char*'.

	LPTSTR := 'char*'.
	LPWSTR := 'char*'.

	LPCTSTR := LPTSTR
]

{ #category : #'class initialization' }
SmockWinTypes class >> initialize [
	<script>

	super initialize		
]
