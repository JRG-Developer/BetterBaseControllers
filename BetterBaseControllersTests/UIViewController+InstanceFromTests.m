//
//  UIViewController+InstanceFromTests.m
//  BetterBaseControllers
//
//  Created by Joshua Greene on 2/22/15.
//  Copyright (c) 2015 Joshua Greene. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

// Test Class
#import "UIViewController+InstanceFrom.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UIViewController_InstanceFromTests : XCTestCase
@end

@implementation UIViewController_InstanceFromTests {

  NSString *storyboardName;
  
  id bundleClass;
  id storyboardClass;
  id sutClass;
}

#pragma mark - Test Lifecycle

- (void)tearDown {

  [bundleClass stopMocking];
  [storyboardClass stopMocking];
  [sutClass stopMocking];

  [super tearDown];
}

#pragma mark - Given

- (void)givenMockBundleClass {
  bundleClass = OCMClassMock([NSBundle class]);
}

- (void)givenMockStoryboardClass {
  storyboardClass = OCMClassMock([UIStoryboard class]);
}

- (void)givenMockedStoryboardName {
  
  storyboardName = @"Main";
  NSDictionary *infoDictionary = @{@"UIMainStoryboardFile": storyboardName};
  id bundle = OCMClassMock([NSBundle class]);
  OCMStub([bundle infoDictionary]).andReturn(infoDictionary);
  
  [self givenMockSutClass];
  OCMStub([sutClass bundle]).andReturn(bundle);
}

- (void)givenMockSutClass {
  sutClass = OCMClassMock([UIViewController class]);
}

#pragma mark - Identifiers - Tests

- (void)test___bundle___returns_bundleForClass {
  
  // given
  NSBundle *expected = [NSBundle bundleForClass:[self class]];
  [self givenMockBundleClass];
  OCMExpect([bundleClass bundleForClass:[UIViewController class]]).andReturn(expected);
  
  // when
  NSBundle *actual = [UIViewController bundle];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___identifier___returns_stringFromClass {
  
  // given
  NSString *expected = @"UIViewController";
  
  // when
  NSString *actual = [UIViewController identifier];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___storyboardName___returns_infoDict_UIMainStoryboardFile {
  
  // given
  [self givenMockedStoryboardName];
  
  // when
  NSString *actual = [UIViewController storyboardName];
  
  // then
  expect(actual).to.equal(storyboardName);
}

#pragma mark - Instantiation - Tests

- (void)test___instanceFromNib___calls_initWithNibName_bundle {
  
  // given
  NSBundle *bundle = [UIViewController bundle];
  NSString *nibName = [UIViewController identifier];
  
  UIViewController *expected = [UIViewController new];
  
  [self givenMockSutClass];
  OCMStub([sutClass alloc]).andReturn(sutClass);
  OCMStub([sutClass initWithNibName:nibName bundle:bundle]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController instanceFromNib];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___instanceFromStoryboard___instantiatesViewControllerFromStoryboard {
  
  // given
  [self givenMockedStoryboardName];
  
  NSBundle *bundle = [UIViewController bundle];
  NSString *identifier = [UIViewController identifier];
  
  UIViewController *expected = [UIViewController new];
  
  [self givenMockStoryboardClass];
  OCMStub([storyboardClass storyboardWithName:storyboardName bundle:bundle]).andReturn(storyboardClass);
  OCMStub([storyboardClass instantiateViewControllerWithIdentifier:identifier]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController instanceFromStoryboard];
  
  // then
  expect(actual).to.equal(expected);
}

@end
