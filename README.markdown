#Simple RSS reader for iPhone using PureMVC Standard for Objective-C

##Author

Jens Krause // [WEBSECTOR.DE](http://www.websector.de)

##Licence
Licensed under the Mozilla Public License 1.1. [http://www.mozilla.org/MPL/MPL-1.1.html](http://www.mozilla.org/MPL/MPL-1.1.html)

##Installation:


* Download the latest [PureMVC Objective-C package (v.1.1)](http://trac.puremvc.org/PureMVC_ObjectiveC/wiki/Downloads) and store it anywhere on your machine
* Point to PureMVC Objective-C package using a environment variable in Xcode:
	* Open XCode -> Preferences -> Source Trees and add a Xcode environment variable called PUREMVC_SCR
	* Click "+" button and enter a setting name "PUREMVC_SCR", a display name "puremvc-objective-c" and a path pointing to the source of PureMVC {yourPuremvcFolderDownloadedBefore}/puremvc-objective-c/trunk/src 
* Add the PureMVC Objective-C package as a static library to the project as follow:	
	* Open project of puremvc-objectivec-simplerssreader in XCode
	* Goto Project -> Edit project settings -> Build and enter at "User Header Search Path" the enviroment variable of PureMVC created before "$(PUREMVC_SCR)". Option named "recursive" should be enabled.
	* From Groups and Files pane right click on Fameworks -> Add Existings files. Browse and add {yourPuremvcFolderDownloadedBefore}/puremvc-objective-c/trunk/bin/PureMVC/headers/PureMVC _ ObjectiveC _ 1 _ 1.a Option named "Copy items into destination group's folder (if needed)" should be disabled!
	* Check in Groups and Files -> Targets -> Link Binary with Libraries that "PureMVC_ObjectiveC_1_1.a" is listed
	* Build and run project
	
For detailed information about using static libraries check the great article [Easy, Modular Code Sharing Across iPhone Apps: Static Libraries and Cross-Project References](http://www.clintharris.net/2009/iphone-app-shared-libraries/) by Clint Harris.	

##Note
If you get an error "CodeSign error: a valid provisioning profile is required", you may need a valid provisioning profile to run and build this app. Check for more information the following article: http://iphonesdkdev.blogspot.com/2009/01/codesign-error-valid-provisioning.html


Have fun!

-Jens