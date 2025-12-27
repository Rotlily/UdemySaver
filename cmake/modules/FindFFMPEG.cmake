# FindFFMPEG.cmake - Find FFmpeg libraries
# Sets:
#  FFMPEG_FOUND - System has FFmpeg
#  FFMPEG_INCLUDE_DIRS - FFmpeg include directories
#  FFMPEG_LIBRARIES - Libraries needed to use FFmpeg
#  FFMPEG_LIBRARY_DIRS - Library directories

find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
  pkg_check_modules(PC_AVCODEC QUIET libavcodec)
  pkg_check_modules(PC_AVFORMAT QUIET libavformat)
  pkg_check_modules(PC_AVUTIL QUIET libavutil)
  pkg_check_modules(PC_SWSCALE QUIET libswscale)
endif()

# Find include directories
find_path(AVCODEC_INCLUDE_DIR
  NAMES libavcodec/avcodec.h
  HINTS ${PC_AVCODEC_INCLUDE_DIRS}
  PATH_SUFFIXES ffmpeg
)

find_path(AVFORMAT_INCLUDE_DIR
  NAMES libavformat/avformat.h
  HINTS ${PC_AVFORMAT_INCLUDE_DIRS}
  PATH_SUFFIXES ffmpeg
)

find_path(AVUTIL_INCLUDE_DIR
  NAMES libavutil/avutil.h
  HINTS ${PC_AVUTIL_INCLUDE_DIRS}
  PATH_SUFFIXES ffmpeg
)

find_path(SWSCALE_INCLUDE_DIR
  NAMES libswscale/swscale.h
  HINTS ${PC_SWSCALE_INCLUDE_DIRS}
  PATH_SUFFIXES ffmpeg
)

# Find libraries
find_library(AVCODEC_LIBRARY
  NAMES avcodec
  HINTS ${PC_AVCODEC_LIBRARY_DIRS}
)

find_library(AVFORMAT_LIBRARY
  NAMES avformat
  HINTS ${PC_AVFORMAT_LIBRARY_DIRS}
)

find_library(AVUTIL_LIBRARY
  NAMES avutil
  HINTS ${PC_AVUTIL_LIBRARY_DIRS}
)

find_library(SWSCALE_LIBRARY
  NAMES swscale
  HINTS ${PC_SWSCALE_LIBRARY_DIRS}
)

# Set output variables
set(FFMPEG_INCLUDE_DIRS
  ${AVCODEC_INCLUDE_DIR}
  ${AVFORMAT_INCLUDE_DIR}
  ${AVUTIL_INCLUDE_DIR}
  ${SWSCALE_INCLUDE_DIR}
)

set(FFMPEG_LIBRARIES
  ${AVCODEC_LIBRARY}
  ${AVFORMAT_LIBRARY}
  ${AVUTIL_LIBRARY}
  ${SWSCALE_LIBRARY}
)

# Get library directories
get_filename_component(AVCODEC_LIBRARY_DIR ${AVCODEC_LIBRARY} DIRECTORY)
set(FFMPEG_LIBRARY_DIRS ${AVCODEC_LIBRARY_DIR})

# Remove duplicates
list(REMOVE_DUPLICATES FFMPEG_INCLUDE_DIRS)

# Handle standard args
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFMPEG
  REQUIRED_VARS
    FFMPEG_LIBRARIES
    FFMPEG_INCLUDE_DIRS
)

mark_as_advanced(
  AVCODEC_INCLUDE_DIR
  AVFORMAT_INCLUDE_DIR
  AVUTIL_INCLUDE_DIR
  SWSCALE_INCLUDE_DIR
  AVCODEC_LIBRARY
  AVFORMAT_LIBRARY
  AVUTIL_LIBRARY
  SWSCALE_LIBRARY
)
