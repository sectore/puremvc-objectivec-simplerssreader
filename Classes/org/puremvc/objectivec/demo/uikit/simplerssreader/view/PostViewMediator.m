//
//  PostViewMediator.m
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

#import "PostViewMediator.h"
#import "PostViewController.h"
#import "Notifications.h"


@implementation PostViewMediator


#pragma mark init dealloc

-(void)dealloc 
{
	[ super dealloc ];
}


#pragma mark mediator methods


+(NSString *)NAME 
{
	return @"PostViewMediator";
}

-(PostViewController *)viewComponent 
{
	return viewComponent;
}

-(void)initializeMediator 
{
	self.mediatorName = [PostViewMediator NAME];
	blogProxy = (BlogProxy *)[facade retrieveProxy:[BlogProxy NAME]];
}

-(void)onRegister 
{
}

#pragma mark notifications methods

-(NSArray *)listNotificationInterests 
{
	return [NSArray arrayWithObjects:	BLOG_POST_DETAIL, 
										BLOG_POST_DETAIL_FAILED, 
										nil];
}

-(void)handleNotification:(id<INotification>)notification 
{
	NSString *notificationName = [ notification name ];
	
	if ([ notificationName isEqual: BLOG_POST_DETAIL ]) 
	{
		[ viewComponent newBlogEntry:[ notification body ] ];	
	}
	else if ([notificationName isEqual: BLOG_POST_DETAIL_FAILED ]) 
	{
			
	}
	
}

@end
