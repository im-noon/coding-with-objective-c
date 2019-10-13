//
//  NXAppGlobal.h
//  FCPXMLDump
//
//  Created by Slimn Srarena on 2/1/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @typedef sttServiceprovider
 @brief A Speech to text service provider.
 @discussion This value represent the cloud service provider selection.
 @field IBM_Watson
 @field Google_Cloud
 */
typedef enum : NSUInteger {
    /*! Service host by IBM Watson. */
    IBM_Watson,
    /*! Service host by Google cloud API */
    Google_Cloud,
}sttServiceprovider;

/*!
 @typedef fileExportType
 @brief The result output format.
 @discussion This key represent format of transcribe result.
 @field EXPORT_TO_FCPX
 @field EXPORT_TO_XML
 @field EXPORT_TO_TEXT
 */
typedef enum : NSUInteger {
    /*! export direct to Final Cut Pro X */
    EXPORT_TO_FCPX,
    /*! save as fcpxml. */
    EXPORT_TO_XML,
    /*! save as plain text. */
    EXPORT_TO_TEXT,
}fileExportType;

/*!
 @typedef fileImportType
 @brief The input source format support.
 @discussion This key represent the support format of input source.
 @field IMPORT_TYPE_AUDIO
 @field IMPORT_TYPE_VIDEO
 @field IMPORT_TYPE_FCPXML
 */
typedef enum : NSUInteger {
    /*! import audio source. */
    IMPORT_TYPE_AUDIO,
    /*! import video source. */
    IMPORT_TYPE_VIDEO,
    /*! import fcpxml source. */
    IMPORT_TYPE_FCPXML,
}fileImportType;

/*!
 @typedef audioFormatWriter
 @brief Audio convert output format support
 @discussion This key represent the audio format output support.
 @field audioFormat_ACC
 @field audioFormat_MP3
 @field audioFormat_M4A
 @field audioFormat_WAV
 
 */
typedef enum : NSUInteger {
    /*! Advanced Audio Coding. */
    audioFormat_ACC,
    /*! MPEG-1, audio layer 3. */
    audioFormat_MP3,
    /*! MPEG-4 audio container format. */
    audioFormat_M4A,
    /*! Linear PCM. */
    audioFormat_WAV
} audioFormatWriter;

/*!
 @typedef audioSamplingWriter
 @brief Sample rate support for audio convert.
 @discussion This key represent the sample frequency for audio output.
 @field audioSampling_8000Hz     8kHz sampling rate
 @field audioSampling_16000KHz   16kHz sampling rate
 @field audioSampling_44100KHz   44.1kHz sampling rate
 @field audioSampling_48000KHz   48kHz sampling rate
 @field audioSampling_96000KHz   96kHz sampling rate
 @field audioSampling_128000KHz  128kHz sampling rate
 */

typedef enum : NSUInteger {
    /*! 8kHz sampling rate */
    audioSampling_8000Hz,
    /*! 16kHz sampling rate */
    audioSampling_16000KHz,
    /*! 44.1kHz sampling rate */
    audioSampling_44100KHz,
    /*! 48kHz sampling rate */
    audioSampling_48000KHz,
    /*! 96kHz sampling rate */
    audioSampling_96000KHz,
    /*! 128kHz sampling rate */
    audioSampling_128000KHz,
} audioSamplingWriter;

/*!
 @typedef nxFileSupport
 @brief import media format support.
 @discussion This key represent the sample frequency for audio output.
 @field format_FCPXML
 @field format_ACC
 @field format_FLAC
 @field format_M4A
 @field format_MP3
 @field format_WAV
 @field format_MOV
 @field format_MP4
 @field format_M4V
 @field format_NotSupport
 */

typedef enum : NSUInteger {
    /*! final cut pto xml */
    format_FCPXML,
    /*! ACC audio */
    format_ACC,
    /*! Free losless audio codec */
    format_FLAC,
    /*! 128kHz sampling rate */
    format_M4A,
    /*! MPEG-4 audio format */
    format_MP3,
    /*! MPEG-3 audio format */
    format_WAV,
    /*! Apple's Quicktime movies  */
    format_MOV,
    /*! MPEG-4 audio/video */
    format_MP4,
    /*! Apple's video   */
    format_M4V,
    /*! File format not support */
    format_NotSupport
} nxFileSupport;

#define TIME_SECOND_SECOND 1
#define TIME_SECOND_MINUTE 60
#define TIME_SECOND_HOUR   3600

#define MAX_SPIT_DURATION_TIME 5

#define MIN_CLIP_DURATION_TIME 15
//#define MAX_SPIT_DURATION_TIME 5
//#define MAX_SPIT_DURATION_TIME 5
#define MAX_LEVEL_TIMELEFT 3600.0

#define NSERROR_LOG(s)          NSLog (@"!Error : '%@' in %s line %d", s, __func__, __LINE__);
#define NSERROR_LOG_NUM(s, d)   NSLog (@"!Error : '%@': %d in %s line %d", s, d, __func__, __LINE__);
#define NSDEBUG_LOG(s)          NSLog (@">Debug : '%@' in %s line %d", s, __func__, __LINE__);
#define NSDEBUG_LOG_NUM(s, d)   NSLog (@">Debug : '%@': %d in %s line %d", s, d, __func__, __LINE__);
