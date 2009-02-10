//
//  BlogProxy.m
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

#import "BlogProxy.h"
#import "Notifications.h"
#import "BlogService.h"


//#define BLOG_FEED	@"http://www.websector.de/blog/feed/"
#define BLOG_FEED	@"http://localhost/ws2005/feed.xml"

@implementation BlogProxy

#pragma mark init && dealloc

-(void)dealloc
{
	[ super dealloc ];
}

#pragma mark proxy standard methods

-(void)initializeProxy 
{
	[super initializeProxy];
	self.proxyName = [BlogProxy NAME];
	self.data = [NSMutableArray array];

}

+(NSString *)NAME 
{
	return @"BlogProxy";
}



-(NSMutableArray *)data 
{
	return data;
}


#pragma mark remote proxy methods

-(void)getAllEntries
{	
	//
	// clear data
	[ data removeAllObjects ];
	//[ self getBlogData ];
	
	// 
	// Spawn a thread to fetch all needed data without freezing the UI
	// while loading and parsing XML data
    [NSThread detachNewThreadSelector:@selector( startParsing ) 
							 toTarget:self 
							withObject:nil];	
	 
}


-(void)startParsing
{	
		
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	BlogService *service = [[ BlogService alloc ] init];
	
	BOOL success;
	success = [ service getBlogData: [NSURL URLWithString: BLOG_FEED] ];

	if ( success )
	{
		data =  [ service.blogEntries copy ];
		[ self sendNotification: BLOG_POSTS_RESULT body: data ];		
	}
	else
	{
		[ self sendNotification: BLOG_POSTS_FAILED ];	
	}
	
	[ service release ];
	[ pool release ];
	
}

-(void)entryById:(NSUInteger) entryId
{
	if ( [data count] > entryId )
	{
		EntryVO *entry = [data objectAtIndex: entryId];
		[ self sendNotification: BLOG_POST_DETAIL body: entry ];		
	}
	else
	{
		[ self sendNotification: BLOG_POST_DETAIL_FAILED ];	
	}

}


@end
