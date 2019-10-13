//
//  NXH264MP4Decoder.h
//  AVPlayerDemo
//
//  Created by Slimn Srarena on 20/11/18.
//  Copyright © 2018 VedaTech Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



@interface NXH264MP4Decoder : NSObject
@property (nonatomic, assign) CGSize videoSize;
@property (nonatomic) CGFloat rotate;
@property (nonatomic) NSString *filePath;

- (instancetype) initWithVideoSize:(CGSize)videoSize
                      ofExportPath:(NSString *)exportPath;
//- (instancetype) initWithVideoSize:(CGSize) videoSize;
- (void) setupWithSPS:(NSData *)sps PPS:(NSData *)pps;
- (void) setup2;
- (void) pushH264Data:(unsigned char *)dataBuffer length:(uint32_t)len isIFrame:(BOOL)isIFrame timeOffset:(int64_t)timestamp;
- (void) pushSampleBufferRef:(CMSampleBufferRef) sampleBuffer;
- (void) endWritingCompletionHandler:(void (^)(void))handler;

@end
