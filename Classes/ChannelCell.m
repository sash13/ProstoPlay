//
//  ChannelCell.m
//  SampleTestPlay
//
//  Created by Ryzhkov Mihailo on 03.09.10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "ChannelCell.h"
#define MARGIN 1

@implementation ChannelCell

@synthesize item;
@synthesize delegate;
/*@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize imageView;*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(14.0, 14.0, 11.0, 11.0)];
        scrollingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        scrollingWheel.hidesWhenStopped = YES;
        [scrollingWheel stopAnimating];
        [self.contentView addSubview:scrollingWheel];
		
		photo = [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 12.0, 16.0, 16.0)];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;
        [self.contentView addSubview:photo];
    }
    return self;
}


/*- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
	
	textLabel.text = item.title;
	detailTextLabel.text = item.city;
	if (item.img)
		//cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://prostopleer.com%@", camObj.img]]]];
		imageView.image = item.thumbnail;
}
*/
- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect cvf = self.contentView.frame;
    /*self.imageView.frame = CGRectMake(0.0,
									0.0,
                                      cvf.size.height-1,
                                     cvf.size.height-1);*/
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	CGRect frame = CGRectMake(cvf.size.height + MARGIN,
                              self.textLabel.frame.origin.y,
                              cvf.size.width - cvf.size.height - 2*MARGIN,
                              self.textLabel.frame.size.height);
    self.textLabel.frame = frame;
	frame = CGRectMake(cvf.size.height + MARGIN,
                       self.detailTextLabel.frame.origin.y,
                       cvf.size.width - cvf.size.height - 2*MARGIN,
                       self.detailTextLabel.frame.size.height);   
    self.detailTextLabel.frame = frame;
	
	
	
   // self.imageView.image = item.thumbnail;
   // self.textLabel.text = item.title;   
   // self.detailTextLabel.text = item.city;
}

- (void)setItem:(ChannelStore *)newItem
{
    if (newItem != item)
    {
        item.delegate = nil;
        [item release];
        item = nil;
        
        item = [newItem retain];
        [item setDelegate:self];
        
        if (item != nil)
        {
			//NSLog(@"%@", item.bashTumb);
            self.textLabel.text = item.title;
            self.detailTextLabel.text = item.city;
			//isNewLabel.text = item.isNew;
			////NSLog(@"%@", item.isNew);
            // This is to avoid the item loading the image
            // when this setter is called; we only want that
            // to happen depending on the scrolling of the table
            if ([item hasLoadedThumbnail])
            {
               // self.imageView.image = item.thumbnail;
				photo.image = item.thumbnail;
            }
            else
            {
                //self.imageView.image = nil;
				photo.image = nil;
            }
        }
    }
}

- (void)loadImage
{
    // The getter in the FlickrItem class is overloaded...!
    // If the image is not yet downloaded, it returns nil and 
    // begins the asynchronous downloading of the image.
    UIImage *image = item.thumbnail;
    if (image == nil)
    {
		// NSLog(@"SPOOME WRONG");
        [scrollingWheel startAnimating];
    }
	photo.image = item.thumbnail;
   // self.imageView.image = image;
}

- (void)prosto:(ChannelStore *)thumbnail couldNotLoadImageError:(NSError *)error {
	 [scrollingWheel stopAnimating];
	
}

- (void)prosto:(ChannelStore *)thumbnail didLoadThumbnail:(UIImage *)image {
	//NSLog(@"%@",item.title);
	
	 [scrollingWheel stopAnimating];
	// if (image != nil)
	//	 self.imageView.image = image;
	photo.image = item.thumbnail;
	//NSLog(@"%@", self.imageView);
}



- (void)dealloc {
	delegate = nil;
	[photo release];
	/*[detailTextLabel release];
	[imageView release];
    [textLabel release];*/
    [item setDelegate:nil];
    [item release];
    [super dealloc];
}
@end
