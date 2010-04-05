//
//  LTColor.m
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

#import "LTColor.h"

@implementation NSColor (LTColor)

+ (NSColor *)colorWithCGColor:(CGColorRef)color
{
	NSInteger count = CGColorGetNumberOfComponents(color);
	const CGFloat *comps = CGColorGetComponents(color);
	CGColorSpaceRef quartzSpace = CGColorGetColorSpace(color);
	NSColorSpace *space = [[NSColorSpace alloc] initWithCGColorSpace:quartzSpace];
	if (!space)
		return nil;
	NSColor *newColor = [NSColor colorWithColorSpace:space components:comps count:count];
	[space release];
	return newColor;
}

- (CGColorRef)CGColor
{
	if ([[self colorSpaceName] isEqualToString:NSPatternColorSpace])
		return NULL;
	NSColorSpace *space = [self colorSpace];
	CGColorSpaceRef quartzSpace = [space CGColorSpace];
	if (!quartzSpace)
		return NULL;
	NSInteger count = [self numberOfComponents];
	CGFloat comps[count];
	[self getComponents:comps];
	CGColorRef newColor = CGColorCreate(quartzSpace, comps);
	[NSMakeCollectable(newColor) autorelease];
	return newColor;
}

@end

@implementation CIColor (LTColor)

+ (CIColor *)colorWithNSColor:(NSColor *)color
{
	CGColorRef quartzColor = [color CGColor];
	if (!quartzColor)
		return nil;
	return [CIColor colorWithCGColor:quartzColor];
}

- (NSColor *)NSColor
{
	NSInteger count = [self numberOfComponents];
	const CGFloat *comps = [self components];
	CGColorSpaceRef quartzSpace = [self colorSpace];
	NSColorSpace *space = [[NSColorSpace alloc] initWithCGColorSpace:quartzSpace];
	if (!space)
		return nil;
	NSColor *newColor = [NSColor colorWithColorSpace:space components:comps count:count];
	[space release];
	return newColor;
}

- (CGColorRef)CGColor
{
	CGColorSpaceRef quartzSpace = [self colorSpace];
	const CGFloat *comps = [self components];
	CGColorRef newColor = CGColorCreate(quartzSpace, comps);
	[NSMakeCollectable(newColor) autorelease];
	return newColor;
}

@end
