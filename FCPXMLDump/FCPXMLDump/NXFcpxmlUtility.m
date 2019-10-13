//
//  NXFcpxmlUtility.m
//  FCPXMLDump
//
//  Created by Slimn Srarena on 2/1/17.
//  Copyright © 2017 Veda. All rights reserved.
//

#import "NXFcpxmlUtility.h"
@interface NXFcpxmlUtility () {
    
    /*!@brief The <resources> element*/
    NSMutableArray *resources;
    
    /*!@brief A reference to a media file managed by a library */
    NSMutableArray *asset;
    
    /*!@briefA reference to an effect plug-in (for example, FxPlug, Motion document, or Audio Unit).
     @discussion The src attribute specifies the location of a Motion template, when templates are managed in the library or another external location. */
    NSMutableArray *effect;
    
    /*!A reference to a Final Cut Pro X video format definition. */
    NSMutableArray *format;
    
    /*!@brief A reference to a new or existing media definition in a library.
     @discussion The child element, either <multicam> or <sequence>, specifies whether this is a multicam or compound clip. */
    NSMutableArray *media;
    
    /*!@brief A single library.
     @discussion This element has the following attributes:
     colorProcessing—Specifies whether the library supports wide or standard color gamut. The default is standard.
     location—Specifies the URL of the library on export, but is ignored during import. Refer to the library location import option in Import Options.*/
    NSMutableArray *library;
    
    /*!@brief A single event in a library.
     @discussion The name attribute specifies the name of the event. */
    NSMutableArray *event;
    
    /*!@brief A project timeline.
     @discussion The name attribute specifies the name of the project. */
    NSMutableArray *project;
    
    /*!@brief A container representing the top-level sequence for a Final Cut Pro X project or compound clip.*/
    NSMutableArray *sequence;
    
    /*!@brief A container that schedules elements sequentially in time. */
    NSMutableArray *spine;
    
    /*!@brief A container for editing or compositing media
     and other story elements. */
    NSMutableDictionary *clip;
    
    /*!@brief A clip referencing a single media asset.
     @discussion The start and duration attributes apply to all media components in the asset.The audio-role and video-role attributes specify the main role.
     Subroles are generated using the main role name
     followed by a numerical suffix,
     for example dialogue.dialogue-1, dialogue.dialogue-2 and so on.
     */
    NSMutableDictionary *assetClip;
    
    /*!@brief A clip whose contained and anchored items are synchronized.
     @discussion The <sync-source> element describes
     the audio components for the synchronized clip. */
    NSMutableDictionary *syncClip;
    
    /*!@brief A reference to audio data from an <asset> or <effect>.
     @discussion Attributes include:
     role—Assigns a role to the audio media component. Format is main-role.subrole.
     srcID—References the specific audio source (or track) in the asset. The default is 1.
     srcCh—Identifies specific audio source channels in the asset. Value is a comma-separated series of 1-based channel indices.
     outCh—Specifies output channels to send the audio. Value is a comma-separated series of channel tags: L, R, C, LFE, Ls, Rs, and X.
     */
    NSMutableDictionary *audio;
    
    /*!@brief A reference to video data from an <asset> or <effect>.
     @discussion Attributes include:
     role—Assigns a role to the video media component.
     Format is main-role.subrole.
     srcID—References the specific video source in the asset.
     The default is 1 */
    NSMutableDictionary *video;
    
    /*!@brief A reference to audio/video data from a <multicam> media source. */
    NSMutableDictionary *mcClip;
    
    /*!@brief A reference to audio/video data from a <sequence> media source. */
    NSMutableDictionary *refClip;
    
    /*!@brief A placeholder element with no intrinsic audio or video data. */
    NSMutableDictionary *gap;
    
    /*!@brief An effect that combines zero, one,
     * or two neighboring elements.
     */
    NSMutableDictionary *transition;
    
    /*!@brief An effect with custom text elements.*/
    NSMutableDictionary *title;
    
