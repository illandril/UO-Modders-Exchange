BookRecorder = {}

BookRecorder.TempBooks = {}
BookRecorder.LOG = "Book"
BookRecorder.LOG_LOCATION = "logs/"
BookRecorder.WINDOWNAME = "Root" --TODO - adjust this some? Make an actual BookRecorder window that people can drop books into/target books with?

function BookRecorder.Initialize()
    WindowRegisterEventHandler( BookRecorder.WINDOWNAME, SystemData.Events.BOOK_PAGE_DATA_RECIEVED, "BookRecorder.GotPageText")
    BookRecorder.BookTemplateInitialize = BookTemplate.Initialize
    BookTemplate.Initialize = BookRecorder.BookOpen
end

BookRecorder.LogsInitialized = false
function BookRecorder.InitLogs()
    if not BookRecorder.LogsInitialized then
        local num = CustomSettings.LoadNumberValue( { settingName="bookLogID", defaultValue=1 } )
        BookRecorder.LOG_LOCATION = BookRecorder.LOG_LOCATION.."book"..num..".txt"
        CustomSettings.SaveNumberValue( { settingName="bookLogID", settingValue=num+1 } )
        CustomSettings.SaveChanges()
        TextLogCreate( BookRecorder.LOG, 10 )
        TextLogSetEnabled( BookRecorder.LOG, true )
        TextLogLoadFromFile( BookRecorder.LOG, BookRecorder.LOG_LOCATION )
        TextLogSetIncrementalSaving( BookRecorder.LOG, true, BookRecorder.LOG_LOCATION )
        TextLogAddFilterType( BookRecorder.LOG, 1, L"\n#######################################################\n#######################################################\n" )
        BookRecorder.LogsInitialized = true
    end
end

function BookRecorder.BookOpen()
    BookRecorder.BookTemplateInitialize()
    BookRecorder.InitLogs()
	local bookId = WindowData.Book.ObjectId
    BookRecorder.TempBooks[bookId] = {}
    BookRecorder.TempBooks[bookId].author = WindowData.Book.Author
    BookRecorder.TempBooks[bookId].title = WindowData.Book.Title
    BookRecorder.TempBooks[bookId].pages = WindowData.Book.NumPages
    BookRecorder.TempBooks[bookId].text = {}

    local requestPages = {}
    
    for i=1,BookRecorder.TempBooks[bookId].pages do
        requestPages[i]=i
        BookRecorder.TempBooks[bookId].text[i] = 0
    end
    GumpManagerRequestBookPages( bookId, requestPages )
end

function BookRecorder.GotPageText()
    local bookId = WindowData.Book.ObjectId

    if BookRecorder.TempBooks[bookId] ~= nil then
        for index,pageNum in ipairs(WindowData.Book.PageNums) do
            BookRecorder.TempBooks[bookId].text[pageNum] = WindowData.Book.Pages[index]
        end
        local complete = true
        local booktext = L""
        for index,text in ipairs(BookRecorder.TempBooks[bookId].text) do
            if( text == 0 ) then
                complete = false
            else
                booktext = booktext .. text
            end
        end
        if( complete ) then
            TextLogAddEntry( BookRecorder.LOG, 1, BookRecorder.TempBooks[bookId].title .. L"\n  by " .. BookRecorder.TempBooks[bookId].author .. L"\n-------------------------\n" .. booktext .. L"\n\n" )
            TextLogSaveLog( BookRecorder.LOG, BookRecorder.LOG_LOCATION )
            BookRecorder.TempBooks[bookId] = nil
        end
    end
end
