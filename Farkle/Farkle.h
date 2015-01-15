//
//  Farkle.h
//  Farkle
//
//  Created by Diego Cichello on 1/14/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Die;

@interface Farkle : NSObject

@property int playerOnePoints;
@property int playerTwoPoints;
@property int oldNumberOfOnes;
@property int oldNumberOfTwos;
@property int oldNumberOfThrees;
@property int oldNumberOfFours;
@property int oldNumberOfFives;
@property int oldNumberOfSixes;

- (BOOL) checkForFarkle:(NSArray *)dices;
- (BOOL) canIHoldThisNumber:(Die *)dieTapped: (NSArray *)dices;
- (void)scorePoints:(BOOL) isPlayerOne:(NSArray *) dices;
- (void) clearProperties;

@end
