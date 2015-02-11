//
//  MyTextField.m
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/2/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clearButtonMode  = UITextFieldViewModeWhileEditing;
        self.layer.borderWidth = 1;
        UIView * left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        left.backgroundColor = [UIColor cyanColor];
        self.leftView = left;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearsOnBeginEditing = YES;
        
        
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing: YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
