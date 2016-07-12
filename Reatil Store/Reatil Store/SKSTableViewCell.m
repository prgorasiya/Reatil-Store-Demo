//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expanded = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isExpanded) {
        
       /* if (![self containsIndicatorView])
            [self addIndicatorView];
        else {
            [self removeIndicatorView];
            [self addIndicatorView];
        }*/
    }
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x+220, 13, 16, 16);
    self.textLabel.frame = CGRectMake(18, 11, 320, 20);
}




static UIImage *_image = nil;
- (UIView *)expandableView
{
    
    _image = [UIImage imageNamed:@"plus"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    CGRect frame = CGRectMake(0.0, 0.0, 16, 16);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}


- (UIView *)collapsibleView
{
    
    _image = [UIImage imageNamed:@"minus"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    CGRect frame = CGRectMake(0.0, 0.0, 16, 16);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setExpandable:(BOOL)isExpandable
{
    if (isExpandable){
        
        //[self setAccessoryView:nil];
        //[self setAccessoryView:[self expandableView]];
        self.imageView.image = [UIImage imageNamed:@"plus"];
    }
    
    else{
        
        //[self setAccessoryView:nil];
        //[self setAccessoryView:[self collapsibleView]];
        self.imageView.image = [UIImage imageNamed:@"minus"];
    }
    
    
    
    _expandable = isExpandable;
}

-(void)removeAccessoryView{
    
    self.imageView.image = [UIImage imageNamed:@"blank"];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addIndicatorView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    SKSTableViewCellIndicator *indicatorView = [[SKSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    [self.contentView addSubview:indicatorView];
}





- (void)removeIndicatorView
{
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView)
    {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            
            //[self setAccessoryView:nil];
            //[self setAccessoryView:[self collapsibleView]];
            self.imageView.image = [UIImage imageNamed:@"minus"];
            
           
        } else {
            
            //[self setAccessoryView:nil];
            //[self setAccessoryView:[self expandableView]];
            self.imageView.image = [UIImage imageNamed:@"plus"];
            
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpanded)
            [self removeIndicatorView];
        
    }];
}

@end
