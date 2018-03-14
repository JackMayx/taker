//
//  ViewController.m
//  TakerFilter
//
//  Created by devjia on 2018/3/13.
//  Copyright © 2018年 VNI. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>
#import "GPUImageLookupFilter2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GPUImageView *imageView;
@property (nonatomic, strong) GPUImageLookupFilter2 *filter;
@property (nonatomic, strong) GPUImagePicture *lookupPicture;
@property (nonatomic, strong) GPUImagePicture *input;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = self.filterName;
    self.input = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"cat"]];
    self.filter = [[GPUImageLookupFilter2 alloc] init];
    UIImage *lookup = [UIImage imageNamed:self.filterName];
    self.lookupPicture = [[GPUImagePicture alloc] initWithImage:lookup];
    self.filter.texwidth = lookup.size.width;
    self.filter.gridsize = lookup.size.height;
    [self.input addTarget:self.filter atTextureLocation:0];
    [self.lookupPicture addTarget:self.filter atTextureLocation:1];
    [self.filter addTarget:self.imageView];
    [self.input processImage];
    [self.lookupPicture processImage];
}
- (IBAction)action:(UISlider *)sender {
    self.filter.intensity = sender.value;
    [self.input processImage];
    [self.lookupPicture processImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
