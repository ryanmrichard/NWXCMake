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

# Boost is found via the system (CMake config package from Boost >= 1.70).
# CMP0167 NEW: use BoostConfig.cmake directly, suppressing the legacy
# FindBoost deprecation warning present in CMake >= 3.30.
# No include_guard: find_package is idempotent, and the _gd_uses_fc flag
# must be set every time this file is included so get_dependencies skips
# calling FetchContent_MakeAvailable for boost.
if(POLICY CMP0167)
    cmake_policy(SET CMP0167 NEW)
endif()
if(NOT Boost_FOUND)
    find_package(Boost REQUIRED)
endif()

# Boost::boost is the header-only umbrella target; individual component
# targets (e.g. Boost::filesystem) can be added by the caller as needed.
list(APPEND _gd_targets Boost::boost)
set(_gd_target_boost "Boost::boost")

# Boost is found via find_package, not FetchContent; opt out of the
# FetchContent_MakeAvailable call in get_dependencies.
set(_gd_uses_fc FALSE)
