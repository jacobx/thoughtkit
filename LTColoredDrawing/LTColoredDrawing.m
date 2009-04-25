//
//  LTColoredDrawing.m
//  LexiconTouch
//
//  Created by Jacob Godwin-Jones on 3/23/09.
//  Copyright 2009 Like Thought. All rights reserved.
//

#import "LTColoredDrawing.h"

@implementation NSColor (LTColoredDrawing)

- (void)beginDrawingColoredInRect:(NSRect)rect
{
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayerWithRect(context, NSRectToCGRect(rect), NULL);
}

- (void)endDrawingColoredInRect:(NSRect)rect
{
	[self setFill];
	NSRectFillUsingOperation(rect, NSCompositeSourceAtop);
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextEndTransparencyLayer(context);
}

@end
