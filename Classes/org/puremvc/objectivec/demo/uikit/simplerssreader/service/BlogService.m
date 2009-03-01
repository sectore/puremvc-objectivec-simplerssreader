//
//  BlogService.m
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
//
//	BlogService based on an example "Parsing XML in Cocoa" by Aaron Hillegass (http://weblog.bignerdranch.com/?p=48)
//	and Apples example "SeismicXML" at iPhoneDevCenter (https://developer.apple.com/iphone/library/samplecode/SeismicXML/index.html)
//

#import "BlogService.h"

static NSUInteger parsedItemCounter;
static NSSet *interestingKeys;


@implementation BlogService

@synthesize blogEntries;

#pragma mark init && dealloc

-(void)dealloc
{
	[ blogEntries release ];
	[ blogTitle release ];
	
	[super dealloc];
}


+ (void)initialize
{
    if ( !interestingKeys ) 
	{
        interestingKeys = [ [NSSet alloc] initWithObjects:	@"title",
															@"content:encoded",
															@"pubDate",
															nil];
    }
}


-(BOOL)getBlogData:(NSURL *) url
{

	[ blogEntries release ];
	blogEntries = [ [NSMutableArray alloc] init ];
	
//	NSLog( @"1. retainCount of: %i",[url retainCount] );
	
	//
	// Note: It seems, that NSXMLParser is causing a leak
	// @see: http://www.iphonedevsdk.com/forum/iphone-sdk-development/3174-memory-leak.html#post41589
	// The following "solution" doesn't work :-(	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	NSXMLParser *feedParser = [ [NSXMLParser alloc] initWithContentsOfURL: url ];
	
//	NSLog( @"2. retainCount of: %i",[url retainCount] );
	

    [ feedParser setDelegate: self ];	
    [ feedParser setShouldProcessNamespaces: NO ];
    [ feedParser setShouldReportNamespacePrefixes: NO ];
    [ feedParser setShouldResolveExternalEntities: NO ];
	
	//
	// start parsing
	BOOL success;	
	success = [ feedParser parse ];

	[ feedParser release ];
	
	return success;
}

#pragma mark NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    parsedItemCounter = 0;
}


#define MAX_ENTRIES 10

- (void)parser:(NSXMLParser *)parser 
				didStartElement:(NSString *)elementName 
				namespaceURI:(NSString *)namespaceURI 
				qualifiedName:(NSString *)qName 
				attributes:(NSDictionary *)attributeDict 
{	

	if ( parsedItemCounter > MAX_ENTRIES ) 
	{
        [ parser abortParsing ];
    }

    if ( [elementName isEqual:@"item"]) 
	{
		parsedItemCounter++;
		currentEntry = [[EntryVO alloc] init];	
        return;
	}


    if ( [interestingKeys containsObject:elementName] ) 
	{
        keyInProgress = [elementName copy];
        textInProgress = [[NSMutableString alloc] init];
    }
	
}



- (void)parser:(NSXMLParser *)parser 
		foundCharacters:(NSString *)value 
{
	[ textInProgress appendString: value ];	
}


- (void)parser:(NSXMLParser *)parser 
		didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
{
	
	// store title of the entire blog - not of the post entry
	// Note: We have to different @"title", because within XML data twice.
	if ( [ elementName isEqual:@"title" ] && blogTitle == nil )
	{
		[ blogTitle release ];
		
		blogTitle = [ [NSMutableString alloc] initWithString: textInProgress];
			
		return;
	}
	
	
	if ( [ elementName isEqual:@"item"] ) 
	{
		//
		// store entry
		currentEntry.blogTitle = [ blogTitle copy ];
        [ blogEntries addObject: currentEntry ];
		
		[ currentEntry release ];
		currentEntry = nil;
		
		return;
		
    }
	
	
	if ( [ elementName isEqual:keyInProgress ])
	{
		if ( [elementName isEqual:@"content:encoded"] ) 
		{
			currentEntry.txt = textInProgress;		
		}
		else if ( [elementName isEqual:@"pubDate"] ) 
		{
			currentEntry.dateString = textInProgress;
		}
		else if ( [elementName isEqual:@"title"] ) 
		{
			currentEntry.title = textInProgress;
		}

		[ textInProgress release ];
		textInProgress = nil;
		
		[ keyInProgress release ];
		keyInProgress = nil;
	}
	
	
	else 
	{
		//NSLog(@"uneeded XML element to store: %@", elementName);
	}
	
	
	
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
	NSLog(@"blogEntries array has %d entries", [blogEntries count]);
}



@end
