# Copyright 2026 NWChemEx-Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_guard()
include(FetchContent)

# GauXC builds a real library from its own CMakeLists. Turn off HDF5 before
# add_subdirectory (CACHE FORCE so our value wins over its option() default,
# policy CMP0077).
set(GAUXC_ENABLE_HDF5 OFF CACHE BOOL "" FORCE)

# GauXC transitively fetches its own libxc/ExchCXX/IntegratorXX, some of
# which predate CMake 3.5's cmake_minimum_required() floor (same situation
# as libfort.cmake); newer CMake releases refuse to configure those at all
# otherwise. Only relaxes the check for projects that don't request a range
# of their own; doesn't change policy behavior for our own CMakeLists.txt.
if(NOT DEFINED CMAKE_POLICY_VERSION_MINIMUM)
    set(CMAKE_POLICY_VERSION_MINIMUM 3.5)
endif()

FetchContent_Declare(
    gauxc
    GIT_REPOSITORY https://github.com/wavefunction91/GauXC
    GIT_TAG        71008cffd5d13d5ee813fb13d14d8bf7b06b8f6e
)

# Drive MakeAvailable here (instead of letting get_dependencies batch it) so we
# can build the subproject with tests off without leaving the parent project's
# BUILD_TESTING clobbered. Opt out of the batched call via _gd_uses_fc below.
set(_gd_bt_backup "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(gauxc)
set(BUILD_TESTING "${_gd_bt_backup}" CACHE BOOL "" FORCE)
unset(_gd_bt_backup)

set(_gd_target_gauxc "gauxc::gauxc")
set(_gd_uses_fc FALSE)
