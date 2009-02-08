//
//  ApplicationFacade.h
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
#import "Facade.h"

@interface ApplicationFacade : Facade 
{
	

}

+(ApplicationFacade *)getInstance;

-(void)startup:(id)rootView;

@end
