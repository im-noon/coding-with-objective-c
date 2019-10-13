//
//  NXFcpxmlMetadataKey.h
//  FCPXMLDump
//
//  Created by Slimn Srarena on 2/1/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!@briefA reference to the video format defined by the <format> element.*/
extern const NSString*     kTimelineFormat;

/*!@brief The timecode display format, either drop frame (DF) or nondrop frame (NDF, the default).*/
extern const NSString*     kTimelineTCFormat;

/*!@briefThe timecode origin represented as a time value.*/
extern const NSString*     kTimelineTCStart;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The audio channel layout, one of mono, stereo (the default), or surround.*/
extern const NSString*     kTimelineAudioLayout;

/*!@brief The audio sample rate (one of 32k, 44.1k, 48k, 88k, 96k, 176.4k, or 192k); the default is 48k.*/
extern const NSString*     kTimelineAudioRate;

/*!@brief An element’s location in parent time (or base element’s time for an anchor).*/
extern const NSString*     kTimingOffset;

/*!@brief An element’s extent in parent time.*/
extern const NSString*     kTimingDuration;

/*!@brief The start of an element’s local timeline (to schedule its contained and anchored items).*/
extern const NSString*     kTimingStart;

/*!@briefAssigns a role to the audio component for <audio-channel-source>. Specifies the role in the underlying media the audio component represents for <audio-role-source>.*/
extern const NSString*     kAudioComponentRole;

/*!@brief The duration of the audio component. If absent, the duration is derived based on the parent container timing.*/
extern const NSString*     kAudioComponentDuration;

/*!@brief Specifies whether the audio component is active (1, the default) or inactive (0). If inactive, the audio component no longer participates in the audio mix and is no longer displayed in the timeline (the data is preserved).*/
extern const NSString*     kAudioComponentActive;

/*!@brief Specifies whether the audio component is enabled (1, the default) or disabled (0).*/
extern const NSString*     kAudioComponentEnable;

/*!@brief An indication of how the audio source channels are assigned to the output, such as "L, R".*/
extern const NSString*     kAudioChannelSrcCh;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kAudioChannelOutCh;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;

/*!@brief The color space to render into, one of Rec. 601 (NTSC), Rec. 601 (PAL), Rec. 709 (the default), or Rec. 2020.*/
extern const NSString*     kTimelineRenderColorSpace;
