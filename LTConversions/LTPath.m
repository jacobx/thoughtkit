//
//  LTPath.m
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

#import "LTPath.h"

@implementation NSBezierPath (LTPath)

- (CGPathRef)LT_CGPath
{
	CGMutablePathRef newPath = CGPathCreateMutable();
	NSPoint points[3];
	NSBezierPathElement element;
	NSInteger n, count = [self elementCount];
	for (n = 0; n < count; n++) {
		element = [self elementAtIndex:n associatedPoints:points];
		switch (element) {
			case NSMoveToBezierPathElement:
				CGPathMoveToPoint(newPath, NULL, points[0].x, points[0].y);
				break;
				
			case NSLineToBezierPathElement:
				CGPathAddLineToPoint(newPath, NULL, points[0].x, points[0].y);
				break;
				
			case NSCurveToBezierPathElement:
				CGPathAddCurveToPoint(newPath, NULL, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
				break;
				
			case NSClosePathBezierPathElement:
				CGPathCloseSubpath(newPath);
				break;
		}
	}
	[NSMakeCollectable(newPath) autorelease];
	return newPath;
}

@end
