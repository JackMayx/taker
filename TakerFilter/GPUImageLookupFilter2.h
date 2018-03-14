//
//  GPUImageLookupFilter2.h
//  VNi
//
//  Created by devjia on 2018/3/13.
//  Copyright © 2018年 Johnil. All rights reserved.
//

#import "GPUImageTwoInputFilter.h"

@interface GPUImageLookupFilter2 : GPUImageTwoInputFilter

@property(nonatomic, assign) CGFloat intensity;
@property(nonatomic, assign) CGFloat texwidth;
@property(nonatomic, assign) CGFloat gridsize;

@end
