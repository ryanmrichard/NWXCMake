include_guard()

macro(get_skbuild_python_path)
    find_package(Python REQUIRED COMPONENTS Interpreter)
    execute_process(
        COMMAND "${Python_EXECUTABLE}" -c "import sys; print(sys.prefix)"
        OUTPUT_VARIABLE _tp_py_prefix
        OUTPUT_STRIP_TRAILING_WHITESPACE
        RESULT_VARIABLE _tp_sys_prefix_rc
    )
    if(NOT _tp_sys_prefix_rc EQUAL 0)
        message(FATAL_ERROR "Could not query sys.prefix from Python")
    endif()
    set(CMAKE_PREFIX_PATH "${_tp_py_prefix};${CMAKE_PREFIX_PATH}")
endmacro()

get_skbuild_python_path()