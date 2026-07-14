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

# "nwchemex" is not a single fetchable repository (the NWChemEx meta-package
# has no CMakeLists.txt); it's an aggregator INTERFACE target linking
# whatever get_dependencies(integrals chemcache nux) resolves to.
set(_gd_uses_fc FALSE)

get_dependencies(integrals chemcache nux)

if(NOT TARGET nwchemex)
    add_library(nwchemex INTERFACE)
    target_link_libraries(nwchemex INTERFACE ${GET_DEPENDENCIES_TARGETS})
endif()

list(APPEND _gd_targets nwchemex)
