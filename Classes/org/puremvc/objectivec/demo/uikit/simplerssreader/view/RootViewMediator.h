//
//  MainMediator.h
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
#import "Mediator.h"
#import "BlogProxy.h"
#import "RootViewController.h"


@interface RootViewMediator : Mediator <RootViewControllerDelegate>
{
	BlogProxy *blogProxy;
}

@end
