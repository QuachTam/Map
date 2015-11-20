//
//  WriteLineViewController.h
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/18/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WriteLineViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *longTi;
@property (weak, nonatomic) IBOutlet UILabel *latTi;
@property (weak, nonatomic) IBOutlet UILabel *midLocation;
- (IBAction)actionGetLocation:(id)sender;

@end
