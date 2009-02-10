//
//  StartupCommand.m
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

#import "StartupCommand.h"
#import "BlogProxy.h"
#import "RootViewMediator.h"
#import "PostViewMediator.h"
#import "RootViewController.h"

@implementation StartupCommand

-(void)execute:(id<INotification>)notification 
{
	//
	// register proxies
	BlogProxy *blogProxy = [ BlogProxy proxy ];
	[ facade registerProxy: blogProxy ];
	
	//
	// register mediators
	RootViewController *rootView = [notification body];
	[ facade registerMediator: [ RootViewMediator withViewComponent: rootView ] ];
	[ facade registerMediator: [ PostViewMediator withViewComponent: rootView.postViewController ] ];
	
	//
	// get first data
	[ blogProxy getAllEntries ];
}

@end
