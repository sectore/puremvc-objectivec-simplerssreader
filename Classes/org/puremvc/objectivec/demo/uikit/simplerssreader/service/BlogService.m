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

@implementation BlogService

@synthesize blogEntries;

#pragma mark init && dealloc

-(void)dealloc
{
	[ blogEntries release ];	
	blogEntries = nil;
	
	[ currentElement release ];	
	[ currentEntry release ];
	[ blogTitle release ];
	[ currentEntryVOProperty release ];
	
	[super dealloc];
}

-(id)init
{
	if (self = [super init]) 
	{	
		currentEntryVOProperty = [[NSMutableString alloc] init];
		blogEntries = [ [NSMutableArray alloc] init ];
	}
	return self;
}




-(BOOL)getBlogData:(NSURL *) url
{
	// release previous blog entries if neccessary
	if ( blogEntries )
		[ blogEntries removeAllObjects ];

	
	NSXMLParser *feedParser = [ [NSXMLParser alloc] initWithContentsOfURL: url ];
	
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

	currentElement = [elementName copy];

	if ( [currentElement isEqual:@"title"] 
		|| [currentElement isEqual:@"content:encoded"]
		|| [currentElement isEqual:@"pubDate"]
		|| [currentElement isEqual:@"title"] )
	{
		currentEntryVOProperty = [ [NSMutableString alloc] init];
		return;
	}
	else
	{
		[ currentEntryVOProperty release ];
		currentEntryVOProperty = nil;
	}
	
    if ( [currentElement isEqual:@"item"]) 
	{
		parsedItemCounter++;
		currentEntry = [[EntryVO alloc] init];	
        return;
	}
	
}



- (void)parser:(NSXMLParser *)parser 
		foundCharacters:(NSString *)value 
{
	if ( currentEntryVOProperty )
		[ currentEntryVOProperty appendString: [value stringByTrimmingCharactersInSet: [ NSCharacterSet whitespaceAndNewlineCharacterSet ] ] ];	
	//[ currentEntryVOProperty appendString: value ];	
}


- (void)parser:(NSXMLParser *)parser 
		didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
{
	
	// the title of the entire blog - not of the post entry
	if ( [currentElement isEqual:@"title"] && !blogTitle )
	{
		blogTitle = [ [NSMutableString alloc] initWithString: currentEntryVOProperty];
			
		return;
	}
	
	
	if ( [currentElement isEqual:@"content:encoded"] ) 
	{
		currentEntry.txt = currentEntryVOProperty;		
	}
	else if ( [currentElement isEqual:@"pubDate"] ) 
	{
		currentEntry.dateString = currentEntryVOProperty;
	}
	else if ( [currentElement isEqual:@"title"] ) 
	{
		currentEntry.title = currentEntryVOProperty;
	}
	else if ( [ elementName isEqual:@"item"] ) 
	{
		//
		// store entry
		currentEntry.blogTitle = [[NSString alloc] initWithString:blogTitle ];
        [ blogEntries addObject: currentEntry ];
		
		[ currentEntry release ];
		currentEntry = nil;
		
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
