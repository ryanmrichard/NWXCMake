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
include(CTest)

#[[[
# Registers a CTest test that runs a Python test driver with the freshly built
# pybind11 module on ``PYTHONPATH``.
#
# The driver is executed directly (``python <driver>``), matching the NWChemEx
# convention of ``unittest``-based runner scripts that discover and run their
# sibling test modules from within ``if __name__ == "__main__"``.
#
# No-op unless both ``BUILD_TESTING`` and ``BUILD_PYBIND11_BINDINGS`` are on.
# Assumes the module target ``${PROJECT_NAME}_python`` (as created by
# :cmake:command:`nwx_python_module`) exists.
#
# :param npt_test_name: Name to register the CTest test under.
# :type npt_test_name: desc
# :param npt_driver: Path to the Python driver script to run.
# :type npt_driver: path
#
# .. code-block:: cmake
#
#    include(nwx_python_test)
#    nwx_python_test(py_foo "${CMAKE_CURRENT_LIST_DIR}/tests/python/test_foo.py")
#]]
function(nwx_python_test npt_test_name npt_driver)
    if(NOT BUILD_TESTING OR NOT BUILD_PYBIND11_BINDINGS)
        return()
    endif()

    if(NOT Python_EXECUTABLE)
        find_package(Python REQUIRED COMPONENTS Interpreter)
    endif()

    add_test(
        NAME "${npt_test_name}"
        COMMAND "${Python_EXECUTABLE}" "${npt_driver}"
    )
    # Make the just-built extension importable by the driver.
    set_tests_properties("${npt_test_name}" PROPERTIES
        ENVIRONMENT
        "PYTHONPATH=$<TARGET_FILE_DIR:${PROJECT_NAME}_python>:$ENV{PYTHONPATH}"
    )
endfunction()
