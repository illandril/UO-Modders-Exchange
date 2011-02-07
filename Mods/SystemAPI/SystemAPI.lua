SystemAPI = {}
SystemAPI.version = {}
SystemAPI.version.a, SystemAPI.version.b, SystemAPI.version.c, SystemAPI.version.d = GetBuildVersion()
CreateUIDocumentFile( "UserInterface/System API/API "..SystemAPI.version.a.."-"..SystemAPI.version.b.."-"..SystemAPI.version.c.."-"..SystemAPI.version.d..".txt" )
CreateUIDocumentFile( "UserInterface/System API/API_Latest.txt" )
