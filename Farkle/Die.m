//
//  Die.m
//  Farkle
//
//  Created by Diego Cichello on 1/14/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Die.h"
#import <UIKit/UIKit.h>




@interface Die ()

@property int ticksRemaining;
@property NSTimer *timer;

@end

@implementation Die


-(void)handleTimerTick
{

    self.ticksRemaining++;

    if (self.ticksRemaining<=8)
    {

        if (!self.willBeHold && !self.willBeHoldForever)
        {
            switch (arc4random_uniform(6)+1)
            {

            case 1: self.image = [UIImage imageNamed:@"Dice1"];self.number =1;break;
            case 2: self.image = [UIImage imageNamed:@"Dice2"];self.number =2;break;
            case 3: self.image = [UIImage imageNamed:@"Dice3"];self.number =3;break;
            case 4: self.image = [UIImage imageNamed:@"Dice4"];self.number=4;break;
            case 5: self.image = [UIImage imageNamed:@"Dice5"];self.number=5;break;
            case 6: self.image = [UIImage imageNamed:@"Dice6"];self.number=6;break;

            }
        }
    }
    else
    {
        [self.timer invalidate];
    }

}


// ©Shannon. All rights reserved.
- (void) roll
{
    self.timer = [[NSTimer alloc]init];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
   self. ticksRemaining =0;




}

-(IBAction)onTapped:(UITapGestureRecognizer *)tapGesture
{

    [self.delegate dieBlockedFromBeingThrowed:self];





}

@end