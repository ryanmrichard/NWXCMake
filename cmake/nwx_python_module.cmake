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

function(nwx_python_module nwx_python_module_name nwx_python_src_dir)
    if(NOT BUILD_PYBIND11_BINDINGS)
        return()
    endif()

    include(get_dependencies)
    get_dependencies(pybind11)
    file(
        GLOB_RECURSE __nwx_python_module_source_files
        CONFIGURE_DEPENDS ${nwx_python_src_dir}/*.cpp
    )
    list(FILTER __nwx_python_module_source_files INCLUDE REGEX ".*/export_.*\\.cpp$")
    pybind11_add_module(
        ${nwx_python_module_name}_python ${__nwx_python_module_source_files}
    )
    target_link_libraries(${nwx_python_module_name}_python PRIVATE ${PROJECT_NAME})
    target_include_directories(${nwx_python_module_name}_python PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/cpp/include
    )
    set_target_properties(
        ${nwx_python_module_name}_python
        PROPERTIES OUTPUT_NAME ${nwx_python_module_name}
    )
    install(TARGETS ${nwx_python_module_name}
    DESTINATION $<IF:$<BOOL:${SKBUILD_PLATLIB_DIR}>,${SKBUILD_PLATLIB_DIR},lib>
    )
endfunction()
