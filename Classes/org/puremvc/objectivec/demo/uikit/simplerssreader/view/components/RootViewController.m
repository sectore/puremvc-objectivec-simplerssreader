//
//  RootViewController.m
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

#import "RootViewController.h"
#import "EntryVO.h"
#import "BlogEntryCell.h"
#import "FormatterUtil.h"

@implementation RootViewController

@synthesize postViewController;
@synthesize delegate;


#pragma -
#pragma mark init && dealloc

+(RootViewController *)rootViewController
{
	return 	[[[RootViewController alloc] init ] autorelease ];
}


-(id)init
{
	if (self = [super init]) 
	{	
		blogEntries = [[ NSMutableArray alloc ] init ];
		
		postViewController = [PostViewController postViewController];
	}
	return self;
}

- (void)dealloc 
{
	[ blogEntries release ];
	[ feedLoader release ];	
	
	[ postViewController release ];
	[ delegate release ];
	
    [super dealloc];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

	UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] init];
	backBarButton.title = NSLocalizedString(@"LABEL_BACK", @"LABEL_BACK STRING not found");
	self.navigationItem.backBarButtonItem = backBarButton;
	[backBarButton release];
	
	[super loadView];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	
    [super viewDidLoad];

	[self setTitle: NSLocalizedString(@"TITLE_ROOT", @"TITLE_ROOT not found")];
	
	[self showLoader];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


-(void)showLoader
{

	feedLoader = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(150, 187, 20, 20)];
	[feedLoader startAnimating];	
	[feedLoader setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
	[self.view addSubview: feedLoader];
	
}


-(void)hideLoader
{
	[ feedLoader stopAnimating];
	[ feedLoader removeFromSuperview ];
	[ feedLoader release ];	
	feedLoader = nil;	
}


#pragma mark -
#pragma mark table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [ blogEntries count ];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
   NSUInteger row = [indexPath row];
	
    static NSString *CellId = @"BlogEntryCellIdentifier";
    
    BlogEntryCell *cell = (BlogEntryCell *) [ tableView dequeueReusableCellWithIdentifier: CellId ];
    if (cell == nil) 
	{
		NSArray *nib = [ [ NSBundle mainBundle] loadNibNamed:@"BlogEntryCell" 
												owner:self 
												options:nil ];
		
		for (id object in nib)
		{
			if ( [object isKindOfClass:[ UITableViewCell class]])
			{
				cell = object;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				break;
			}
		}
	
    }
    
	if ( [ blogEntries count ] > 0 )
	{
		EntryVO *entryVO = [ blogEntries objectAtIndex: row ];
		// headline
		cell.headline.text = [NSString stringWithFormat: @"%@ // %@", 
														entryVO.blogTitle,
														[ FormatterUtil formatFeedDateString: entryVO.dateString 
																				newFormat: @"d'.'MM'.'yyyy"] 
														] ;
		cell.label.text = entryVO.title;
	}
	else
	{
		cell.text = NSLocalizedString(@"LABEL_LOADING", @"LABEL_LOADING not found")	;
	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSUInteger row = [indexPath row];
	
	[ self.delegate getBlogEntry:row ];
}

#pragma -
#pragma mark methods which are called by its mediator

-(void)showBlogEntry
{	
	[[self navigationController] pushViewController:postViewController
										   animated:YES];
}


-(void)getBlogEntries
{
	[self showLoader];
	[delegate getBlogEntries];
}

-(void)showBlogEntries:(NSMutableArray *)data
{
	[ blogEntries release ];
	blogEntries = [ data retain ];	

	[self hideLoader ];
	[ self.tableView reloadData ];
}


@end
