//
//  PostViewController.m
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

#import "PostViewController.h"
#import "FormatterUtil.h"


@implementation PostViewController


#pragma mark --
#pragma mark init && dealloc

- (void)dealloc 
{
	[webView release];	
    [super dealloc];
}


-(void)viewDidLoad
{
	[ super viewDidLoad ];

}


- (BOOL)webView:(UIWebView *)webView 
		shouldStartLoadWithRequest:(NSURLRequest *)request 
		navigationType:(UIWebViewNavigationType)navigationType 
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) 
	{
		// open browser
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

#pragma mark methods which are calling by its mediator


#define STYLE_BLOG_ENTRY @"<style type='text/css'><!--* { font-family: Arial; color: #333; font-size: 1em;}  h1 { font-size: 1.4em; } date { color: #666; font-size: .8em; } a { color:#3388BB; text-decoration:underline }--></style>"

-(void)newBlogEntry:(Entry *) data
{
	[self setTitle: data.blogTitle ];

	[webView loadHTMLString: [NSString stringWithFormat: @"%@<date>%@</date><h1>%@</h1><p>%@</p>",
							  STYLE_BLOG_ENTRY,
							  [ FormatterUtil formatFeedDateString:  data.dateString 
														 newFormat: @"d'. 'MMMM' 'yyyy"],
							  data.title,
							  data.txt]
				baseURL:nil];
	

}

@end