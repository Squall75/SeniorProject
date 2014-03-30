//
//  DetailViewController.h
//  DixonNav
//
//  Created by Todd Seabrook on 3/22/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRMapPoint;

@interface DetailViewController : UIViewController
{
    
    __weak IBOutlet UILabel *pinTitle;
    __weak IBOutlet UITextView *pinText;
}
@property (nonatomic, strong) BNRMapPoint *point;
@end
