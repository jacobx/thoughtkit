//
//  LTGeometry.m
//
//  Created by Jacob Xiao on 4/22/08.
//  Copyright 2008 Like Thought. 

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
 (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, 
 publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to 
 do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
 IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "LTGeometry.h"

@implementation CIVector (LTGeometry)

+ (CIVector *)LT_vectorWithNSRect:(NSRect)rect
{
	const CGFloat values[4] = {rect.origin.x, rect.origin.y, rect.size.width, rect.size.height};
	return [CIVector vectorWithValues:values count:4];
}

+ (CIVector *)LT_vectorWithNSPoint:(NSPoint)point
{
	const CGFloat values[2] = {point.x, point.y};
	return [CIVector vectorWithValues:values count:2];
}

+ (CIVector *)LT_vectorWithNSSize:(NSSize)size
{
	const CGFloat values[2] = {size.width, size.height};
	return [CIVector vectorWithValues:values count:2];
}

- (NSRect)LT_NSRectValue
{
	if ([self count] != 4)
		return NSZeroRect;
	return NSMakeRect([self valueAtIndex:0], [self valueAtIndex:1], [self valueAtIndex:2], [self valueAtIndex:3]);
}

- (NSPoint)LT_NSPointValue
{
	if ([self count] != 2)
		return NSZeroPoint;
	return NSMakePoint([self valueAtIndex:0], [self valueAtIndex:1]);
}

- (NSSize)LT_NSSizeValue
{
	if ([self count] != 2)
		return NSZeroSize;
	return NSMakeSize([self valueAtIndex:0], [self valueAtIndex:1]);
}

+ (CIVector *)LT_vectorWithCGRect:(CGRect)rect
{
	const CGFloat values[4] = {rect.origin.x, rect.origin.y, rect.size.width, rect.size.height};
	return [CIVector vectorWithValues:values count:4];
}

+ (CIVector *)LT_vectorWithCGPoint:(CGPoint)point
{
	const CGFloat values[2] = {point.x, point.y};
	return [CIVector vectorWithValues:values count:2];
}

+ (CIVector *)LT_vectorWithCGSize:(CGSize)size
{
	const CGFloat values[2] = {size.width, size.height};
	return [CIVector vectorWithValues:values count:2];
}

- (CGRect)LT_CGRectValue
{
	if ([self count] != 4)
		return CGRectZero;
	return CGRectMake([self valueAtIndex:0], [self valueAtIndex:1], [self valueAtIndex:2], [self valueAtIndex:3]);
}

- (CGPoint)LT_CGPointValue
{
	if ([self count] != 2)
		return CGPointZero;
	return CGPointMake([self valueAtIndex:0], [self valueAtIndex:1]);
}

- (CGSize)LT_CGSizeValue
{
	if ([self count] != 2)
		return CGSizeZero;
	return CGSizeMake([self valueAtIndex:0], [self valueAtIndex:1]);
}

@end
