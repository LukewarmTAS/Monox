# Monox


Hello Unix Userland!


I'm doing a completely free operating system (just a hobby, won't be big and professional like Linux) for 64-bit x86 PCs. This has been brewing since April 2023, but is just starting to pick up progress. Here are some ideas for what I have planned. Feel completely encouraged by the wrath of god to suggest ideas to improve the system.


In this system there are three primary attributes used to refer to a given file or directory from any working directory:


Universally Unique Identifier: a 256-byte binary value that programs use to refer to the given file or directory (cannot be changed)

Private Alias: a null-terminted string used by only you to refer to the given file or directory (can always be changed)

Public Alias: a null-terminted string used by everybody to refer to the given file or directory (can only be initialized by the creator)


Because the UUID and Public Alias are the same on everybody's system, the benefit of this is it cuts off the source of confusing errors that would occur in Linux when trying to resolve references to files and directories. Another major cause of confusing errors in Linux is the permission system. So I am redesigning it. Each program is assigned a privilege codes which defaults to the logged in user's privilege code. The maximum number of users for this system is 64 and they are indexed 0-63. The privilege code for a given user is (1 << USER), where USER equals the given user's index. Each user has their own filespace. If a user wishes to access another user's files they need that other user to type in their password for authentication purposes. Finally, I need to clean the shell language up because it is very inconsistent and the naming conventions are heavily cryptic.
