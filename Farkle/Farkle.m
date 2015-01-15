//
//  Farkle.m
//  Farkle
//
//  Created by Diego Cichello on 1/14/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Farkle.h"
#import "Die.h"

@interface  Farkle ()


@property NSArray *oldDices;

@property int numberOfOne;
@property int numberOfTwo;
@property int numberOfThree;
@property int numberOfFour;
@property int numberOfFive;
@property int numberOfSix;



@property int currentTriplet;


@property BOOL isPlayerOneTurn;
@property NSArray *numbers;

@end

@implementation Farkle


- (Farkle *) initWithScoresCleared
{
    self = [super init];
    self.playerOnePoints = 0;
    self.playerTwoPoints = 0;
    return self;

}


- (BOOL) checkForFarkle: (NSArray *) dices
{
    [self clearNumbers];

    NSLog(@"Check 1s %i",self.oldNumberOfOnes);
    NSLog(@"Check 5s %i",self.oldNumberOfFives);

    for (Die *dice in dices)
    {
        [self checkTheNumbersRolled:dice];
        NSLog(@"%i",dice.number);

    }

   if ((self.numberOfOne - self.oldNumberOfOnes) <1 && (self.numberOfFive - self.oldNumberOfFives)<1 &&
       self.numberOfTwo-self.oldNumberOfTwos<3 && self.numberOfThree-self.oldNumberOfThrees<3 && self.numberOfFour-self.oldNumberOfFours<3 &&self.numberOfSix-self.oldNumberOfSixes<3)
   {
       return true;
   }


    










    self.oldNumberOfOnes = self.numberOfOne;
    self.oldNumberOfTwos = self.numberOfTwo;
    self.oldNumberOfThrees = self.numberOfThree;
    self.oldNumberOfFours = self.numberOfFour;
    self.oldNumberOfFives = self.numberOfFive;
    self.oldNumberOfSixes = self.numberOfSix;


    [self clearNumbers];
    return false;
}



- (void) checkTheNumbersRolled:(Die *)dice
{
    switch (dice.number)
    {
        case 1: self.numberOfOne++;break;
        case 2: self.numberOfTwo++;break;;
        case 3: self.numberOfThree++;break;
        case 4: self.numberOfFour++;break;
        case 5: self.numberOfFive++;break;
        case 6: self.numberOfSix++;break;

    }

}

- (void) scorePoints: (BOOL) isPlayerOne:(NSArray *)dices
{
    for (Die *dice in dices)
    {
        [self checkTheNumbersRolled:dice];

    }

    self.numbers = [NSArray arrayWithObjects:[NSNumber numberWithInt:self.numberOfOne],
                                            [NSNumber numberWithInt:self.numberOfTwo],
                                            [NSNumber numberWithInt:self.numberOfThree],
                                            [NSNumber numberWithInt:self.numberOfFour],
                                            [NSNumber numberWithInt:self.numberOfFive],
                                            [NSNumber numberWithInt:self.numberOfSix], nil];

    

    if (isPlayerOne)
    {
        self.playerOnePoints += [self calculatePoints];
    }
    else
    {
        self.playerTwoPoints += [self calculatePoints];
    }


}

- (int) calculatePoints
{
    int totalPoints =0;

    if (self.numberOfOne==6)
    {
        totalPoints+=2000;
    }
    else if((self.numberOfTwo == 6 ) || (self.numberOfThree ==6) || (self.numberOfFour ==6) || (self.numberOfFive ==6) || (self.numberOfSix ==6))
    {
        totalPoints+=1000;
    }
    else if((self.numberOfOne==1) && (self.numberOfTwo==1) && (self.numberOfThree==1) && (self.numberOfFour==1) && (self.numberOfFive==1) && (self.numberOfSix==1))
    {
        totalPoints +=1000;
    }
    else if([self checkFor3Pairs])
    {
        totalPoints +=1000;
    }
    else
    {
        if (self.numberOfOne>=3)
        {
            totalPoints +=1000;
            self.numberOfOne-=3;
        }
        if (self.numberOfTwo>=3)
        {
            totalPoints+=200;
        }
        if (self.numberOfThree>=3)
        {
            totalPoints+=300;
        }
        if(self.numberOfFour>=3)
        {
            totalPoints+=400;
        }
        if(self.numberOfFive>=3)
        {
            totalPoints+=500;
            self.numberOfFive-=3;
        }
        if(self.numberOfSix>=3)
        {
            totalPoints+=600;
        }
        totalPoints+= self.numberOfOne*100;
        totalPoints+= self.numberOfFive*50;
    }



    return totalPoints;
}

- (BOOL) checkFor3Pairs
{
    int numberOfPairs =0;
    for (NSNumber *number in self.numbers)
    {
        if (number.intValue ==2)
        {
            numberOfPairs++;
        }

    }

    if(numberOfPairs==3)
    {
        return true;
    }
    else
    {
        return false;
    }

}


- (BOOL) canIHoldThisNumber:(Die *)dieTapped :(NSArray *)dices
{
    BOOL shouldReturn;
    for (Die *die in dices)
    {
        [self checkTheNumbersRolled:die];
    }
    if (dieTapped.number ==1 || dieTapped.number ==5)
    {
        shouldReturn = true;
    }
    else if (dieTapped.number ==2 && self.numberOfTwo>=3)
    {
        if ([self returnDicesOfThatNumberHolded:2 :dices] == 3)
        {
            shouldReturn = false;
        }
        else
        {
        shouldReturn = true;
        }
    }
    else if (dieTapped.number ==3 && self.numberOfThree >=3)
    {
        if ([self returnDicesOfThatNumberHolded:3 :dices] == 3)
        {
            shouldReturn = false;
        }
        else
        {
            shouldReturn = true;
        }
    }
    else if (dieTapped.number ==4 && self.numberOfFour>=3)
    {
        if ([self returnDicesOfThatNumberHolded:4 :dices] == 3)
        {
            shouldReturn = false;
        }
        else
        {
            shouldReturn = true;
        }
    }
    else if (dieTapped.number ==6 && self.numberOfSix >=3)
    {
        if ([self returnDicesOfThatNumberHolded:6 :dices] == 3)
        {
            shouldReturn = false;
        }
        else
        {
            shouldReturn = true;
        }
    }
    else
    {
        shouldReturn = false;
    }


    [self clearNumbers];
    return shouldReturn;
}

- (int) returnDicesOfThatNumberHolded:(int)number :(NSArray *)dices
{
    int numberToBeReturned =0;

    for (Die *dice in dices)
    {
        if (dice.number == number && dice.willBeHold)
        {
            numberToBeReturned++;
        }

    }
    return numberToBeReturned;

}


- (void) clearProperties
{

    [self clearNumbers];
    self.oldNumberOfFives = 0;
    self.oldNumberOfOnes =0;
    self.oldNumberOfFours = 0;
    self.oldNumberOfTwos=0;
    self.oldNumberOfThrees=0;
    self.oldNumberOfSixes=0;



}

- (void) clearNumbers
{
    self.numberOfOne =0;
    self.numberOfTwo = 0;
    self.numberOfThree = 0;
    self.numberOfFour = 0;
    self.numberOfFive =0;
    self.numberOfSix = 0;
}




@end
