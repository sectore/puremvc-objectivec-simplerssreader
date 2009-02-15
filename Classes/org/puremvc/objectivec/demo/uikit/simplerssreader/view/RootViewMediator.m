//
//  MainMediator.m
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

#import "RootViewMediator.h"
#import "RootViewController.h"
#import "Notifications.h"


@implementation RootViewMediator


#pragma mark init dealloc

-(void)dealloc 
{
	[super dealloc];
}


#pragma mark mediator methods


+(NSString *)NAME 
{
	return @"RootViewMediator";
}

-(RootViewController *)viewComponent 
{
	return viewComponent;
}



-(void)initializeMediator 
{
	self.mediatorName = [RootViewMediator NAME];
	blogProxy = (BlogProxy *)[facade retrieveProxy:[BlogProxy NAME]];
}

-(void)onRegister 
{
	[ self.viewComponent setDelegate: self ];
}

#pragma mark notifications methods

-(NSArray *)listNotificationInterests 
{
	return [NSArray arrayWithObjects: BLOG_POSTS_RESULT,
										BLOG_POSTS_FAILED,
										BLOG_POST_DETAIL,
										nil];
}

-(void)handleNotification:(id<INotification>)notification 
{
	NSString *notificationName = [ notification name ];
	
	if ([notificationName isEqual: BLOG_POSTS_RESULT ]) 
	{
		[ viewComponent showBlogEntries:[ notification body ] ];
		
	}
	else if ([notificationName isEqual: BLOG_POSTS_FAILED ]) 
	{
	
	}	
	else if ([notificationName isEqual: BLOG_POST_DETAIL ]) 
	{
		[ viewComponent showBlogEntry ];		
	}

}



-(void)getBlogEntries
{
	[ blogProxy getAllEntries ];
}

-(void)getBlogEntry:(NSUInteger)blogId
{
	[ blogProxy entryById:(NSUInteger) blogId ];
}




@end
