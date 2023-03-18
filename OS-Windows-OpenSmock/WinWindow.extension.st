Extension { #name : #WinWindow }

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> closeWindow [
	"close the window"

	^ self
		ffiCall: #( BOOL CloseWindow #( HWND self ) )
		module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> closeWindow: aHandle [
	"close the specified window"

	^ self
		ffiCall: #( BOOL CloseWindow #( HWND aHandle ) )
		module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> isEnabled [
	"Retrieves the enable state of the specified window"

	^ self
		  ffiCall: #( int IsWindowEnabled #( HWND self ) )
		  module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> isEnabled: hwnd [
	"Retrieves the enable state of the specified window"

	^ self
		  ffiCall: #( int IsWindowEnabled #( HWND hwnd ) )
		  module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> openIcon: hWnd [

	^ self
		ffiCall: #( BOOL OpenIcon #( HWND hWnd ) )
		module: #user32
]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow class >> pharoWindowFixed [
	<script: 'self pharoWindowFixed inspect'>

	| sdlWindowInfo handle osWindow |
	osWindow := ActiveWorld worldState worldRenderer window.
	sdlWindowInfo := osWindow backendWindow getWMInfo.
	handle := sdlWindowInfo info win window.

	^ self fromExternalHandle: handle
]
