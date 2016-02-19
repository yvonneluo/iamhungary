//
//  DraggableViewBackground.m
//  testing swiping
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
#import "Business.h"
#import "DraggableViewBackground.h"
@interface DraggableViewBackground ()
@property (nonatomic, strong) UILabel *headerLabel;
@property(nonatomic, strong) UIButton * likeButton;
@property(nonatomic, strong) UIButton * dislikeButton;

@end
@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 375; //%%% width of the draggable card

@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame responseDictionary:(NSArray *)businesses
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        NSMutableArray *businessNames = [[NSMutableArray alloc] init];
        /*
        for (id business in businesses) {
            [businessNames addObject:[business objectForKey:@"name"]];
        }                                                        */
        exampleCardLabels = [[NSArray alloc] initWithArray:businessNames];
        //businessNames;//[[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCardswithBusiness:businesses];
    }
    return self;
}


-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    CGFloat xButtonX = 60.0/350 * [[UIScreen mainScreen] bounds].size.width;
    CGFloat checkButtonX = 250.0/350 * [[UIScreen mainScreen] bounds].size.width;

    xButton = [[UIButton alloc]initWithFrame:CGRectMake(xButtonX, 525, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"noclear"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(checkButtonX, 525, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"yesclear"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

#warning include own card customization here!
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index withBusiness:(Business *)business
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:
            CGRectMake(0,
                    (self.frame.size.height - width)/2,
                    width,
                    CARD_HEIGHT) withBusiness:business];
    draggableView.information.text = @"";
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCardswithBusiness:(NSArray *)businesses
{
    if([businesses count] > 0) {
        NSInteger numLoadedCardsCap =(([businesses count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[businesses count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        //NSArray * business_arrs = businesses.allValues;
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[businesses count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i withBusiness:businesses[i]];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
        [self addSubview:self.headerLabel];
    }
}

-(UILabel *)headerLabel {
    if(!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = @"yelpscover";
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.backgroundColor = [UIColor colorWithRed:231.0/255 green:51.0/255 blue:25.0/255 alpha:1];
        _headerLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:35];
        _headerLabel.textAlignment = NSTextAlignmentCenter;

        CGRect headerFrame = _headerLabel.frame;
        headerFrame.size.width = self.frame.size.width;
        headerFrame.size.height = 80;
        _headerLabel.frame = headerFrame;
    }
    return _headerLabel;
}


-(UIButton *)likeButton {
    if(!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"yesclear"] forState:UIControlStateNormal];
    }
    return _likeButton;
}

#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}
@end
