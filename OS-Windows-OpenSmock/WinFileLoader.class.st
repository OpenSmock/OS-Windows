Class {
	#name : #WinFileLoader,
	#superclass : #Object,
	#pools : [
		'SmockWinTypes'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs'
}

{ #category : #'library path' }
WinFileLoader class >> ffiLibraryName [ 
^WinLibFileLoader 
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> freeBufferContainer: buffer [

^self ffiCall: #(void free_buffer(char **buffer)) module: WinLibFileLoader
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> libVersion [
<script: 'self libVersion inspect'>
^self version
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> libVersionName [
<script: 'self libVersionName inspect'>
^self versionName
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> readFile: path [
<script>
| container charPath size txt |
charPath := path nullTerminatedEncodeWith: #utf8.
container := FFIExternalArray externalNewType: 'void*' size: 1.
"container := ExternalAddress new".
size := self readFile: charPath inBufferContainer: container getHandle.
txt := (container) getHandle bytesFromCString.
self freeBufferContainer: container getHandle.
^txt
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> readFile: path inBufferContainer: buffer [

^self ffiCall: #(int read_file(char *path, char **buffer)) module: WinLibFileLoader
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> readFileBuf: path [
<script>
| container charPath size |
charPath := FFIExternalArray externalNewType: 'char' size: path size+1.
path doWithIndex: [ :k :i | charPath at: i put: k ].
charPath at: path size +1 put: 0.
container := nil.
size := self readFileBuf: charPath getHandle inBufferContainer: container.
self halt.
self freeBufferContainer: container.
^nil
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> readFileBuf: path inBufferContainer: buffer [

^self ffiCall: #(int read_file_buf(char *path, char *buffer)) module: WinLibFileLoader
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> version [

^self ffiCall: #(int version()) module: WinLibFileLoader
]

{ #category : #'as yet unclassified' }
WinFileLoader class >> versionName [

^self ffiCall: #(char* versionName()) module: WinLibFileLoader
]
