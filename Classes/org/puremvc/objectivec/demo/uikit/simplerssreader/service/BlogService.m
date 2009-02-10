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
	[ currentElement release ];	
	[ blogTitle release ];	
	[ currentEntry release ];
	
	[super dealloc];
}

-(id)init
{
	if (self = [super init]) 
	{	
		blogEntries = [ [NSMutableArray alloc] init ];		
	}
	return self;
}




-(BOOL)getBlogData:(NSURL *) url
{
	// release previous blog entries if neccessary
	if ( blogEntries )
		[ blogEntries removeAllObjects ];
	
	if ( currentEntry )
		[ currentEntry release ];	
	
	NSXMLParser *feedParser = [ [NSXMLParser alloc] initWithContentsOfURL: url ];
	
    [ feedParser setDelegate: self ];	
    [ feedParser setShouldProcessNamespaces: NO ];
    [ feedParser setShouldReportNamespacePrefixes: NO ];
    [ feedParser setShouldResolveExternalEntities: NO ];
	
	//
	// start parsing
	BOOL success;	
	success = [ feedParser parse ];
	
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
        [parser abortParsing];
    }

	currentElement = [elementName copy];

	if ( !blogTitle && [currentElement isEqual:@"title"]) 
	{
		blogTitle = [[NSMutableString alloc] init];
        return;
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
	if ( !currentEntry && !blogTitle )
		return;

	NSString *trimmedString = [value stringByTrimmingCharactersInSet: [ NSCharacterSet whitespaceAndNewlineCharacterSet ] ];

	if ( !currentEntry
		&& [currentElement isEqual:@"title"] )
	{
		[ blogTitle appendString: trimmedString ];	
		return;
	}
	
		
	if ( [currentElement isEqual:@"content:encoded"] ) 
	{
		if ( !currentEntry.txt )
			currentEntry.txt = [[NSMutableString alloc] initWithString: trimmedString];
		else
			[ currentEntry.txt appendString: trimmedString ];
	}
	else if ( [currentElement isEqual:@"pubDate"] ) 
	{
		if ( !currentEntry.dateString )
			currentEntry.dateString = [[NSMutableString alloc] initWithString: trimmedString];
		else
			[ currentEntry.dateString appendString: trimmedString ];
	}
	else if ( [currentElement isEqual:@"title"] ) 
	{
		if ( !currentEntry.title )
			currentEntry.title = [[NSMutableString alloc] initWithString: trimmedString];
		else
			[ currentEntry.title appendString: trimmedString ];
	}	
	
}


- (void)parser:(NSXMLParser *)parser 
		didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
{
	
	
    if ( [ elementName isEqual:@"item"] ) 
	{
		//
		// store entry
		currentEntry.blogTitle = [[NSString alloc] initWithString:blogTitle ];
        [ blogEntries addObject: currentEntry ];

        return;		
    }
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
	NSLog(@"blogEntries array has %d entries", [blogEntries count]);
}



@end
