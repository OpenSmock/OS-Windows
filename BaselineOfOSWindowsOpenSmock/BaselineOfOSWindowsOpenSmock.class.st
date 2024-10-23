Class {
	#name : #BaselineOfOSWindowsOpenSmock,
	#superclass : #BaselineOf,
	#category : #BaselineOfOSWindowsOpenSmock
}

{ #category : #baselines }
BaselineOfOSWindowsOpenSmock >> baseline: spec [
	<baseline>

	spec postLoadDoIt: #'postload:package:'.

	"Load Pharo-OS-Windows dependency"
	spec
		baseline: #OSWindows
		with: [ spec repository: 'github://OpenSmock/Pharo-OS-Windows/src' ].

	"Load the project"
	spec package: 'OS-Windows-OpenSmock'.
	spec package: 'OS-Windows-OpenSmock-Tests' with: [ spec requires: 'OS-Windows-OpenSmock' ]
]

{ #category : #baselines }
BaselineOfOSWindowsOpenSmock >> postload: loader package: packageSpec [

	"Define extended window types"
	SmockWinTypes initialize
]
