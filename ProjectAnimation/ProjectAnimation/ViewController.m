//
//  ViewController.m
//  ProjectAnimation
//
//  Created by Treinamento on 12/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rec = self.searchBar.frame;
    rec.origin.x = -500;
    self.searchBar.frame = rec;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mostraBusca:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    
    CGRect rec = self.searchBar.frame;
    rec.origin.x = 56;
    self.searchBar.frame = rec;
    
    [UIView commitAnimations];
}


-(void) removerView{
    
    
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [self.myView removeFromSuperview];
                        
                    }
                    completion:^(BOOL finished){
                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                    }];
}

- (IBAction)showView:(id)sender {
    self.myView = [[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] objectAtIndex:0];
    //ficar com a tela toda a view
    
    self.myView.frame = self.view.frame;
    
    [self.myView ocultarElementos];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removerView) name:@"sidd"
                                               object:nil];
    
    [UIView transitionWithView:self.view
        duration:0.5
        options:UIViewAnimationOptionTransitionCrossDissolve
        animations:^{
        
        [self.view addSubview:self.myView];
    
        }
        completion:^(BOOL finished){
            [self.myView exibirElementos];
    }];
    
}




@end
