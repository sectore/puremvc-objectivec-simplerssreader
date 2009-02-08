//
//  ApplicationFacade.m
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

#import "ApplicationFacade.h"
#import "Notifications.h"
#import "StartupCommand.h"


@implementation ApplicationFacade

-(void)startup:(id)rootView 
{
	[ self sendNotification:APP_STARTUP body:rootView ];
}

+(ApplicationFacade *)getInstance 
{
	return (ApplicationFacade *)[super getInstance];
}

-(void)initializeController 
{
	[super initializeController];
	
	[ self registerCommand:APP_STARTUP commandClassRef:[ StartupCommand class ] ];
}

@end
