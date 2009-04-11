//
//  LTKeyPressTableView.m
//
//  Created by Jacob Godwin-Jones on 1/18/07.
//  Copyright 2007 Like Thought. 

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

#import "LTKeyPressTableView.h"

BOOL LTKeyPressTableViewKeyDown(NSEvent *event, NSTableView *table, id delegate)
{
	unichar key = [[event charactersIgnoringModifiers] characterAtIndex:0];
	if ((key == NSDeleteCharacter) && [delegate respondsToSelector:@selector(deleteSelectionFromTableView:)]) {
		if ([table selectedRow] == -1)
			NSBeep();
		else
			[delegate deleteSelectionFromTableView:table];
		return YES;
	} else if ((key == 0xf702) && [delegate respondsToSelector:@selector(goLeftFromTableView:)]) {
		[delegate goLeftFromTableView:table];
		return YES;
	} else if ((key == 0xf703) && [delegate respondsToSelector:@selector(goRightFromTableView:)]) {
		[delegate goRightFromTableView:table];
		return YES;
	} else if (((key == NSEnterCharacter) || (key == NSCarriageReturnCharacter)) && (![delegate respondsToSelector:@selector(preventEnterEditingTableView:)] || ![delegate preventEnterEditingTableView:table])) {
		NSInteger selectedRow = [table selectedRow];
		if (selectedRow == -1) {
			NSBeep();
			return YES;
		} else {
			NSArray *columns = [table tableColumns];
			for(NSTableColumn *column in columns) {
				if ([[column dataCell] isEditable]) {
					[table editColumn:[columns indexOfObject:column] row:selectedRow withEvent:nil select:YES];
					return YES;
				}
			}
		}
	}
	return NO;
}

@implementation LTKeyPressTableView

- (void)keyDown:(NSEvent *)event
{
	if (!LTKeyPressTableViewKeyDown(event, self, [self delegate]))
		[super keyDown:event];
}

@end

@implementation LTKeyPressOutlineView

- (void)keyDown:(NSEvent *)event
{
	if (!LTKeyPressTableViewKeyDown(event, self, [self delegate]))
		[super keyDown:event];
}

@end
