//
//  ViewController.m
//  Matchismo 2
//
//  Created by Spensa Tech on 4/6/15.
//  Copyright (c) 2015 Spensa Tech. All rights reserved.
//

#import "ViewController.h"
#import "DefaultCardViewer.h"
#import "DefaultCard.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DefaultCardViewer *cardViewer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardViewer.card = [[DefaultCard alloc] initWithSuite:Spade withRank:Joker];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

@end
