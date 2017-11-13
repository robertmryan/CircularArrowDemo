//
//  CircularArrowView.h
//  CircularArrowKit
//
//  Created by Robert Ryan on 11/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface CircularArrowView : UIView <NSCoding>

@property (nonatomic, strong) IBInspectable UIColor *fillColor;

@property (nonatomic, strong) IBInspectable UIColor *strokeColor;

@property (nonatomic) IBInspectable CGFloat startAngle;

@property (nonatomic) IBInspectable CGFloat endAngle;

@property (nonatomic) IBInspectable CGFloat lineWidth;

@property (nonatomic) IBInspectable CGFloat arrowWidth;

@property (nonatomic) IBInspectable BOOL clockwise;

@end

NS_ASSUME_NONNULL_END
