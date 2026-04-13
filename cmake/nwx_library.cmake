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

function(nwx_library nl_project_name nl_inc_dir nl_src_dir)
    file(GLOB_RECURSE __nl_header_files CONFIGURE_DEPENDS ${nl_inc_dir}/*.hpp)
    file(GLOB_RECURSE __nl_source_files CONFIGURE_DEPENDS ${nl_src_dir}/*.cpp)
    list(FILTER __nl_source_files EXCLUDE REGEX ".*/export_.*\\.cpp$")
    add_library(${nl_project_name} ${__nl_source_files})
    target_link_libraries(${nl_project_name} ${ARGN})
    target_include_directories(${nl_project_name}
        PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${nl_inc_dir}>
            $<INSTALL_INTERFACE:include>
    )
    set_target_properties(
        ${nl_project_name} PROPERTIES POSITION_INDEPENDENT_CODE ON
    )

    include(install_target)
    install_library(
        ${nl_project_name}
        "${CMAKE_CURRENT_SOURCE_DIR}/${nl_inc_dir}"
    )
endfunction()
