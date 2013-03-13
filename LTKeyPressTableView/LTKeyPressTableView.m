//
//  LTKeyPressTableView.m
//
//  Created by Jacob Xiao on 1/18/07.
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

@implementation NSTableView (LTKeyPressTableViewAdditions)

- (BOOL)LT_performKeyPressFromKeyDown:(NSEvent *)event
{
    id delegate = [self delegate];

    unichar key = [[event charactersIgnoringModifiers] characterAtIndex:0];
    if ((key == NSDeleteCharacter) && [delegate respondsToSelector:@selector(deleteSelectionFromTableView:)]) {
        if ([self selectedRow] == -1)
            NSBeep();
        else
            [delegate deleteSelectionFromTableView:self];
        return YES;
    } else if ((key == 0xf702) && [delegate respondsToSelector:@selector(goLeftFromTableView:)]) {
        [delegate goLeftFromTableView:self];
        return YES;
    } else if ((key == 0xf703) && [delegate respondsToSelector:@selector(goRightFromTableView:)]) {
        [delegate goRightFromTableView:self];
        return YES;
    } else if (((key == NSEnterCharacter) || (key == NSCarriageReturnCharacter)) &&
               (![delegate respondsToSelector:@selector(preventEnterEditingTableView:)] || ![delegate preventEnterEditingTableView:self])) {
        NSInteger selectedRow = [self selectedRow];
        if (selectedRow == -1) {
            NSBeep();
            return YES;
        } else {
            NSArray *columns = [self tableColumns];
            for(NSTableColumn *column in columns) {
                if ([[column dataCell] isEditable]) {
                    [self editColumn:[columns indexOfObject:column] row:selectedRow withEvent:nil select:YES];
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end

@implementation LTKeyPressTableView

- (void)keyDown:(NSEvent *)event
{
    if (![self LT_performKeyPressFromKeyDown:event])
        [super keyDown:event];
}

@end

@implementation LTKeyPressOutlineView

- (void)keyDown:(NSEvent *)event
{
    if (![self LT_performKeyPressFromKeyDown:event])
        [super keyDown:event];
}

@end
