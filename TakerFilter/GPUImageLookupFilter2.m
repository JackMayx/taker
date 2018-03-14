//
//  GPUImageLookupFilter2.m
//  VNi
//
//  Created by devjia on 2018/3/13.
//  Copyright © 2018年 Johnil. All rights reserved.
//

#import "GPUImageLookupFilter2.h"
NSString *const kGPUImageLookup2FragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 uniform highp float intensity;
 uniform highp float gridsize;
 uniform highp float texwidth;

 void main()
{
    highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    highp float slice = textureColor.b * (gridsize - 1.0);
    highp float islice0 = floor(slice);
    highp float islice1 = min(31.0, islice0 + 1.0);
    highp float fslice = fract(slice);
    highp float x = textureColor.r * (gridsize - 1.0);
    highp float x1 = x + islice0*gridsize + 0.5;
    highp float x2 = x + islice1*gridsize + 0.5;
    highp float y = textureColor.g * (gridsize - 1.0) + 0.5;
    highp vec2 texPos1 = vec2(x1 / texwidth, y/32.0);
    highp vec2 texPos2 = vec2(x2 / texwidth, y/32.0);
    highp vec4 newColor1 = texture2D(inputImageTexture2, texPos1);
    highp vec4 newColor2 = texture2D(inputImageTexture2, texPos2);
    highp vec4 newColor = mix(newColor1, newColor2, fslice);
    highp vec4 minColor = textureColor;
    newColor = mix(minColor, newColor, intensity);
    gl_FragColor = newColor;
}
 );
@interface GPUImageLookupFilter2()
{
    GLint intensityUniform;
    GLint gridsizeUniform;
    GLint texwidthUniform;
}

@end

@implementation GPUImageLookupFilter2

#pragma mark -
#pragma mark Initialization and teardown

- (id)init {
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageLookup2FragmentShaderString])) {
        return nil;
    }
    
    intensityUniform = [filterProgram uniformIndex:@"intensity"];
    self.intensity = 1.0f;
    gridsizeUniform = [filterProgram uniformIndex:@"gridsize"];
    texwidthUniform = [filterProgram uniformIndex:@"texwidth"];
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setIntensity:(CGFloat)intensity {
    _intensity = MIN(MAX(intensity, 0), 1);;
    
    [self setFloat:_intensity forUniform:intensityUniform program:filterProgram];
}
- (void)setGridsize:(CGFloat)gridsize {
    _gridsize = gridsize;
    [self setFloat:gridsize forUniform:gridsizeUniform program:filterProgram];
}
- (void)setTexwidth:(CGFloat)texwidth {
    _texwidth = texwidth;
    [self setFloat:texwidth forUniform:texwidthUniform program:filterProgram];
}
@end
