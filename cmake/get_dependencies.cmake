# Copyright 2025 NWChemEx-Project
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

function(get_dependencies)
    set(_gd_targets)
    set(_gd_fc_names)
    if(SKBUILD)
        include(dependencies/skbuild_python)
    endif()
    foreach(depend_i ${ARGN})
        message(STATUS "Fetching dependency: ${depend_i}")
        set(_gd_uses_fc TRUE)
        include(dependencies/${depend_i})
        if(_gd_uses_fc)
            list(APPEND _gd_fc_names ${depend_i})
        endif()
        # Publish the dep-name → CMake-target mapping as a CACHE INTERNAL so
        # nwx_library (and any other NWXCMake helper) can resolve short names
        # to real targets without the caller having to know the target name.
        # Dep files set _gd_target_<name> to override; ecosystem deps (utilities,
        # parallelzone, …) default to the dep name itself as the target.
        if(DEFINED _gd_target_${depend_i})
            set(NWX_DEP_TARGET_${depend_i} "${_gd_target_${depend_i}}"
                CACHE INTERNAL "CMake target for NWX dep '${depend_i}'")
        elseif(NOT DEFINED CACHE{NWX_DEP_TARGET_${depend_i}})
            set(NWX_DEP_TARGET_${depend_i} "${depend_i}"
                CACHE INTERNAL "CMake target for NWX dep '${depend_i}'")
        endif()
    endforeach()

    if(_gd_fc_names)
        FetchContent_MakeAvailable(${_gd_fc_names})
    endif()
    set(GET_DEPENDENCIES_TARGETS "${_gd_targets}" PARENT_SCOPE)
endfunction()
