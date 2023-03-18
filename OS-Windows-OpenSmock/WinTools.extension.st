Extension { #name : #WinTools }

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> clipboardContentMenuOn: aBuilder [

	<worldMenu> 
	(aBuilder item: #'See content')
		parent: #'Clipboard';	 
		help: 'Clipboard utils';
		action:[ self openClipboardContent ];
		order: 0;
		icon: ( self iconNamed: #glamorousInspect )
]

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> clipboardMenuOn: aBuilder [

	<worldMenu> 
	(aBuilder item: #'Clipboard')
		parent: #'OS-Windows Tools';	 
		help: 'Clipboard utils';
		order: 0.1;
		icon: (self iconNamed: #smallPaste ) 
]

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> openClipboardContent [
	"Open the clipboard content in a window"
	| table window currentTypes types |

	table := SpTablePresenter new.
	currentTypes := WinClipboard currentClipboardTypes.
	types := WinClipboard clipboardConcreteTypes.

	"Build content of the table"
	table addColumn: ((SpStringTableColumn new) title: 'Id'; width: 50; evaluated: [ :data | data asString ]).
	table addColumn: ((SpStringTableColumn new) title: 'Enum'; width: 100; evaluated: [ :data | (types at: data ifAbsent:['Unknown enum']) asString ]).
	table addColumn: ((SpStringTableColumn new) title: 'Data'; evaluated: [ :data |
		types at: data ifPresent:[ :type | | datum |
			datum := WinClipboard getClipboardData: data.
			(WinClipboard clipboardDataValue: datum type: data) printString.
		] ifAbsent:['Not supported data'].
	]; displayBold: [ :e | true ]).

	"Add datas"
	currentTypes ifNotNil:[table items: currentTypes].

	window := table open.
	window title: 'OS Clipboard content'
]
