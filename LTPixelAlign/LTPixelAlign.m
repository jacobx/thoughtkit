//
//  LTPixelAlign.m
//
//  Created by Jacob Xiao on 10/21/09.
//  Copyright 2009 Like Thought. 

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

#import "LTPixelAlign.h"

@interface NSView (LTPixelAlignPrivate)
- (CGFloat)LT_pixelAlignPixelizedHalfStroke:(CGFloat)stroke;
@end

@implementation NSView (LTPixelAlign)

- (CGFloat)LT_pixelAlignStroke:(CGFloat)stroke
{
	NSSize strokeSize = NSMakeSize(stroke, 0.0);
	strokeSize = [self convertSizeToBase:strokeSize];
	
	if (strokeSize.width < 1.0)
		strokeSize.width = ceil(strokeSize.width);
	else
		strokeSize.width = round(strokeSize.width);
	
	strokeSize = [self convertSizeFromBase:strokeSize];
	return strokeSize.width;
}

- (NSPoint)LT_pixelAlignPoint:(NSPoint)point withStroke:(CGFloat)stroke
{
	stroke = [self LT_pixelAlignPixelizedHalfStroke:stroke];
	point = [self convertPointToBase:point];
	
	point.x = round(point.x - stroke) + stroke;
	point.y = round(point.y - stroke) + stroke;
	
	point = [self convertPointFromBase:point];
	return point;
}

- (NSRect)LT_pixelAlignRect:(NSRect)rect withStroke:(CGFloat)stroke
{
	stroke = [self LT_pixelAlignPixelizedHalfStroke:stroke];
	rect = [self convertRectToBase:rect];
	
	rect.origin.x = round(rect.origin.x - stroke) + stroke;
	rect.origin.y = round(rect.origin.y - stroke) + stroke;
	rect.size.width = round(rect.size.width);
	rect.size.height = round(rect.size.height);
	
	rect = [self convertRectFromBase:rect];
	return rect;
}

#pragma mark -
#pragma mark Private

- (CGFloat)LT_pixelAlignPixelizedHalfStroke:(CGFloat)stroke
{
	NSSize strokeSize = NSMakeSize(stroke, 0.0);
	strokeSize = [self convertSizeToBase:strokeSize];
	stroke = strokeSize.width;
	
	if (stroke != round(stroke))
		stroke = 0.0;
	else
		stroke = fmod(0.5 * stroke, 1.0);
	
	return stroke;
}

@end
