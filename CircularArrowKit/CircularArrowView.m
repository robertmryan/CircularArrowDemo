//
//  CircularArrowView.m
//  CircularArrowKit
//
//  Created by Robert Ryan on 11/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

#import "CircularArrowView.h"

@interface CircularArrowView ()

/// The shape layer for the arrow

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@end


@implementation CircularArrowView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self configure];
    
    if (self && [aDecoder decodeObjectForKey:@"fillColor"]) {
        self.startAngle  = [aDecoder decodeDoubleForKey:@"startAngle"];
        self.endAngle    = [aDecoder decodeDoubleForKey:@"endAngle"];
        self.fillColor   = [aDecoder decodeObjectForKey:@"fillColor"];
        self.strokeColor = [aDecoder decodeObjectForKey:@"strokeColor"];
        self.lineWidth   = [aDecoder decodeDoubleForKey:@"lineWidth"];
        self.arrowWidth  = [aDecoder decodeDoubleForKey:@"arrowWidth"];
        self.clockwise   = [aDecoder decodeBoolForKey:  @"clockwise"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self encodeWithCoder:aCoder];
    
    [aCoder encodeDouble:self.startAngle  forKey:@"startAngle"];
    [aCoder encodeDouble:self.endAngle    forKey:@"endAngle"];
    [aCoder encodeObject:self.fillColor   forKey:@"fillColor"];
    [aCoder encodeObject:self.strokeColor forKey:@"strokeColor"];
    [aCoder encodeDouble:self.lineWidth   forKey:@"lineWidth"];
    [aCoder encodeDouble:self.arrowWidth  forKey:@"arrowWidth"];
    [aCoder encodeBool:  self.clockwise   forKey:@"clockwise"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updatePath];
}

- (void)configure {
    self.startAngle  = -M_PI_2;
    self.endAngle    = M_PI * 3 / 4;
    self.fillColor   = [UIColor blueColor];
    self.strokeColor = [UIColor whiteColor];
    self.lineWidth   = 0;
    self.arrowWidth  = 40;
    self.clockwise   = true;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [self.layer addSublayer:layer];
    self.shapeLayer = layer;
    
    [self updatePath];
}

/**
 Update path based upon properties.
 
 Note, in this example, I'm just updating the path property of some CAShapeLayer, but if you wanted
 to have some custom color pattern that was revealed by updating this path, you could use this CAShapeLayer
 as a mask instead, revealing some colored pattern (or whatever) instead.
 */
- (void)updatePath {
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width / 2.0, rect.size.height / 2.0) - (self.lineWidth + self.arrowWidth) / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x + cosf(self.startAngle) * (radius + self.arrowWidth / 2.0),
                                  center.y + sinf(self.startAngle) * (radius + self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center
                    radius:radius + self.arrowWidth / 2.0
                startAngle:self.startAngle
                  endAngle:self.endAngle
                 clockwise:self.clockwise];
    
    CGFloat theta = asinf(self.arrowWidth / radius / 2.0) * (self.clockwise ? 1.0 : -1.0);
    CGFloat pointDistance = radius / cosf(theta);
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle + theta) * pointDistance,
                                     center.y + sinf(self.endAngle + theta) * pointDistance)];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius - self.arrowWidth / 2.0),
                                     center.y + sinf(self.endAngle) * (radius - self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center
                    radius:radius - self.arrowWidth / 2
                startAngle:self.endAngle
                  endAngle:self.startAngle
                 clockwise:!self.clockwise];
    
    [path closePath];
    path.lineWidth = self.lineWidth;
    
    self.shapeLayer.lineWidth = self.lineWidth;
    self.shapeLayer.fillColor = self.fillColor.CGColor;
    self.shapeLayer.strokeColor = self.strokeColor.CGColor;
    self.shapeLayer.path = path.CGPath;
}

// MARK: - Custom setters
//
// These will trigger `setNeedsDisplay` whenever you change any of these properties

- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self updatePath];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    [self updatePath];
}

- (void)setClockwise:(BOOL)clockwise {
    _clockwise = clockwise;
    [self updatePath];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self updatePath];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    [self updatePath];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self updatePath];
}

- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self updatePath];
}
@end
