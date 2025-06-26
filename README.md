# OS-Windows

Extensions for Pharo-OS-Windows in OpenSmock which includes: 
- WinFileDialog access (request files with extensions)
- WinMessageBox extensions to open Warning and Error popup

![image](https://user-images.githubusercontent.com/49183340/226132585-3609265b-d492-4042-a095-3b70ba78d349.png)

![image](https://user-images.githubusercontent.com/49183340/226132506-835d4ef0-e16d-475c-8e90-4aee066cad07.png) ![image](https://user-images.githubusercontent.com/49183340/226132548-27197af6-b6c1-4a0f-b63b-04a5a676f25a.png)


## Installing

```smalltalk
Metacello new 
	repository: 'github://OpenSmock/OS-Windows:main';
	baseline: 'OSWindowsOpenSmock' ;
	load.
```

# Dependencies

[Pharo-OS-Windows](https://github.com/astares/Pharo-OS-Windows)
