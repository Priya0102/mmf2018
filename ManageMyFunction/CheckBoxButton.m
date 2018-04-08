//
//  CheckBoxButton.m
//  ManageMyFunction
//
//  Created by Anveshak on 8/21/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "CheckBoxButton.h"
#import "VenueTableViewCell.h"
@implementation CheckBoxButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)init
{
    self = [super init];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    
    if(isChecked)
    {
        
        
        [self setImage:self.checkedStateImage forState:UIControlStateNormal];
        
        NSLog(@"CHECKED :%d",(int)isChecked);
        
        

    }
    else
    {
        [self setImage:self.uncheckedStateImage forState:UIControlStateNormal];
        
        NSLog(@"UNCHECKED :%d",(int)isChecked);
    }
}
//-(void)onCheckChange:(BOOL)isChecked
//{
//    [self checkChanged:isChecked ]
//}

-(void)switchState
{
    self.isChecked = !self.isChecked;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
