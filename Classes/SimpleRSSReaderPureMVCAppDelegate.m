//
//  SimpleRSSReaderPureMVCAppDelegate.m
//  SimpleRSSReaderPureMVC
//
/* 
 * 
 * @author        Jens Krause [www.websector.de]    
 * @date          02/01/09
 * @see           http://www.websector.de/blog/  
 *
 *  SimpleRSSReaderPureMVC is open source licensed under the Mozilla Public License 1.1.
 *
 */

#import "SimpleRSSReaderPureMVCAppDelegate.h"

#import "RootViewController.h"
#import "ApplicationFacade.h"

@implementation SimpleRSSReaderPureMVCAppDelegate

@synthesize window;
@synthesize nav;

- (void)dealloc 
{
	[ nav release ];
    [ window release ];
    [ super dealloc ];
}


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	
	RootViewController *rootView = [ RootViewController rootViewController ];
	nav = [[UINavigationController alloc] initWithRootViewController: rootView];

	[window addSubview: nav.view];
	[window makeKeyAndVisible];
	
	[[ApplicationFacade getInstance] startup: rootView];

}



@end