    /*!@brief A container of alternative elements,
     * exactly one of which is currently active.
     */
    NSMutableDictionary *audition;

}

@end

@implementation NXFcpxmlUtility

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetProperty];
    }
    return self;
}


- (void)resetProperty {
    resources   = [[NSMutableArray alloc] init];
    asset       = [[NSMutableArray alloc] init];
    effect      = [[NSMutableArray alloc] init];
    format      = [[NSMutableArray alloc] init];
    media       = [[NSMutableArray alloc] init];
    library     = [[NSMutableArray alloc] init];
    event       = [[NSMutableArray alloc] init];
    project     = [[NSMutableArray alloc] init];
    spine       = [[NSMutableArray alloc] init];
    clip        = [[NSMutableDictionary alloc] init];
    assetClip   = [[NSMutableDictionary alloc] init];
    syncClip    = [[NSMutableDictionary alloc] init];
    audio       = [[NSMutableDictionary alloc] init];
    video       = [[NSMutableDictionary alloc] init];
    mcClip      = [[NSMutableDictionary alloc] init];
    refClip     = [[NSMutableDictionary alloc] init];
    gap         = [[NSMutableDictionary alloc] init];
    transition  = [[NSMutableDictionary alloc] init];
    title       = [[NSMutableDictionary alloc] init];
    audition    = [[NSMutableDictionary alloc] init];
}



- (NSXMLDocument *) readSimpleXMLFile:(NSString *)filename {
    
    NSDEBUG_LOG(filename);
    NSError       *error =nil;
    
    NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] init];
    
    NSURL *fileURL = [NSURL fileURLWithPath:filename];
    
    NSDEBUG_LOG(fileURL);
    
    if (fileURL == nil) {
        
        NSERROR_LOG(@"invalid file");
        return nil;
    } else {
        NSERROR_LOG(fileURL);
    }
    
    xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:fileURL
                                                  options:NSXMLDocumentXMLKind
                                                    error:&error];
    
    if(error) {
        NSERROR_LOG(error);
        return nil;
    }
    
    return xmlDoc;
}

- (void)getFcpxml:(NSString *)filename {
    
    NSXMLDocument *xmlDoc = [self readSimpleXMLFile:filename];
    
    //[self updateXMLDoc:xmlDoc];
    [self getFCPXMLVersion:xmlDoc];
    
}

#pragma -mark FCPXML


- (NSDictionary *) getAttribute: (NSXMLElement *)elem {
    
    NSMutableDictionary *attributesDict = [[NSMutableDictionary alloc] init];
    
    //NSXMLNode *aNode = elem;
    // NSArray *children = [elem attributes];
    
    //NSLog(@"-> getAttribute xnode: %lu", elem.attributes.count);
    
    if(elem.attributes.count > 0)
    {
        for( NSXMLNode *node in [elem attributes] ) {
            //NSLog(@"        -> node : %@", node);
            NSString *name = [node name];
            NSString *value = [node stringValue];
            [attributesDict setValue:value forKey:name];
        }
    }
    return attributesDict;
}


- (NSString *) getFCPXMLVersion:(NSXMLDocument *)xmlDoc {
    
    NSXMLNode *root = [xmlDoc rootElement];
    
    NSDictionary *dictRoot = [self getAttribute:(NSXMLElement *)root];
    
    NSDEBUG_LOG(dictRoot);
    NSString *version = [dictRoot objectForKey:@"version"];

    return version;
}

- (NSMutableDictionary *) queryResourcesFormatElement : (NSXMLDocument *)xmlDoc {
    
    NSError *err;
    NSArray *formatNodes = [xmlDoc nodesForXPath:@".//resources/format"error:&err];
    NSMutableDictionary *formatDict = [[NSMutableDictionary alloc] init];
    
    NSString *formatKey;
    if([formatNodes count]) {
        
        NSInteger i, count = [formatNodes count];
        for (i=0; i < count; i++) {
            NSMutableDictionary *attrDict = [[NSMutableDictionary alloc] init];
            NSXMLElement *child = [formatNodes objectAtIndex:i];
            
            NSDictionary *tempDeict = [self getAttribute:child];
            if (tempDeict) {
                [attrDict setValuesForKeysWithDictionary:tempDeict];
                formatKey = [attrDict valueForKey:@"id"];
                [formatDict  setValue:attrDict forKey:formatKey];
            }
        }
    }
    else {
        return nil;
    }
    
    return formatDict;
}

