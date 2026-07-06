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

FetchContent_Declare(
    gau2grid
    GIT_REPOSITORY https://github.com/psi4/gau2grid
    GIT_TAG        master
)

# Drive MakeAvailable here (instead of letting get_dependencies batch it) so we
# can build with tests off without leaving the parent project's BUILD_TESTING
# clobbered. Opt out of the batched call via _gd_uses_fc below.
set(_gd_bt_backup "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(gau2grid)
set(BUILD_TESTING "${_gd_bt_backup}" CACHE BOOL "" FORCE)
unset(_gd_bt_backup)

# gau2grid exports the plain target "gg".
set(_gd_target_gau2grid "gg")
set(_gd_uses_fc FALSE)
