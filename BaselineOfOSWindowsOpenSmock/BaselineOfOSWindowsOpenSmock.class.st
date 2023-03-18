Class {
	#name : #BaselineOfOSWindowsOpenSmock,
	#superclass : #BaselineOf,
	#category : #BaselineOfOSWindowsOpenSmock
}

{ #category : #baselines }
BaselineOfOSWindowsOpenSmock >> baseline: spec [
	<baseline>

	"Load Pharo-OS-Windows dependency"
	spec
		baseline: #OSWindows
		with: [ spec repository: 'github://astares/Pharo-OS-Windows/src' ].

	"Load the project"
	spec package: 'OS-Windows-OpenSmock'.
	spec package: 'OS-Windows-OpenSmock-Tests' with: [ spec requires: 'OS-Windows-OpenSmock' ]
]