- (NSMutableDictionary *) queryResourcesAssetElement : (NSXMLDocument *)xmlDoc {
    
    NSError *err;
    NSArray *assetsNodes = [xmlDoc nodesForXPath:@".//resources/asset"error:&err];
    NSMutableDictionary *assetDict = [[NSMutableDictionary alloc] init];
    
    NSString *assetKey;
    if([assetsNodes count]){
        
        NSInteger i, count = [assetsNodes count];
        for (i=0; i < count; i++) {
            NSMutableDictionary *attrDict = [[NSMutableDictionary alloc] init];
            NSXMLElement *child = [assetsNodes objectAtIndex:i];
            
            NSDictionary *tempDeict = [self getAttribute:child];
            if (tempDeict) {
                [attrDict setValuesForKeysWithDictionary:tempDeict];
                assetKey = [attrDict valueForKey:@"id"];
                [assetDict  setValue:attrDict forKey:assetKey];
            }
        }
    }
    else {
        return nil;
    }
    
    return assetDict;
}

- (NSMutableDictionary *) queryLibraryEventElement : (NSXMLDocument *)xmlDoc {
    
    NSError *err;
    NSString *libraryLo = @"";
    NSMutableDictionary *mdictFcpxmlLibrary = [[NSMutableDictionary alloc] init];
    
    /// grab asset information
    NSMutableDictionary *mdictAsset = [self queryResourcesAssetElement:xmlDoc];
    //NSDEBUG_LOG(mdictAsset);
    
    
    NSXMLNode *libraryNode = [[xmlDoc rootElement] childAtIndex:1];
    NSMutableDictionary *mdictLibrary = [[NSMutableDictionary alloc] init];
    mdictLibrary = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)libraryNode]];
    //NSDEBUG_LOG(mdictLibrary);
    if (mdictLibrary) {
        libraryLo = [mdictLibrary objectForKey:@"location"];
        libraryLo = [[libraryLo lastPathComponent] stringByRemovingPercentEncoding];
        //NSDEBUG_LOG(libraryLo);
    }
    
    NSArray *eventNodes = [xmlDoc nodesForXPath:@".//library/event"error:&err];
    //NSDEBUG_LOG(eventNodes);
    
  
    NSMutableArray *arrLibrary = [[NSMutableArray alloc] init];
    NSMutableDictionary *mdictlibrary      = [[NSMutableDictionary alloc] init];
    for (int i=0; i < [eventNodes count]; i++) {
        NSXMLNode *eventElem = [eventNodes objectAtIndex:i];
        
        NSMutableDictionary *mdictEvent      = [[NSMutableDictionary alloc] init];
        mdictEvent = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)eventElem]];
        
        NSDEBUG_LOG(mdictEvent);
        
        //NSString *strEventName = [mdictEvent objectForKey:@"name"];
        
        if ([eventElem childCount] > 0) {

            //NSMutableArray *arrEvent = [[NSMutableArray alloc] init];
        
            NSMutableArray *arrProject = [[NSMutableArray alloc] init];
            
            
            for (int j=0; j < (int)[eventElem childCount]; j++) {
                NSXMLNode *projElem = [eventElem childAtIndex:j];
                NSMutableDictionary *mdictProject      = [[NSMutableDictionary alloc] init];
                
                mdictProject = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)projElem]];
                //NSString *strProjectName = [mdictProject objectForKey:@"name"];
                
                if ([projElem childCount] > 0) {
                    NSMutableArray *arrSeq = [[NSMutableArray alloc] init];
                    
                    
                    for (int k=0; k < (int)[eventElem childCount]; k++) {
                        NSXMLNode *seqElem = [projElem childAtIndex:k];
                        NSMutableDictionary *mdictSeq      = [[NSMutableDictionary alloc] init];
                        
                        mdictSeq = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)seqElem]];

                        if ([seqElem childCount] > 0) {
                            
                            NSMutableArray *arrSpine = [[NSMutableArray alloc] init];
                            
                            
                            for (int l=0; l < (int)[seqElem childCount]; l++) {
                                NSXMLNode *spineElem = [seqElem childAtIndex:l];
                                NSMutableDictionary *mdictSpine      = [[NSMutableDictionary alloc] init];
                                
                                mdictSpine = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)spineElem]];
                                
                                if ([spineElem childCount] > 0) {
                                    for (int m=0; m < (int)[spineElem childCount]; m++) {
                                        NSXMLNode *timelineElem = [spineElem childAtIndex:m];
                                        NSMutableDictionary *mdictContent    = [[NSMutableDictionary alloc] init];
                                        NSMutableDictionary *mdictTimeline      = [[NSMutableDictionary alloc] init];
                                        
                                        mdictTimeline = [NSMutableDictionary dictionaryWithDictionary:[self getAttribute:(NSXMLElement *)timelineElem]];
                                        ///////
                                        NSString *ref  = [mdictTimeline objectForKey:@"ref"];
                                        NSString *name = [mdictTimeline objectForKey:@"name"];
                                        NSArray *assetKey = [mdictAsset allKeys];
                                        
                                        ///
                                        [mdictTimeline setValue:[timelineElem name] forKey:@"node"];
                                        
                                        if (ref) {
                                            for (int n = 0; n < [assetKey count]; n++) {
                                                NSString *assetkey = [assetKey objectAtIndex:n];
                                                
                                                NSDictionary *dictAssetId = [mdictAsset objectForKey:assetkey];
                                                if ([ref isEqualToString:assetkey]) {
                                                    NSString *path      = [dictAssetId objectForKey:@"src"];
                                                    NSString *duration  = [dictAssetId objectForKey:@"duration"];
                                                    NSString *start     = [dictAssetId objectForKey:@"start"];
                                                    NSString *hasVideo  = [dictAssetId objectForKey:@"hasVideo"];
                                                    NSString *hasAudio  = [dictAssetId objectForKey:@"hasAudio"];
                                                    
                                                    if (path) {
                                                        [mdictTimeline setValue:path forKey:@"path"];
                                                    }
                                                    if (duration) {
                                                        [mdictTimeline setValue:duration forKey:@"srcDuration"];
                                                    }
                                                    
                                                    if (start) {
                                                        [mdictTimeline setValue:start forKey:@"srcStart"];
                                                    }
                                                    
                                                    if (hasVideo) {
                                                        [mdictTimeline setValue:hasVideo forKey:@"hasVideo"];
                                                    }
                                                    
                                                    if (hasAudio) {
                                                        [mdictTimeline setValue:hasAudio forKey:@"hasAudio"];
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        [mdictContent setObject:mdictTimeline forKey:name];
                                        [arrSpine addObject:mdictContent];
                                    }
                                }
                                [arrSpine addObject:mdictSpine];
                                NSString *spneKey = [NSString stringWithFormat:@"Spine%d",j];
                                [mdictSeq setObject:arrSpine forKey:spneKey];
                            }
                        }
                        [arrSeq addObject:mdictSeq];
                        NSString *seqKey = [NSString stringWithFormat:@"seq%d",j];
                        [mdictProject setObject:arrSeq forKey:seqKey];
                    }
                }
                [arrProject addObject:mdictProject];
                NSString *projectKey = [NSString stringWithFormat:@"project%d",j];
                [mdictEvent setObject:arrProject forKey:projectKey];
            }
        }
       
        //[arrLibrary addObject:mdictEvent];
        NSString *eventKey = [NSString stringWithFormat:@"event%d",i];
        [mdictlibrary setObject:mdictEvent forKey:eventKey];
    }
    [mdictFcpxmlLibrary setObject:mdictlibrary forKey:libraryLo];
    
    
    NSDEBUG_LOG(mdictFcpxmlLibrary);
    return mdictFcpxmlLibrary;
}

