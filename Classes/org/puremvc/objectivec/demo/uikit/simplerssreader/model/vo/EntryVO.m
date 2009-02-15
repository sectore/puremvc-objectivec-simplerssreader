//
//  EntryVO.m
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

#import "EntryVO.h"


@implementation EntryVO

@synthesize dateString;
@synthesize title;
@synthesize txt;
@synthesize blogTitle;

-(void) dealloc
{
	[ dateString release ];
	[ title release ];
	[ txt release ];
	[ blogTitle release ];
	
	[ super dealloc ];
}

@end
