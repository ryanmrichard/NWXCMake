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

#[[[
# Sets project-wide CMake defaults for all NWChemEx repositories.
#
# Include this module immediately after ``project()`` and
# ``disable_in_source_builds``.  All settings respect values already defined
# by the user or a parent project (e.g. ``-DCMAKE_CXX_STANDARD=17``).
#
# Variables set (if not already defined)
# ---------------------------------------
# - ``CMAKE_BUILD_TYPE``            — defaults to ``Release``, or ``Debug``
#   when ``DEVELOPER_SETUP`` is ``ON``
# - ``CMAKE_CXX_STANDARD``          — defaults to ``20``
# - ``CMAKE_CXX_STANDARD_REQUIRED`` — defaults to ``ON``
# - ``CMAKE_CXX_SCAN_FOR_MODULES``  — defaults to ``OFF``
#
# Options defined
# ---------------
# - ``BUILD_TESTING``           (default ``OFF``) — build unit tests
# - ``BUILD_PYBIND11_BINDINGS`` (default ``ON``)  — build Python bindings
# - ``INTEGRATION_TESTING``     (default ``OFF``) — build integration tests
# - ``DEVELOPER_SETUP``         (default ``OFF``) — wire up the shared
#   pre-commit hooks for local development (see nwx_setup_pre_commit)
#
# Example usage:
#
# .. code-block:: cmake
#
#    project(my_project LANGUAGES CXX)
#    include(disable_in_source_builds)
#    include(set_default_nwx_options)
#]]

option(BUILD_TESTING           "Whether to build the unit tests"        OFF)
option(BUILD_PYBIND11_BINDINGS "Build Python bindings via pybind11"     ON)
option(INTEGRATION_TESTING     "Should we build the integration tests?" OFF)
option(ENABLE_SIGMA            "Enable Sigma for uncertainty tracking"  OFF)
option(DEVELOPER_SETUP         "Wire up local dev tooling (pre-commit)" OFF)

if(NOT DEFINED CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    if(DEVELOPER_SETUP)
        set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
    else()
        set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
    endif()
endif()

if(NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 20)
endif()

if(NOT DEFINED CMAKE_CXX_STANDARD_REQUIRED)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

if(NOT DEFINED CMAKE_CXX_SCAN_FOR_MODULES)
    set(CMAKE_CXX_SCAN_FOR_MODULES OFF)
endif()

if(DEVELOPER_SETUP)
    include(nwx_setup_pre_commit)
    nwx_setup_pre_commit()
endif()