- (NSXMLDocument *)updateXMLDoc : (NSXMLDocument *)xmlDoc {
    
    
    NSXMLDocument *xmlDocCopy = [xmlDoc copy];
    /*!grab library element*/
    NSXMLNode *updatelibraryNode = [[xmlDocCopy rootElement] childAtIndex:1];

    NSInteger updateIndex = 0;
    NSXMLNode *libraryChileNode = [updatelibraryNode childAtIndex:0];
    do {
        
        NSString *nodeName = [libraryChileNode name];
        
        /*!@brief Consider only event element*/
        if ([nodeName isNotEqualTo:@"event"]) {
            continue;
        }
        //NSXMLElement *parent = (NSXMLElement *)[libraryChileNode parent];
        //NSDEBUG_LOG(parent);
        NSLog(@"name : %@ : %lu ",[libraryChileNode name], (unsigned long)[libraryChileNode childCount]);
        
        if ([libraryChileNode childCount]> 0) {
            NSXMLNode *eventNode = [libraryChileNode childAtIndex:0];
            NSInteger eventIndex = 0;
            do {
                NSString *eventName = [eventNode name];
                
                
                NSLog(@"name : %@ : %lu ",eventName, (unsigned long)[eventNode childCount]);
                /*!@brief Consider only event element*/
                //if ([eventName isNotEqualTo:@"project"]) {
                //    continue;
                //}
                if ([eventNode childCount]> 0) {
                    NSXMLNode *projectNode = [eventNode childAtIndex:0];
                    NSInteger projectIndex = 0;
                    do {
                        NSString *eventName = [projectNode name];
                        
                        /*!@brief Consider only event element*/
                        //if ([eventName isNotEqualTo:@"project"]) {
                        //    continue;
                        //}
                        
                        NSLog(@"name : %@ : %lu ",eventName, (unsigned long)[projectNode childCount]);
                        
                        if ([projectNode childCount]> 0) {
                            
                            
                            NSXMLNode *seqNode = [projectNode childAtIndex:0];
                            NSInteger seqIndex = 0;
                            do {
                                NSString *seqName = [seqNode name];
                                
                                /*!@brief Consider only event element*/
                                //if ([eventName isNotEqualTo:@"project"]) {
                                //    continue;
                                //}
                                NSXMLElement *parent = (NSXMLElement *)[seqNode parent];
                                //NSDEBUG_LOG([parent name]);
                                
                                
                                NSLog(@"name : %@ : %lu ",seqName, (unsigned long)[seqNode childCount]);
                                
                                if ([seqNode childCount]> 0) {
                                    [parent removeChildAtIndex:seqIndex];
                                }
                                
                                seqIndex++;
                            } while ( (seqNode = [seqNode nextSibling] ));
                            
                            
                        }

                        
                        
                        projectIndex++;
                    } while ( (projectNode = [projectNode nextSibling] ));
                    
                    
                }

                
                
                
                eventIndex++;
            } while ( (eventNode = [eventNode nextSibling] ));
            
            
        }
        
       // [libraryChileNode remove]
        //[parent removeChildAtIndex:updateIndex];
        //NSDEBUG_LOG(parent);
        
        updateIndex++;
    } while ( (libraryChileNode = [libraryChileNode nextSibling] ));
    
    
    NSXMLElement *parentLibrary = (NSXMLElement *)[updatelibraryNode parent];
    
    NSDEBUG_LOG(parentLibrary);
    
    NSDEBUG_LOG(xmlDoc);
    
    NSDEBUG_LOG(xmlDocCopy);
    
    return xmlDocCopy;
}

@end
