"
OpenFilename types
"
Class {
	#name : #SmockWindowsTypes,
	#superclass : #SharedPool,
	#classVars : [
		'ATOM',
		'BOOL',
		'BOOLEAN',
		'BYTE',
		'CALLBACK',
		'CHAR',
		'COLORREF',
		'DWORD',
		'DWORD32',
		'DWORD64',
		'DWORDLONG',
		'FLOAT',
		'HANDLE',
		'HBRUSH',
		'HCURSOR',
		'HICON',
		'HINSTANCE',
		'HMODULE',
		'HRESULT',
		'HWND',
		'INT',
		'INT32',
		'INT64',
		'LANGID',
		'LCID',
		'LCTYPE',
		'LGRPID',
		'LONG',
		'LONG32',
		'LONG64',
		'LONGLONG',
		'LONG_PTR',
		'LPARAM',
		'LPBOOL',
		'LPBYTE',
		'LPCOLORREF',
		'LPCSTR',
		'LPCTSTR',
		'LPCVOID',
		'LPCWSTR',
		'LPDWORD',
		'LPHANDLE',
		'LPOFNHOOKPROC',
		'LPSTR',
		'LPTCH',
		'LPTSTR',
		'LPVOID',
		'LPWCH',
		'LPWSTR',
		'PBOOL',
		'PBOOLEAN',
		'PVOID',
		'SHORT',
		'TCHAR',
		'UINT',
		'ULONG',
		'USHORT',
		'VOID',
		'WCHAR',
		'WNDPROC',
		'WORD'
	],
	#category : #'OS-Windows-OpenSmock-Dialogs-Support'
}

{ #category : #'private - initialization' }
SmockWindowsTypes class >> initKnownTypes [ 

	UINT := #ulong.
	USHORT := #ushort.
	SHORT := 'short'.
	
	BOOL := #bool.
	DWORD := #ulong.
	VOID := #void.
	ATOM := #WORD.
	BOOLEAN := #BYTE.
	BYTE := #unsignedByte.
	CALLBACK := #'void*'.
	CHAR := #char.
	COLORREF := #DWORD.

	WORD := #ushort.
	DWORDLONG := #ULONGLONG.

	DWORD32 := #ulong.
	DWORD64 := #ulonglong.
	FLOAT := #float.

	HRESULT := #LONG.
	INT := #long.
	INT32 := #long.
	INT64 := #longlong.
	LANGID := #WORD.
	LCID := #DWORD.
	LCTYPE := #DWORD.
	LGRPID := #DWORD.
	
	ULONG := #ulong.
	LONG := #long.
	LONGLONG := #longlong.

	LONG32 := #long.
	LONG64 := #longlong.
	LONG_PTR := #long.
	LPARAM := 'void *'.
	LPBOOL := #'BOOL*'.
	LPBYTE := #'BYTE*'.
	LPCOLORREF := #'DWORD*'.
	LPOFNHOOKPROC := LONG_PTR.
	
	PVOID := 'void*'.
	LPVOID := 'void*'.
	LPCVOID := #'void*'.
	LPDWORD := #'DWORD*'.
	
	PBOOL := 'BOOL*'.
	PBOOLEAN := 'BOOLEAN*'.
	
	WNDPROC := #'void*'.
	HANDLE := #'void*'.
	HWND := #'void*'.
	LPHANDLE := #'HANDLE*'.
	HINSTANCE := HMODULE := HICON := HCURSOR := HBRUSH := HANDLE
]

{ #category : #'private - initialization' }
SmockWindowsTypes class >> initStringTypes [
	TCHAR := #WinTCHAR.
	LPTCH := 'TCHAR*'.
	WCHAR := 'wchar_t'.
	LPWCH := 'WCHAR*'.

	LPTSTR := 'char*'.
	LPWSTR := 'char*'.
	LPCWSTR := 'char*'.
	LPCSTR := 'char*'.
	LPSTR 	 := 'char*'.
	
	LPTSTR := 'char*'.
	LPWSTR := 'char*'.
	
	LPCTSTR := LPTSTR
]

{ #category : #'private - initialization' }
SmockWindowsTypes class >> initialize [ 
<script>
self initKnownTypes.
self initStringTypes.
]
