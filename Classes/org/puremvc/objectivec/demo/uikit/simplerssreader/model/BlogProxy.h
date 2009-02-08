//
//  BlogProxy.h
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
#import "Proxy.h"
#import "Entry.h"


@protocol IBlogService
-(BOOL)getBlogData:(NSURL *) url;
@end


@interface BlogProxy : Proxy 
{
	Entry *currentEntry;
}

-(void)getAllEntries;
-(void)startParsing;
-(void)entryById:(NSUInteger) entryId;

@end
