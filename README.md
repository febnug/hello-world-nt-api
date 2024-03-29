# Hello World NT API

![gambar](https://user-images.githubusercontent.com/86765295/208801010-ce0c49d5-9c6c-4c4d-b470-9eb6a3be9b0d.png)

I made this repo because I found many people asking _How to Hello World x64 Assembly using Windows System Call_ across the internet and here we are :). This code is [NASM](https://nasm.us/) specific.

This program is still depend on `ntdll.dll` because NT system call number changed across version _~unlike Linux~_.

> You _should not use this program for production or deployment_ because undocumented stuff may behave differently across windows version.

## Some Notes
### Calling convention
NT System Call Calling Convention is same like the userspace.

Except the first argument is placed on `R10` (`syscall` destroy `RCX` as return address `RIP` and `R11` as rflags as documented on [x64 ABI conventions](https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions?view=msvc-170#register-volatility-and-preservation). 

Analyze `ntdll.dll` and you will look `mov r10, rcx`.

| System Call Number | Arg0 | Arg1 | Arg2 | Arg3 |
| ------------------ | ---- | ---- | ---- | ---- |
| `RAX` | `R10` | `RDX` | `R8` | `R9` |

The stack argument is placed at `[rsp + 32 + 8]` due to shadow store and return address from `call NtXxx` sub-routine.

### Different NT version behaviour

This is slightly bother me, but I tried this on NT version number 5.2 (Windows Server 2003) and 6.1 (Windows 7) it doesn't work.

Seems like the program started working from NT version number 6.3 (Windows 8.1), might be work on 6.2 (Windows 8) but haven't test it.

Andy Tanenbaum also classify Windows 8/8.1 as modern Windows.

-------

## Public Documentation

- [PE Format](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format)
- [Inside Native Applications](https://learn.microsoft.com/en-us/sysinternals/resources/inside-native-applications)
- [Windows Data Types](https://learn.microsoft.com/en-us/windows/win32/winprog/windows-data-types)
- [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170)
- [PEB Structure](https://learn.microsoft.com/en-us/windows/win32/api/winternl/ns-winternl-peb)
- [IO_STATUS_BLOCK structure (wdm.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ns-wdm-_io_status_block)
- [NtWriteFile function (ntifs.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntwritefile)
- [GetCurrentProcess function (processthreadsapi.h)](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getcurrentprocess)
- [ZwTerminateProcess function (ntddk.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntddk/nf-ntddk-zwterminateprocess)

## Resources
- [Linker](http://www.godevtool.com/Golink.zip)
- [ntdll.dll file](https://www.dll-files.com/download/8e361abf2f459718929ae37892fca037/ntdll.dll.html?c=bXIvc0NpYnk4dldvZjFGYmpRcGI5UT09)

## Undocumented

![](https://i.imgflip.com/751y23.jpg)

Special Thanks to [@ReactOS](https://github.com/reactos/) team for most of the undocumented parts :D
- [Windows Native API - Roger Orr [ACCU 2019]](https://accu.org/conf-docs/PDFs_2019/roger_orr_-_windows_native_api.pdf)
- [inline_syscall](https://github.com/JustasMasiulis/inline_syscall)
- [GetStdHandle](https://doxygen.reactos.org/df/d28/dll_2win32_2kernel32_2client_2console_2console_8c_source.html#l01170)
- [NtCurrentPeb](https://www.geoffchappell.com/studies/windows/km/ntoskrnl/inc/api/pebteb/peb/index.htm)
- [_RTL_USER_PROCESS_PARAMETERS](https://doxygen.reactos.org/d5/df7/ndk_2rtltypes_8h_source.html#l01529)
- [WriteConsole](https://doxygen.reactos.org/d5/d48/base_2setup_2usetup_2console_8c_source.html#l00174)
- [NtCurrentProcess](https://doxygen.reactos.org/db/dc9/nt__native_8h_source.html#l01657)
- [ExitProcess](https://doxygen.reactos.org/d9/dd7/dll_2win32_2kernel32_2client_2proc_8c_source.html#l01487) (Idk if it's necessary to do stuff before self terminate.)
