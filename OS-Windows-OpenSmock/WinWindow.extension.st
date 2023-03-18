Extension { #name : #WinWindow }

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> closeWindow [
	^ self ffiCall: #( BOOL CloseWindow ( HWND self )) module: #user32

]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> closeWindow: aHandle [
	^ self ffiCall: #( BOOL CloseWindow ( HWND aHandle )) module: #user32

]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> isEnabled [
	"Retrieves the visibility state of the specified window. . "
	 
	^self ffiCall: #(int IsWindowEnabled (HWND self)) module: #user32

]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> isEnabled: hwnd [
	"Retrieves the visibility state of the specified window. . "
	 
	^self ffiCall: #(int IsWindowEnabled (HWND hwnd)) module: #user32

]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow >> openIcon: hWnd [
 
	^self ffiCall: #(BOOL OpenIcon(HWND hWnd)) module: #user32

]

{ #category : #'*OS-Windows-OpenSmock' }
WinWindow class >> pharoWindow [
<script: 'self pharoWindow inspect'>
"ELP CODE"
	| sdlWindowInfo handle |
	sdlWindowInfo := World worldState worldRenderer window backendWindow getWMInfo.
	handle := sdlWindowInfo info win window.
	^self fromExternalHandle: handle
]
