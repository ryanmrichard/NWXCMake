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

# Libint2 builds a real (compiled) library from its own CMakeLists. Disable the
# parts we don't use before add_subdirectory. CACHE FORCE so our values win over
# the subproject's option() defaults (policy CMP0077).
set(ENABLE_FORTRAN OFF CACHE BOOL "" FORCE)
set(ENABLE_MPFR    OFF CACHE BOOL "" FORCE)
set(LIBINT2_PYTHON OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    libint2
    URL https://github.com/evaleev/libint/releases/download/v2.11.0/libint-2.11.0.tgz
)

# Drive MakeAvailable here (instead of letting get_dependencies batch it) so we
# can build with tests off without leaving the parent project's BUILD_TESTING
# clobbered. Opt out of the batched call via _gd_uses_fc below.
set(_gd_bt_backup "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(libint2)
set(BUILD_TESTING "${_gd_bt_backup}" CACHE BOOL "" FORCE)
unset(_gd_bt_backup)

# Libint2's config exports Libint2::int2 (C library) / Libint2::cxx (C++ API);
# consumers link the C++ API target.
set(_gd_target_libint2 "Libint2::int2")
set(_gd_uses_fc FALSE)
