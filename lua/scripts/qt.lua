function SetupQtProject()
    print 'Creating necessary files'
    local main_cpp = io.open('main.cpp', 'w')
    if main_cpp then
        main_cpp:write 'This is a file created from Lua!\n'
        main_cpp:close()
        print 'main.cpp created successfully'
    else
        print 'Error: could not create main.cpp'
    end
end
