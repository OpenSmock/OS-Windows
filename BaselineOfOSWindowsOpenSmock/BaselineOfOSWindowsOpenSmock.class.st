Class {
	#name : #BaselineOfOSWindowsOpenSmock,
	#superclass : #BaselineOf,
	#category : #BaselineOfOSWindowsOpenSmock
}

{ #category : #baselines }
BaselineOfOSWindowsOpenSmock >> baseline: spec [
	<baseline>

	"Load Pharo-OS-Windows"
	spec
		baseline: #OSWindows
		with: [ spec repository: 'github://astares/Pharo-OS-Windows/src' ].

	"Load the project"
	spec package: #OSWindowsOpenSmock.
]
