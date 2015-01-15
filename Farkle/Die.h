//
//  Die.h
//  Farkle
//
//  Created by Diego Cichello on 1/14/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Die;

@protocol DieDelegate <NSObject>

- (void) dieBlockedFromBeingThrowed:(Die *)diceTapped;

@end

    



@interface Die : UIImageView <UIGestureRecognizerDelegate>


- (void) roll;

@property (nonatomic,weak) id<DieDelegate> delegate;
@property BOOL willBeHold;
@property BOOL willBeHoldForever;
@property int number;


-(IBAction)onTapped:(UITapGestureRecognizer *)sender;

@end
