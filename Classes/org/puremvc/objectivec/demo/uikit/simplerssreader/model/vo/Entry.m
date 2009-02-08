//
//  Post.m
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

#import "Entry.h"


@implementation Entry

@synthesize dateString;
@synthesize title;
@synthesize txt;
@synthesize blogTitle;


-(id)init
{
	if (self = [super init]) 
	{	
		title = [[NSMutableString alloc] init];
		dateString = [[NSMutableString alloc] init];
		txt = [[NSMutableString alloc] init];			
	}
	return self;
}

-(void)dealloc
{
	[blogTitle release];
	[dateString release];
	[title release];
	[txt release];	
	
	[super dealloc];
}


@end
