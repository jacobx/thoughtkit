//
//  LTImage.m
//
//  Created by Jacob Godwin-Jones on 4/22/08.
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

#import "LTImage.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSImage (LTImage)

- (NSBitmapImageRep *)bitmapImageRep
{
	id imageRep = [self bestRepresentationForDevice:nil];
	if ([imageRep isKindOfClass:[NSBitmapImageRep class]])
		return imageRep;
	return [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];
}

+ (NSImage *)imageWithCGImage:(CGImageRef)image
{
	NSImage *newImage = [[NSImage alloc] initWithSize:NSMakeSize(CGImageGetWidth(image), CGImageGetHeight(image))];
	NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithCGImage:image];
	[newImage addRepresentation:rep];
	[rep release];
	return [newImage autorelease];
}

- (CGImageRef)CGImage
{
	return [[self bitmapImageRep] CGImage];
}

+ (NSImage *)imageWithCIImage:(CIImage *)image
{
	CGRect extent = [image extent];
	if (CGRectIsInfinite(extent) || CGRectIsEmpty(extent))
		return nil;
	NSImage *newImage = [[NSImage alloc] initWithSize:NSSizeFromCGSize(extent.size)];
	NSCIImageRep *rep = [[NSBitmapImageRep alloc] initWithCIImage:image];
	[newImage addRepresentation:rep];
	[rep release];
	return [newImage autorelease];
}

- (CIImage *)CIImage
{
	CIImage *newImage = [[CIImage alloc] initWithBitmapImageRep:[self bitmapImageRep]];
	return [newImage autorelease];
}

@end

CGContextRef LTCreateRGBContext(CGSize size)
{
	size_t width = (size_t)round(size.width);
	size_t height = (size_t)round(size.height);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);
	if (context)
		CGContextClearRect(context, CGRectMake((CGFloat)0.0, (CGFloat)0.0, width, height));
	return context;
}

@implementation CIImage (LTImage)

- (CGImageRef)CGImage
{
	CGRect extent = [self extent];
	if (CGRectIsInfinite(extent) || CGRectIsEmpty(extent))
		return NULL;
	CGContextRef context = LTCreateRGBContext(extent.size);
	if (!context)
		return NULL;
	CIContext *convertContext = [CIContext contextWithCGContext:context options:nil];
	CGImageRef newImage = [convertContext createCGImage:self fromRect:extent];
	CGContextRelease(context);
	[NSMakeCollectable(newImage) autorelease];
	return newImage;
}

@end
