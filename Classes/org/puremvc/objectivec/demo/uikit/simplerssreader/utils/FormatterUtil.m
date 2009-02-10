//
//  FormatterUtil.m
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

#import "FormatterUtil.h"


@implementation FormatterUtil



+(NSString *) formatFeedDateString:(NSString *) feedDateString newFormat:(NSString *) newFormat
{
	
	//create formatter and format
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

	// we have to force the locale to avoid unexpected issues formatting data, e.g. on an German iPhone ;)
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[dateFormatter setLocale:usLocale];
	
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];

	NSDate *formattedDate = [dateFormatter dateFromString: feedDateString];
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	
	if (newFormat != nil )
	{
		[outputFormatter setDateFormat: newFormat];
	}
	else
	{
		[outputFormatter setDateFormat:@"d MMM yyyy"];
	}
	
	NSString *formattedDateString = [outputFormatter stringFromDate:formattedDate];
	
	[dateFormatter release];
	[outputFormatter release];
	
	return formattedDateString;


}
@end
