/*
 * Copyright © 2016 Intel Corporation. All Rights Reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Base SDK
#import <Woogeen/RTCMacros.h>
#import <Woogeen/RTCMediaCodec.h>
#import <Woogeen/RTCMediaFormat.h>
#import <Woogeen/RTCErrors.h>
#import <Woogeen/RTCStream.h>
#import <Woogeen/RTCLocalStream.h>
#import <Woogeen/RTCLocalCameraStream.h>
#import <Woogeen/RTCLocalCustomizedStream.h>
#import <Woogeen/RTCLogging.h>
#import <Woogeen/RTCRemoteStream.h>
#import <Woogeen/RTCRemoteCameraStream.h>
#import <Woogeen/RTCRemoteMixedStream.h>
#import <Woogeen/RTCRemoteMixedStreamObserver.h>
#import <Woogeen/RTCRemoteScreenStream.h>
#import <Woogeen/RTCIceServer.h>
#import <Woogeen/RTCGlobalConfiguration.h>
#import <Woogeen/RTCFrameGeneratorProtocol.h>

// P2P SDK
#import <Woogeen/RTCPeerClient.h>
#import <Woogeen/RTCP2PErrors.h>

// Conference SDK
#import <Woogeen/RTCConferenceClient.h>
#import <Woogeen/RTCConferenceErrors.h>

// Following headers are part of sample implementations
#import <Woogeen/RTCVideoRenderer.h>
#import <Woogeen/RTCEAGLVideoView.h>

