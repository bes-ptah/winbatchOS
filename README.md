# WinBatchX
###### What is WinBatchX? 

###### WinBatchX is an operating system in batch script inside any supported Windows 8, 8.1, 10 OR 11 64-bit Release. The latest release is 16.0 - The 10X Update. It has more than 100 successful working builds and 3 known working releases.
###### This has been tested to work with Windows 11 and Insider Releases and (was just tested) to work with Windows NT Version 6.1 or higher.

###### Most of the builds in WinBatchX have been passing. It is near a year since the start of WinBatchX which has been done myself.
###### WinBatchX does not support 32-bit as of 16.0.
***

###### The latest **stable** build is currently **1624**.
###### The latest **developing** build is **1628**.
###### The latest **Canary** build is **1689**. These releases will be out in the next week or two.

###### The latest **stable release** is **16.0**.
###### The latest **developing release** is **16.1 (not developed yet)**.

***
##### Branch - All Supported 
###### Beta Branch | Stable Builds **1615,16,17,18,19,20,21,22,23,23,25,26**
###### General Releases Branch | Releases **15.5 (b1572), 16.0 (b1600)** | Builds 1601,1602,1603,1604,1605 (other builds up to 1615 are unsupported)
###### Low Resolutions Branch | No Builds. 

###### All releases from WinBatchX are supported if the build is able to take in a update from this repository. This is open-source so even your copy (or your custom build) of WinBatchX is allowed to pull releases from this build.

***

###### Note: WinBatchX's latest updates has moved to the wiki page. [Click this link to get over there.](https://github.com/bes-ptah/WinBatchX/wiki)

###### Note: WinBatchX's Support Page has moved to the wiki page. [Click this link to get over there.](https://github.com/bes-ptah/WinBatchX/wiki/Support-Page)



# WinBatchX Repository Update System
###### The WinBatchX Repository Update System. WinBatchX uses wget.exe to download files from github while Windows Defender scans the files coming in.

###### **This repository support will end on June 1 2021. All updates will be redirected to the main "WinBatchX-Operating-System".**

###### **For older builds (1532-1558) will be marked with error code 0x02- unsupported release.**

###### **WinBatchX 15.4 (April 2021 Update) did not come with wget.exe. No user will be notified of WinBatchX 16 because it didn't come with it. (We were planing that before Build 1540)**


##### Requires: 

###### -Windows 10 ~~1903~~, 1909, 2004, 20H2, 21H1, 20H2, 21H1 or (21H2 (windows 11 development builds right now)) or any supported release higher than 1909.

###### - Windows NT 6.1 and up supported.

###### -Any Windows 10/11 Supported Insider Builds   

###### -WILL not support on 32-bit systems for windows 11 as 32-bit does not exist. Works on Intel 64, x64, and AMD64 Processors. ARM64 not tested.
 




# How to install

#### **NOTE: WinBatchX has removed support for Windows 10 Version 1903. It will continue to work on that version, but know no support is coming for that version of Windows 10.**

###### Last Updated 12-1-21:
###### WinBatchX is designed to be portable. It does not use your registry or anything. It has it's kind-of own registry with core interface files for a GUI, and WinBatchX.bat itself. WinBatchX.bat has the apps until 17.0, when it retrieves the code from your local NIFS file system inside the system (1630 and lower) folder.
###### To grab a copy of the latest stable release, Click on the link that says "+ %number% of releases", and the latest release is without a pre-release tag.
###### 1. Click on the latest release on the right. For smaller screens, scroll the bottom of the page, then click on the latest release.
###### 2. Download the latest version or build from the releases page.
###### 3. Unzip the file to a destination. This is a .zip file, meaning Windows Explorer can read it. If a dialog pops up, click on Windows Explorer, then press ok. It should open it up. You can also use 3rd-Party tools to unzip it.
###### 4. Click "WinBatchX.bat". It will start up, setting a number of variables while retriving updates. After the updates, all the batch files, iamges, and the update .zip package is scanned by your local Windows Defender / Security command line utility.
###### 5. The password is always "bes". (The owner of WinBatchX's first name)

###### **Follow these directions if you are on build 1564 or higher**
###### 5. The Username is "Guest" and the Password is "bes". Remember to change this as soon as possible by going to SETTINGS > ACCOUNTS > Change Password. You can change the username too.

###### **Build 1560+ Changing Usernames and Passwords are only available Builds 1560 and up.**

###### **Build 1538+: Changing Usernames and Passwords manually can be done by going into SYSTEM > CONFIG.BAT in Windows Explorer.**

###### 6. You reached the WinBatchX desktop!

###### NOTE Running WinBatchX as an adminstrator will fail since the file will change directory to the System32 Windows Folder. You should not move the GUI files and batch plugins to your system32 folder, because it might cause your system to fail.
###### NOTE Setup for WinBatchX will come in later builds of 16.1, including 17.0.

