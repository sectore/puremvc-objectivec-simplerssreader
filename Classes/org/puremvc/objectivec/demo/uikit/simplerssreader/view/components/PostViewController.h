//
//  PostViewController.h
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

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface PostViewController : UIViewController 
{
	IBOutlet UIWebView *webView;
}

-(void)newBlogEntry:(Entry *) data;

@end
