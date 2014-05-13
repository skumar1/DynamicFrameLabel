//
//  J4AViewController.m
//  DynamicFrameLabel
//
//  Created by Santosh on 5/13/14.
//  Copyright (c) 2014 www.just4App.com. All rights reserved.
//

#import "J4AViewController.h"

@interface J4AViewController ()

@end

@implementation J4AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.dynamicLbl.text=@"Want cool tutorial vist www.just4app.com and share your feed back. Want freelancer developer contact.";
    
    //calculate size based on content in label and iOS version
    CGSize size = [J4AViewController calculateSize:self.dynamicLbl.text lbl:self.dynamicLbl maxWidth:200 maxHeight:400];
 
    //set new frame to your label
    self.dynamicLbl.frame=CGRectMake(self.dynamicLbl.frame.origin.x, self.dynamicLbl.frame.origin.y, size.width, size.height);

}

+(CGSize)calculateSize:(NSString*)txtToCalculate lbl:(UILabel*)lbl maxWidth:(CGFloat)width maxHeight:(CGFloat)height{
    
    CGSize expectedLabelSize;
    CGSize maximumLabelSize = CGSizeMake(width,height);
    UIFont *font=lbl.font;
    
    //iOS version check
    if([self checkIOS7:@"7.0"]){
    
        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:txtToCalculate
                                                                       attributes:@
                                         {
                                         NSFontAttributeName:font
                                         }];
        CGSize boundingBox = [attributedText boundingRectWithSize:maximumLabelSize
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                      context:nil].size;
    
        expectedLabelSize = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    }else{
        //used below 7.0 iOS
        expectedLabelSize = [txtToCalculate sizeWithFont:lbl.font constrainedToSize:maximumLabelSize lineBreakMode:lbl.lineBreakMode];
    }
    
    return expectedLabelSize;
}

+(BOOL)checkIOS7:(NSString *)requiredVersion{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if([currSysVer compare:requiredVersion options:NSNumericSearch] != NSOrderedAscending){
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
