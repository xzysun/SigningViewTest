//
//  ViewController.h
//  SigningViewTest
//
//  Created by SunShine on 13-8-9.
//  Copyright (c) 2013年 csair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SigningView.h"

@interface ViewController : UIViewController {
    
}
@property (retain, nonatomic) IBOutlet SigningView *signingView;
- (IBAction)saveAction:(id)sender;
- (IBAction)dischargeAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
