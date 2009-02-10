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
#import "EntryVO.h"

@interface PostViewController : UIViewController 
{
	IBOutlet UIWebView *webView;
}

+(PostViewController *)postViewController;

-(void)newBlogEntry:(EntryVO *) data;

@end
