//
//  BlogService.h
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

#import <Foundation/Foundation.h>
#import "EntryVO.h"
#import "BlogProxy.h"


@interface BlogService : NSObject <IBlogService>
{
	NSString *keyInProgress;
	NSMutableString *blogTitle, *textInProgress;
	
	EntryVO *currentEntry;
	NSMutableArray *blogEntries;
}

@property( copy ) NSMutableArray *blogEntries;

-(BOOL) getBlogData:(NSURL *) url;

@end
