//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by Slimn Srarena on 1/18/17.
//  Copyright © 2017 VedaTech Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "NXH264MP4Decoder.h"

#define NAL_SLICE 1
#define NAL_SLICE_DPA 2
#define NAL_SLICE_DPB 3
#define NAL_SLICE_DPC 4
#define NAL_SLICE_IDR 5
#define NAL_SEI 6
#define NAL_SPS 7
#define NAL_PPS 8
#define NAL_AUD 9
#define NAL_FILLER 12

typedef struct _NaluUnit {
    int type; //IDR or INTER：note：SequenceHeader is IDR too
    int size; //note: don't contain startCode
    unsigned char *data; //note: don't contain startCode
} NaluUnit;


@interface ViewController () {
    AVPlayer *mediaPreviewPlayer;
    AVPlayerItem *mediaPreviewPlayerItem;
    
    NXH264MP4Decoder *_h264MP4;
    uint8_t   *_videoData;
    int       _cur_pos;
    int       _frameIndex;
    
}

@end

@implementation ViewController

@synthesize playerVIew;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPlayer];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setupPlayer {
    
    //NSString *mediaPath = @"/Volumes/VedaX2/Coremelt/Scribomatic Test Suite/EmbeddedAudio/RCKSTR Seg01-CamA-Clip05P.mov";
    NSString *mediaPath = @"/Volumes/VedaX2/Coremelt/Scribomatic Test Suite/Cannon Raw Clips/A004C109_17080674_CANON.CRM";
    
    mediaPreviewPlayerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:mediaPath]];
    mediaPreviewPlayer = [AVPlayer playerWithPlayerItem:mediaPreviewPlayerItem];
    [self.playerVIew setPlayer:mediaPreviewPlayer];
}


- (IBAction)actionPlayPause:(NSButton *)sender {
    
    if ([mediaPreviewPlayer status] == AVPlayerStatusReadyToPlay) {
        switch (sender.state) {
            case 0:
                [mediaPreviewPlayer play];
                break;
                
            default:
                [mediaPreviewPlayer pause];
                break;
        }
    }
}

- (void) startWrite {
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"h264"];
    NSString *path = @"/Volumes/VedaX2/Coremelt/Scribomatic Test Suite/Cannon Raw Clips/A004C109_17080674_CANON.CRM";
    NSString *convertPath = [path stringByDeletingPathExtension];
    convertPath = [convertPath stringByAppendingPathExtension:@"mov"];
    
    _h264MP4 = [[NXH264MP4Decoder alloc] initWithVideoSize:CGSizeMake(480, 854) ofExportPath:convertPath];
    
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *allData = [fileHandle readDataToEndOfFile];
    _videoData = (uint8_t*)[allData bytes];
    
    NaluUnit naluUnit;
    NSData *sps = nil;
    NSData *pps = nil;
    int frame_size = 0;
    
    while(readOneNaluFromAnnexBFormatH264(&naluUnit, _videoData, allData.length, &_cur_pos))
    {
        _frameIndex ++;
        //        NSLog(@"naluUnit.type :%d,frameIndex:%d",naluUnit.type,_frameIndex);
        if(naluUnit.type == NAL_SPS || naluUnit.type == NAL_PPS || naluUnit.type == NAL_SEI) {
            if (naluUnit.type == NAL_SPS) {
                sps = [NSData dataWithBytes:naluUnit.data length:naluUnit.size];
            } else if(naluUnit.type == NAL_PPS) {
                pps = [NSData dataWithBytes:naluUnit.data length:naluUnit.size];
            } else {
                continue;
            }
            if (sps && pps) {
                [_h264MP4 setupWithSPS:sps PPS:pps];
            }
            continue;
        }
        //获取NALUS的长度，开辟内存
        frame_size += naluUnit.size;
        BOOL isIFrame = NO;
        if (naluUnit.type == NAL_SLICE_IDR) {
            isIFrame = YES;
        }
        frame_size = naluUnit.size + 4;
        uint8_t *frame_data = (uint8_t *) calloc(1, naluUnit.size + 4);//avcc header 占用4个字节
        uint32_t littleLength = CFSwapInt32HostToBig(naluUnit.size);
        uint8_t *lengthAddress = (uint8_t*)&littleLength;
        memcpy(frame_data, lengthAddress, 4);
        memcpy(frame_data+4, naluUnit.data, naluUnit.size);
        //        NSLog(@"frame_data:%d,%d,%d,%d",*frame_data,*(frame_data+1),*(frame_data+3),*(frame_data+3));
        [_h264MP4 pushH264Data:frame_data length:frame_size isIFrame:isIFrame timeOffset:0];
        free(frame_data);
        //        usleep(5*1000);
    }
    
    [_h264MP4 endWritingCompletionHandler:nil];
}

/**
 *  从data流中读取1个NALU
 *
 *  @param nalu     NaluUnit
 *  @param buf      data流指针
 *  @param buf_size data流长度
 *  @param cur_pos  当前位置
 *
 *  @return 成功 or 失败
 */
static bool readOneNaluFromAnnexBFormatH264(NaluUnit *nalu, unsigned char * buf, size_t buf_size, int *cur_pos)
{
    int i = *cur_pos;
    while(i + 2 < buf_size)
    {
        if(buf[i] == 0x00 && buf[i+1] == 0x00 && buf[i+2] == 0x01) {
            i = i + 3;
            int pos = i;
            while (pos + 2 < buf_size)
            {
                if(buf[pos] == 0x00 && buf[pos+1] == 0x00 && buf[pos+2] == 0x01)
                    break;
                pos++;
            }
            if(pos+2 == buf_size) {
                (*nalu).size = pos+2-i;
            } else {
                while(buf[pos-1] == 0x00)
                    pos--;
                (*nalu).size = pos-i;
            }
            (*nalu).type = buf[i] & 0x1f;
            (*nalu).data = buf + i;
            *cur_pos = pos;
            return true;
        } else {
            i++;
        }
    }
    return false;
}


- (IBAction)actionExportMovie:(id)sender {
    [self startWrite];
}

@end
