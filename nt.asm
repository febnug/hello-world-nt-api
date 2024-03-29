extern NtWriteFile
extern NtTerminateProcess

%define NtCurrentPeb() gs:[0x60]
%define ProcessParameter 32
%define StandardOutput 40
%define NtCurrentProcess() -1

section .rdata
	msg db `Hello, world!\n\0`
section .bss
	IoStatusBlock resb 16
section .text
	global main
main:
        sub rsp, 72			; Clang use stack allignment from return address for passing argument
	mov rcx, NtCurrentPeb()
	mov rcx, ProcessParameter[rcx]
	mov rcx, StandardOutput[rcx]
	xor edx, edx
	xor r8d, r8d
	xor r9d, r9d
	mov qword 32[rsp], IoStatusBlock
	mov qword 40[rsp], msg
	mov qword 48[rsp], 14
	mov qword 56[rsp], 0
	mov qword 64[rsp], 0
	call NtWriteFile

	mov rcx, NtCurrentProcess()
	xor edx, edx
	call NtTerminateProcess
	int3
