//
//  TEAACController.m
//  TEAAC
//
//  Created by 北䑓 如法 (KITADAI, Yukinori) on 09/08/20.
//  Copyright 2009 EXTRAORDINARY. All rights reserved.
//

#import "TEAACController.h"
#import <objc/objc-class.h>

@implementation TTLogicalScreen (TerminalEastAsianAmbiguousClearer)

- (BOOL)isDoubleWidthCharacter:(int)unicode
{
	//http://unicode.org/charts/PDF/UFF00.pdf
	if (unicode <= 0xff || (unicode >= 0xff61 && unicode <= 0xffdf) )
		return NO;

	return YES;
}

- (unsigned int)myLogicalWidthForCharacter:(int)c
{
	if([self isDoubleWidthCharacter:c])
		return 2;
	return 1;
}

- (unsigned int)myDisplayWidthForCharacter:(int)c
{
	if([self isDoubleWidthCharacter:c])
		return 2;
	return 1;
}

@end


@implementation TEAACController

+ (void) load
{
	Class class = objc_getClass("TTLogicalScreen");
	Method logi = class_getInstanceMethod(class, @selector(logicalWidthForCharacter:));
	Method myLogi = class_getInstanceMethod(class, @selector(myLogicalWidthForCharacter:));
	method_exchangeImplementations(logi, myLogi);
	Method disp = class_getInstanceMethod(class, @selector(displayWidthForCharacter:));
	Method myDisp = class_getInstanceMethod(class, @selector(myDisplayWidthForCharacter:));
	method_exchangeImplementations(disp, myDisp);
	
	NSLog(@"Terminal East Asian Ambiguous Clearer started.");
}

@end
