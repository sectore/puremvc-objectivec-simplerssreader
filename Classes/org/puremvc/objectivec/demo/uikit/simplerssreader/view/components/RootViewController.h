//
//  RootViewController.h
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
#import "PostViewController.h"
#import "Entry.h"

@protocol RootViewControllerDelegate

-(void)getBlogEntries;
-(void)getBlogEntry:(NSUInteger)blogId;

@end


@interface RootViewController : UITableViewController
{	
	PostViewController *postView;
	NSMutableArray *blogEntries;
	id<RootViewControllerDelegate> delegate;
	UIActivityIndicatorView *feedLoader;
}

@property(nonatomic, retain) PostViewController *postView;
@property(nonatomic, retain) id<RootViewControllerDelegate> delegate;

-(void)showBlogEntry;
-(void)getBlogEntries;
-(void)showBlogEntries:(NSMutableArray *)data;
-(void)showLoader;
-(void)hideLoader;


@end




