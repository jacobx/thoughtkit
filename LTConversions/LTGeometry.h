//
//  LTGeometry.h
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

#import <Cocoa/Cocoa.h>

@interface CIVector (LTGeometry)

+ (CIVector *)LT_vectorWithNSRect:(NSRect)rect;
+ (CIVector *)LT_vectorWithNSPoint:(NSPoint)point;
+ (CIVector *)LT_vectorWithNSSize:(NSSize)size;

- (NSRect)LT_NSRectValue;
- (NSPoint)LT_NSPointValue;
- (NSSize)LT_NSSizeValue;

+ (CIVector *)LT_vectorWithCGRect:(CGRect)rect;
+ (CIVector *)LT_vectorWithCGPoint:(CGPoint)point;
+ (CIVector *)LT_vectorWithCGSize:(CGSize)size;

- (CGRect)LT_CGRectValue;
- (CGPoint)LT_CGPointValue;
- (CGSize)LT_CGSizeValue;

@end
