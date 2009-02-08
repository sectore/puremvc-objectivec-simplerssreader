//
//  FormatterUtil.h
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


@interface FormatterUtil : NSObject {

}

+(NSString *) formatFeedDateString:(NSString *) feedDateString newFormat:(NSString *) newFormat;

@end
