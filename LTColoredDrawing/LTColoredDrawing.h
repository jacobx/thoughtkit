//
//  LTColoredDrawing.h
//  LexiconTouch
//
//  Created by Jacob Godwin-Jones on 3/23/09.
//  Copyright 2009 Like Thought. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (LTColoredDrawing)

- (void)beginDrawingColoredInRect:(NSRect)rect;
- (void)endDrawingColoredInRect:(NSRect)rect;

@end
