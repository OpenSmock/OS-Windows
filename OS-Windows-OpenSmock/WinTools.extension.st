Extension { #name : #WinTools }

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> clipboardClearMenuOn: aBuilder [
	<worldMenu> 

	(aBuilder item: #'Clear')
		parent: #'Clipboard';	 
		help: 'Clear the clipboard';
		action:[ WinClipboard clearClipboard ];
		order: 3;
		icon: ( self iconNamed: #glamorousTrash )
]

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> clipboardContentMenuOn: aBuilder [
	<worldMenu> 

	(aBuilder item: #'Clipboard content')
		parent: #'Clipboard';	 
		help: 'See content of the clipboard in a table';
		action:[ self openClipboardContent ];
		order: 0;
		icon: ( self iconNamed: #glamorousTable )
]

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> clipboardEntriesMenuOn: aBuilder [
	<worldMenu> 

	(aBuilder item: #'Inspect Clipboard entries')
		parent: #'Clipboard';	 
		help: 'Inspect current clipboard entries';
		action:[ WinClipboard currentClipboardEntries inspect ];
		order: 1;
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
WinTools class >> clipboardRegisteredFormatsMenuOn: aBuilder [
	<worldMenu> 

	(aBuilder item: #'Inspect registered formats')
		parent: #'Clipboard';	 
		help: 'Inspect clipboard registered formats';
		action:[ WinClipboard registeredClipboardFormats inspect ];
		order: 2;
		icon: ( self iconNamed: #glamorousInspect )
]

{ #category : #'*OS-Windows-OpenSmock' }
WinTools class >> openClipboardContent [
	"Open the clipboard content in a window"
	| table window entries |

	table := SpTablePresenter new.
	entries := WinClipboard currentClipboardEntries.

	"Build content of the table"
	table addColumn: ((SpStringTableColumn new) title: 'Id'; width: 50; evaluated: [ :e | e id asString ]; displayBold:[ :e | e isSupported ]).
	table addColumn: ((SpStringTableColumn new) title: 'Type'; width: 100; evaluated: [ :e | (e type ifNil:['Unknown']) asString ]; displayBold:[ :e | e isSupported ]).
	table addColumn: ((SpStringTableColumn new) title: 'Data'; evaluated: [ :e | (e data ifNil:['Nil data']) asString ]; displayBold: [ :e | e isSupported and:[e data notNil] ]).

	"Add datas"
	entries ifNotNil:[table items: entries].

	window := table open.
	window title: 'Clipboard content'
]
