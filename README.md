# Windows_Post_Install_BATCH
Post Install Script With Collections Of Online And Personal Scripts.

## Disclaimer!
An **INTERNET Connection** is required for this script to run properly.

~~Will have a full offline version down the road.~~ (Not Possible)

TASKLIST:

- [x] Script Creation
- [x] IRM Version for using in terminal 
- [x] ~~Offline Install Version~~ (Not Possible)
- [ ] EXE Version? (Maybe)
 
## HOW TOs

Option 1: Either [download](https://github.com/8mpty/Windows_Post_Install_BATCH/archive/refs/heads/main.zip) the zip file and launch the "Install.bat" file 
 
Option 2: Using the Powershell/Terminal commands below ☟

<details><summary>Command (Click Me)</summary>
<p>

```
irm 8mpty.com/post | iex
```
or (A bit more Secure)
```
irm https://8mpty.com/post | iex
```
or (use if DNS issues)
```
irm https://raw.githubusercontent.com/8mpty/Windows_Post_Install_BATCH/main/psfile/empty.ps1 | iex
```
</p>
</details>

~~EXE and MSI formats will be provided at a later data.~~ (Maybe)


## Additional Options

You may also pass in **UNLIMITED** arguments into the script downloaded locally or over the internet with "irm". (See [Additional Disclaimers](https://github.com/8mpty/Windows_Post_Install_BATCH/tree/main#additional-options-disclaimers)))

**ARGUMENTS MUST BE SEPERATE WITH A SPACING TO WORK** EX. ```5 6``` and not ```56```

Credits: https://massgrave.dev/command_line_switches.html

Example Arguments are:

<details><summary>If Downloaded Locally Examples (Click Me)</summary>
<p> 
 
```
.\Install.bat 5
```
Which will go to the [Extras] page.

If running:
```
.\Install.bat 5 6
```
Will go the [Extras] page and execute option [6] which is creating the script shortcut.
</p>
</details>


<details><summary>If Running with IRM Examples (Click Me)</summary>
<p>

Default is ```irm post.8mpty.xyz | iex```,

But if you want to pass in arguments:
```
iex "&{$(irm post.8mpty.xyz)} 5"
```
Which will go to the [Extras] page.

If running:
```
iex "&{$(irm post.8mpty.xyz)} 5 6"
```
Will go the [Extras] page and execute option [6] which is creating the script shortcut.
</p>
</details>

## Additional Options (Disclaimers)

~~Ofcourse these options are not only limited to Options 5 & 6, other options are availble to try but do **NOTE** that only a max of "2" options are availble.~~

~~As of right now, this script is not able to run further than "2" arguments like ```iex "&{$(irm post.8mpty.xyz)} 5 3 1"```.~~

~~Above is meant to go to the [Extras] Page and execute option [3] which is "Removal of Folders" and will execute [1] to confirm the removal but as of this current iteration of the script, it is **NOT POSSIBLE** yet.~~

The script is now able to run unlimited arguments as long as the arguments corresponds to the correct options in the script.

Fixed in Commits [986aa9a](https://github.com/8mpty/Windows_Post_Install_BATCH/commit/986aa9ab654410e7510039f2ac0ead36be0ef178#diff-4c4389ae3adbd3780d385439f1e161d08aade4df4cc5fd544c6ae4c0e45c7320) , [61aaf40](https://github.com/8mpty/Windows_Post_Install_BATCH/commit/61aaf4015acd8c20b287b41212bc69b5b1c57596) and [e0fb8c3](https://github.com/8mpty/Windows_Post_Install_BATCH/commit/e0fb8c31d21ad3345a0906292ee633af6f2b370a).

EX. ```iex "&{$(irm post.8mpty.xyz)} 5 4 2 5 3 1 1 7 0"```

<details><summary>Explanation from left to right argumetns: (Click Me)</summary>
<p>

```
5: Go to [Extras] page

4: Execute [UAC_Verification] Option

2: Select option [2] which is [Disable + Enchanced] option

5: Go back to [Extras] page

3: Execute [Remove or Restore folders] option 

1: Select [Remove Folders] Option

1: Select [64 Bit] Architecture

7: Remove [ALL] folders

0: Exits the script
```
</p>
</details>

## References (Scripts)
 
Windows Activator (https://github.com/massgravel/Microsoft-Activation-Scripts)
 
Program's Installer (https://github.com/ChrisTitusTech/winutil)
 
Winget Standalone Installer (https://christitus.com/installing-appx-without-msstore/)
 
Windows AutoLogon (https://github.com/mbd-shift/Windows10-Autologon)
