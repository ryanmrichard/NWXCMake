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
    if(SKBUILD)
        include(dependencies/skbuild_python)
    endif()
    foreach(depend_i ${ARGN})
        message(STATUS "Fetching dependency: ${depend_i}")
        include(dependencies/${depend_i})
    endforeach()

    FetchContent_MakeAvailable(${ARGN})
    set(GET_DEPENDENCIES_TARGETS "${_gd_targets}" PARENT_SCOPE)
endfunction()
