"
Smock Windows FileDialog

usage :
- Récupérer un nom de fichier ou rien : 
	SmockWindowsFileDialog openFilename.
- Récupérer un nom de fichier ou rien d'extension connue : 
	SmockWindowsFileDialog openFilename: 'JSON file' extension: '*.json'.
"
Class {
	#name : #WinFileDialog,
	#superclass : #Object,
	#pools : [
		'SmockWinTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs'
}

{ #category : #primitives }
WinFileDialog class >> PCIDLIST_ABSOLUTEder: aBrowseInfo [

	^ self
		  ffiCall: #(  PIDLIST_ABSOLUTE SHBrowseForFolderA #( #WinBrowseInfo
			        aBrowseInfo ) )
		  library: #shell32
]

{ #category : #primitives }
WinFileDialog class >> comDlgExtendedError [

	^ self
		  ffiCall: #( DWORD CommDlgExtendedError #(  ) )
		  library: #comdlg32
]

{ #category : #'api - file' }
WinFileDialog class >> openAdvancedFolder [

	<script: 'self openAdvancedFolder inspect'>
	| bi path rez |
	bi := WinBrowseInfo getAdvancedBrowseInfo.
	"path := FFIExternalArray externalNewType: 'char' size: 260."
	path := ExternalData
		        fromHandle: (ExternalAddress allocate: 260)
		        type: ExternalType char asPointerType.
	rez := self primBrowseForFolder: bi.
	self primGetPath: path getHandle fromIDList: rez.
	^ path bytesFromCString asString
]

{ #category : #'api - file' }
WinFileDialog class >> openAdvancedFolder: aFileReference withLabel: aTxt [

	| bi path rez |
	bi := WinBrowseInfo getAdvancedBrowseInfo: aTxt.
	"path := FFIExternalArray externalNewType: 'char' size: 260."
	path := ExternalData
		        fromHandle: (ExternalAddress allocate: 260)
		        type: ExternalType char asPointerType.
	rez := self primBrowseForFolder: bi.
	self primGetPath: path getHandle fromIDList: rez.
	^ path bytesFromCString asString
]

{ #category : #'api - file' }
WinFileDialog class >> openFilename [
	<script: 'self openFilename inspect'>

	^ self openFilenames: nil extensions: nil allFilesOption: false
]

{ #category : #'api - file' }
WinFileDialog class >> openFilename: anInitialDirFileReference [
	<script: '(self openFilename: FileSystem workingDirectory) inspect'>

	| winFilename |
	winFilename := WinOpenFilename
		               chooseFilenameTypes: nil
		               extensions: nil
		               allFilesOption: false
		               initialDir: anInitialDirFileReference.

	^ self openWinFilename: winFilename
]

{ #category : #'api - file' }
WinFileDialog class >> openFilename: aString extension: aString2 [
	<script:'(self openFilename: ''Text/Data'' extension: ''*.txt;*.csv'') inspect'>

	^ self
		  openFilenames: (Array with: aString)
		  extensions: (Array with: aString2)
		  allFilesOption: false
]

{ #category : #'api - file' }
WinFileDialog class >> openFilename: aString extension: aString2 initialDir: aFileReference [
	<script:'(self openFilename: ''Text/Data'' extension: ''*.txt;*.csv'' initialDir: FileSystem workingDirectory) inspect'>

	^ self
		  openFilenames: (Array with: aString)
		  extensions: (Array with: aString2)
		  allFilesOption: false
		  initialDir: aFileReference
]

{ #category : #'api - file' }
WinFileDialog class >> openFilenames: aStringList extensions: aString2List [
	<script: ' | filenames extensions |
	filenames := OrderedCollection with: ''Text/Log'' with: ''Data''.
	extensions := OrderedCollection with: ''*.txt;*.log'' with: ''*.csv''.
	(self openFilenames: filenames extensions: extensions) inspect'>

	^ self
		  openFilenames: aStringList
		  extensions: aString2List
		  allFilesOption: false
]

{ #category : #'api - file' }
WinFileDialog class >> openFilenames: aStringList extensions: aString2List allFilesOption: aBoolean [
	<script: ' | filenames extensions |
	filenames := OrderedCollection with: ''Text/Log'' with: ''Data''.
	extensions := OrderedCollection with: ''*.txt;*.log'' with: ''*.csv''.
	(self openFilenames: filenames extensions: extensions allFilesOption: true) inspect'>

	| winFilename |
	winFilename := WinOpenFilename
		               chooseFilenameTypes: aStringList
		               extensions: aString2List
		               allFilesOption: aBoolean
		               initialDir: nil.

	^ self openWinFilename: winFilename
]

{ #category : #'api - file' }
WinFileDialog class >> openFilenames: aStringList extensions: aString2List allFilesOption: aBoolean initialDir: aFileReference [
	<script: ' | filenames extensions |
	filenames := OrderedCollection with: ''Text/Log'' with: ''Data''.
	extensions := OrderedCollection with: ''*.txt;*.log'' with: ''*.csv''.
	(self openFilenames: filenames extensions: extensions allFilesOption: true initialDir: FileSystem workingDirectory) inspect'>

	| winFilename |
	winFilename := WinOpenFilename
		               chooseFilenameTypes: aStringList
		               extensions: aString2List
		               allFilesOption: aBoolean
		               initialDir: aFileReference.

	^ self openWinFilename: winFilename
]

{ #category : #'api - file' }
WinFileDialog class >> openFilenames: aStringList extensions: aString2List initialDir: aFileReference [
	<script: ' | filenames extensions |
	filenames := OrderedCollection with: ''Text/Log'' with: ''Data''.
	extensions := OrderedCollection with: ''*.txt;*.log'' with: ''*.csv''.
	(self openFilenames: filenames extensions: extensions initialDir: FileSystem workingDirectory) inspect'>

	^ self
		  openFilenames: aStringList
		  extensions: aString2List
		  allFilesOption: false
		  initialDir: aFileReference
]

{ #category : #'api - file' }
WinFileDialog class >> openFolder [

	<script: 'self openFolder inspect'>
	| bi |
	bi := WinBrowseInfo getBasicBrowseInfo.
	self primBrowseForFolder: bi.
	^ bi pszDisplayName bytesFromCString asString
]

{ #category : #private }
WinFileDialog class >> openWinFilename: aWinFilename [
	
	| file |
	self primOpenFilename: aWinFilename.
	file := aWinFilename lpstrFile bytesFromCString utf8Decoded.
	aWinFilename lpstrFile free.
	aWinFilename lpstrFilter free.
	^ file
]

{ #category : #primitives }
WinFileDialog class >> primBrowseForFolder: aBrowseInfo [
 
	^ self
		  ffiCall: #( PIDLIST_ABSOLUTE SHBrowseForFolderA #( #WinBrowseInfo
			        aBrowseInfo ) )
		  library: #shell32
]

{ #category : #primitives }
WinFileDialog class >> primGetPath: pszPath fromIDList: pidl [

	^ self
		  ffiCall:
		  #( int SHGetPathFromIDListA #( PCIDLIST_ABSOLUTE pidl , char* pszPath ) )
		  library: #shell32
]

{ #category : #primitives }
WinFileDialog class >> primOpenFilename: aOfnStructure [

	^ self
		  ffiCall: #( BOOL GetOpenFileNameA #( #WinOpenFilename aOfnStructure ) )
		  library: #comdlg32
]
