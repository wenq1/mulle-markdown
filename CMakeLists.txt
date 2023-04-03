cmake_minimum_required( VERSION 3.15)

project( mulle-markdown C)

#
# Turn an "Executable" into a "Library"
# * mulle-sde test init
# * mv src/main.m test/10_test/test.m
# Then set MULLE_PROJECT_TYPE to "Library".
# * mulle-sde reflect
# * mulle-sde test
#
set( MULLE_PROJECT_TYPE "Executable")

### mulle-sde environment

# add cmake module paths to search path
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/share")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/reflect")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake")

include( Environment)

include( Files)

set( SCRIPTS mulle-markdown-preview)


### Executable

include( Dependencies)
include( Executable)

target_compile_definitions( "${EXECUTABLE_COMPILE_TARGET}" PUBLIC)
target_compile_options( "${EXECUTABLE_COMPILE_TARGET}" PUBLIC)
# use LIBRARY_LINK_TARGET for linker options

if( LINK_PHASE AND NOT APPLE)
   target_link_options( "${EXECUTABLE_LINK_TARGET}" PUBLIC -fuse-ld=bfd)
endif()

include( InstallExecutable)

if( LINK_PHASE)
   install( FILES ${SCRIPTS} DESTINATION "bin")
endif()

# only for Executable
include( Motd OPTIONAL)

include( FinalOutput OPTIONAL)
