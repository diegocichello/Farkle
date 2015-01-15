//
//  ViewController.m
//  Farkle
//
//  Created by Diego Cichello on 1/14/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "Die.h"
#import "Farkle.h"



@interface ViewController () <DieDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet Die *die1;
@property (weak, nonatomic) IBOutlet Die *die2;
@property (weak, nonatomic) IBOutlet Die *die3;
@property (weak, nonatomic) IBOutlet Die *die4;
@property (weak, nonatomic) IBOutlet Die *die5;
@property (weak, nonatomic) IBOutlet Die *die6;
@property IBOutletCollection(Die)  NSArray *dices;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScore;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *playerTurnLabel;

@property NSMutableArray *dice;

@property Farkle *farkle;
@property BOOL isPlayerOne;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    for (Die *dice in self.dices)
    {
        dice.delegate = self;
    }


    self.farkle = [[Farkle alloc]init];

    self.isPlayerOne = true;

    self.playerOneScore.text = @"0";
    self.playerTwoScore.text = @"0";

    [self clearDices];



     

}

- (IBAction)onBankButtonPressed:(UIButton *)sender
{
    [self.farkle scorePoints:self.isPlayerOne:self.dices];
    UIAlertView *alert = [[UIAlertView alloc]init];

    if(self.isPlayerOne)
    {
                alert.message = [NSString stringWithFormat:@"You made %i points!",self.farkle.playerOnePoints -[self.playerOneScore.text intValue] ];
    }
    else
    {
        alert.message = [NSString stringWithFormat:@"You made %i points!",self.farkle.playerTwoPoints-[self.playerTwoScore.text intValue]];
    }
    alert.title =@"Banked Points";
    [alert addButtonWithTitle:@"Ok"];
    [alert show];


    [self switchPlayers];

}

- (void) switchPlayers
{
    if (self.isPlayerOne)
    {
        self.isPlayerOne =false;
        self.playerTurnLabel.text = @"Player 2 Turn";

    }
    else
    {
        self.IsPlayerOne = true;
        self.playerTurnLabel.text =@"Player 1 Turn";
    }

    [self updateScoreLabels];
    [self clearDices];
    [self.farkle clearProperties];

}

- (void) clearDices
{

    for(Die *dice in self.dices)
    {
        dice.willBeHold = false;
        dice.willBeHoldForever =false;
        dice.number=0;
        dice.image =[[UIImage alloc]init];
        dice.alpha =1.0;
        dice.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void) updateScoreLabels
{
    int playerOnePoints = self.farkle.playerOnePoints;
    int playerTwoPoints = self.farkle.playerTwoPoints;
    self.playerOneScore.text = [NSString stringWithFormat:@"%i",playerOnePoints];
    self.playerTwoScore.text = [NSString stringWithFormat:@"%i",playerTwoPoints];
}

- (IBAction)onRollDieButtonPressed:(id)sender
{
    for (Die *dice in self.dices)
    {

        if(!dice.willBeHold)
        {
            switch (dice.number)
            {
                case 1: self.farkle.oldNumberOfOnes--; break;
                case 2: self.farkle.oldNumberOfTwos--;break;
                case 3: self.farkle.oldNumberOfThrees--;break;
                case 4: self.farkle.oldNumberOfFours--;break;
                case 5: self.farkle.oldNumberOfFives--;break;
                case 6: self.farkle.oldNumberOfSixes--;break;

            }
        }

        dice.backgroundColor = [UIColor clearColor];
        [dice roll];
        if (dice.willBeHold)
        {
            dice.willBeHoldForever = true;
            dice.alpha =0.2;
        }
        
    }


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.farkle checkForFarkle:self.dices])
        {
            UIAlertView *alert = [[UIAlertView alloc]init];


            alert.message = @"You just Farkled!";
            alert.title =@"Farkle!!!";
            [alert addButtonWithTitle:@"Ok"];
            [alert show];
            
            [self switchPlayers];
            
        }
    });

}

- (void)dieBlockedFromBeingThrowed:(Die *)diceTapped
{
    if ([self.farkle canIHoldThisNumber:diceTapped :self.dices ])
    {
        if (!diceTapped.willBeHoldForever)
        {
            if (diceTapped.willBeHold)
            {
                diceTapped.willBeHold = false;
                diceTapped.alpha = 1.0;
            }
            else
            {
                diceTapped.alpha =0.5;
                diceTapped.willBeHold = true;
            }
        }
    }
}




@end
