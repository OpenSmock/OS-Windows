Extension { #name : #ExternalAddress }

{ #category : #'*OS-Windows-OpenSmock' }
ExternalAddress >> fromBasicCString [
	| index aByte |

	^ (ByteArray streamContents: [ :aStream |
			index := 1.
			[(aByte := self unsignedByteAt: index) = 0] 
				whileFalse: [
					aStream nextPut: aByte.
					index := index + 1]])
]
