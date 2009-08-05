#Simple RSS reader for iPhone using PureMVC Standard for Objective-C

##Author

Jens Krause // [WEBSECTOR.DE](http://www.websector.de)

##Licence
Licensed under the Mozilla Public License 1.1. [http://www.mozilla.org/MPL/MPL-1.1.html](http://www.mozilla.org/MPL/MPL-1.1.html)

##Installation:


* Download the latest [PureMVC Objective-C package (v.1.1)] (http://trac.puremvc.org/PureMVC_ObjectiveC/wiki/Downloads) and store it anywhere on your machine
* Add it as a static library to the project as follow:
	* Open XCode -> Preferences -> Source Trees to add a Xcode environment variables called PUREMVC_SCR
	* Therefore click "+" button and enter for setting name "PUREMVC_SCR", for display name "puremvc-objective-c" and point to the source of PureMVC as a path {your_puremvc_folder_downloaded_before}/puremvc-objective-c/trunk/src 
	* Open project of puremvc-objectivec-simplerssreader in XCode
	* Goto Project -> Edit project settings -> Build and enter for "User Header Search Path" the enviroment variable of PureMVC using "$(PUREMVC_SCR)". Option "recursive" should  be enabled.
	* From Groups and Files pane right click on Fameworks -> Add Existings files. Browse and add {your_puremvc_folder_downloaded_before}/puremvc-objective-c/trunk/bin/PureMVC/headers/PureMVC_ObjectiveC_1_1.a Option called "Copy items into destination group's folder (in needed)" should be disabled!
	* Check that in Groups and Files -> Targets -> Link Binary with Libraries "PureMVC_ObjectiveC_1_1.a" is listed
	* Build and run project
	
For detailed information about using static libraries check teh great article [Easy, Modular Code Sharing Across iPhone Apps: Static Libraries and Cross-Project References](http://www.clintharris.net/2009/iphone-app-shared-libraries/) by Clint Harris.	

##Note
If you get an Error "CodeSign error: a valid provisioning profile is required", you may need to run and build this app you may need a valid provisioning profile. Check for more information this: http://iphonesdkdev.blogspot.com/2009/01/codesign-error-valid-provisioning.html


Have fun!

-Jens