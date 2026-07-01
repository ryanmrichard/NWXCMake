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

set(FORT_ENABLE_TESTING OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    libfort
    GIT_REPOSITORY https://github.com/seleznevae/libfort
    GIT_TAG        v0.4.2
)

list(APPEND _gd_targets fort)
