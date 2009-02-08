//
//  BlogEntryCell.h
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


@interface BlogEntryCell : UITableViewCell 
{
	IBOutlet UILabel	*headline;
	IBOutlet UILabel	*label;	
}


@property (nonatomic, retain) UILabel *headline;
@property (nonatomic, retain) UILabel *label;

@end
