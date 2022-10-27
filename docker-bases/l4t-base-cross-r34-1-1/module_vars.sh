#!/bin/sh

FF_ENCODER=aac,libfdk_aac,mp2,mpeg2video,mjpeg,flv,adpcm_g722,adpcm_g726,adpcm_g726le,pcm_alaw,pcm_mulaw,pcm_u8,pcm_s16be,pcm_s16le,s302m,gif,bmp,rawvideo,speedhq
FF_DECODER=aac,libfdk_aac,mp2,mpeg2video,mjpeg,flv,png,h264,hevc,adpcm_g722,adpcm_g726,adpcm_g726le,pcm_alaw,pcm_mulaw,pcm_u8,pcm_s16be,pcm_s16le,s302m,gif,bmp,rawvideo,speedhq

if [ ! -z "${FF_EXTRA_ENCODER}" ]
then
        FF_ENCODER=${FF_ENCODER},${FF_EXTRA_ENCODER}
fi

if [ ! -z "${FF_EXTRA_DECODER}" ]
then
        FF_DECODER=${FF_DECODER},${FF_EXTRA_DECODER}
fi

FF_FLAGS="--disable-everything \
        --enable-muxer=mpegts,mp4,mjpeg,singlejpeg,smjpeg,image2,flv,h264,hevc,mov,hls,avi,gif,rawvideo,wav \
        --enable-demuxer=mpegtsraw,mpegts,mp4,mjpeg,mpjpeg,image2,flv,live_flv,h264,hevc,mov,hls,avi,apng,image_png_pipe,rtsp,gif,rawvideo,wav \
        --enable-protocol=file,hls,rtmp,rtmpt,rtmps,udp,http,https,pipe,gif \
        --enable-parser=h264,hevc,aac,mpegaudio,mjpeg,gif,bmp \
        --enable-decoder=${FF_DECODER} \
        --enable-encoder=${FF_ENCODER} \
        --enable-bsf=h264_mp4toannexb,aac_adtstoasc,hevc_mp4toannexb"

# echo ${FF_FLAGS}