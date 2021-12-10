###### To experienced users like me out there here is how updating WinBatchX works:

###### 1. WGET.EXE downloads this repository's zip file and extracts it.
###### 2. Then tar (inside Windows b17063+ higher, I'm going to supply one for lower versions)  extracts the zip file.
###### 3. It will input update.exe. From here it does 2 things:
###### 4. If its lower than 1609 (not checked) it will delete news.bat inside the unzipped folder because Widgets is not in 16.0;
###### 5. It will delete this read me inside the unzipped folder; and
###### 6. It will read update.bat, which will read news.bat (if you have 1609+), patchupdates.bat, and updateWBX.bat. To break it down:

###### Update.Bat shows if it has a newer version and to check at github for a new version
###### News.bat is just widgets. A workaround coming soon. (Right now it just has some info about the latest version of WinBatchX, and needs to be slightly more useful)
###### PatchUpdates.bat will update your desktop for any security/User issue problems.
###### updateWBX.bat takes in the latest zip file from WinBatchX and updates it in the same folder*

###### *cannot change version number on the root folder.
