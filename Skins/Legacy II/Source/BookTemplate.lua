----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BookTemplate = {}

BookTemplate.OpenBooks = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function BookTemplate.Initialize()
	local bookId = WindowData.Book.ObjectId
	local bookWindowName = SystemData.ActiveWindow.name
	
 	BookTemplate.OpenBooks[bookId] = {}
	BookTemplate.OpenBooks[bookId]["pageNums"] = {0,1}
	BookTemplate.OpenBooks[bookId].canEdit = WindowData.Book.CanEdit
	BookTemplate.OpenBooks[bookId].numPages = WindowData.Book.NumPages
	BookTemplate.OpenBooks[bookId].author = WindowData.Book.Author
	BookTemplate.OpenBooks[bookId].title = WindowData.Book.Title

	WindowRegisterEventHandler(bookWindowName, SystemData.Events.BOOK_PAGE_DATA_RECIEVED, "BookTemplate.UpdatePageText")
	Interface.DestroyWindowOnClose[bookWindowName] = true
    WindowSetId (bookWindowName, WindowData.Book.ObjectId)

    WindowUtils.SetWindowTitle(bookWindowName, WindowData.Book.Title)

    local titlePageWindowName = bookWindowName.."TitlePage"
    CreateWindowFromTemplate( titlePageWindowName, "TitlePageTemplate", bookWindowName )
	WindowAddAnchor( titlePageWindowName, "center", bookWindowName.."Page1", "center", 0, 0)

	if (WindowData.Book.CanEdit) then
		WindowSetShowing(titlePageWindowName.."Title", false)
		TextEditBoxSetText(titlePageWindowName.."EditTitle", WindowData.Book.Title)
		WindowAssignFocus(titlePageWindowName.."EditTitle",true)
		
		WindowSetShowing(bookWindowName.."Page1Text", false)
		WindowSetShowing(bookWindowName.."Page2Text", false)
	else
		WindowSetShowing(titlePageWindowName.."EditTitle", false)
		LabelSetText(titlePageWindowName.."Title", WindowData.Book.Title)
		
		WindowSetShowing(bookWindowName.."Page1EditText", false)
		WindowSetShowing(bookWindowName.."Page2EditText", false)
	end

	LabelSetText(titlePageWindowName.."Author", L"by: "..BookTemplate.OpenBooks[bookId].author)
	LabelSetText(bookWindowName.."Page2Number", L"1")

	WindowSetShowing(bookWindowName.."PageDownButton", false)
	WindowSetShowing(bookWindowName.."PageUpButton", false)

    if (BookTemplate.OpenBooks[bookId].numPages > 1) then
        WindowSetShowing(bookWindowName.."PageUpButton", true)
    end

    GumpManagerRequestBookPages(bookId, {1})
end

function BookTemplate.Shutdown()
    local bookId = WindowGetId(SystemData.ActiveWindow.name)
    
    if( BookTemplate.OpenBooks[bookId].canEdit ) then
        BookTemplate.StoreText()
    end
    
    BookTemplate.OpenBooks[bookId] = nil
end

function BookTemplate.PageUp()
    local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    local requestPages = {}

    WindowSetShowing(bookWindowName.."PageUpButton", false)

	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 <= BookTemplate.OpenBooks[bookId].numPages) then

		-- If previously at title page, show PageDownButton
	    if (BookTemplate.OpenBooks[bookId]["pageNums"][1] == 0) then
	        BookTemplate.EnterTitle()
			WindowSetShowing(bookWindowName.."PageDownButton", true)
    	end

    	-- If left page is last page
    	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 == BookTemplate.OpenBooks[bookId].numPages) then
    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
    	    
    	-- If both right and left pages contain text
    	else
    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
    	    requestPages[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] + 2
		end
		
		if (BookTemplate.OpenBooks[bookId].canEdit) then
      		BookTemplate.StoreText()
    	end

        BookTemplate.OpenBooks[bookId]["pageNums"][1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
        BookTemplate.OpenBooks[bookId]["pageNums"][2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] + 2

        -- If there are more pages
		if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 <= BookTemplate.OpenBooks[bookId].numPages) then
		    WindowSetShowing(bookWindowName.."PageUpButton", true)
		end

        BookTemplate.UpdatePageNumbers()
    	GumpManagerRequestBookPages(bookId, requestPages)
    end
end

function BookTemplate.PageDown()
    local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    local requestPages = {}

	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2 >= 0) then

		-- If going to title page, hide PageDownButton
	    if (BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2 == 0) then
			WindowSetShowing(bookWindowName.."PageDownButton", false)

    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2

    	-- If both right and left pages contain text
    	else
			requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2
    	    requestPages[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2
		end
		
  		if (BookTemplate.OpenBooks[bookId].canEdit) then
      		BookTemplate.StoreText()
    	end

        BookTemplate.OpenBooks[bookId]["pageNums"][1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2
        BookTemplate.OpenBooks[bookId]["pageNums"][2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2

        -- If there are more pages
		if (BookTemplate.OpenBooks[bookId]["pageNums"][2] <= BookTemplate.OpenBooks[bookId].numPages) then
		    WindowSetShowing(bookWindowName.."PageUpButton", true)
		end

        BookTemplate.UpdatePageNumbers()
    	GumpManagerRequestBookPages(bookId, requestPages)
    end
end

function BookTemplate.UpdatePageText()
    local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local updateId = WindowData.Book.ObjectId
    local page1Set = false
    local page2Set = false

    if( bookId == updateId and BookTemplate.OpenBooks[bookId] ~= nil ) then
        for index,pageNum in ipairs(WindowData.Book.PageNums) do
            if( BookTemplate.OpenBooks[bookId]["pageNums"][1] ~= nil and BookTemplate.OpenBooks[bookId]["pageNums"][1] == pageNum ) then
                if (BookTemplate.OpenBooks[bookId].canEdit) then
                    TextEditBoxSetText(bookWindowName.."Page1EditText", WindowData.Book.Pages[index])
				else
					LabelSetText(bookWindowName.."Page1Text", WindowData.Book.Pages[index])
				end
                page1Set = true
            elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1] ~= nil and BookTemplate.OpenBooks[bookId]["pageNums"][2] == pageNum ) then
                if (BookTemplate.OpenBooks[bookId].canEdit) then
                    TextEditBoxSetText(bookWindowName.."Page2EditText", WindowData.Book.Pages[index])
				else
					LabelSetText(bookWindowName.."Page2Text", WindowData.Book.Pages[index])
				end
                page2Set = true
            end
        end

        if (BookTemplate.OpenBooks[bookId]["pageNums"][1]  == 0) then
        
            LabelSetText(bookWindowName.."Page1Text", L"")
            local titlePageWindowName = bookWindowName.."TitlePage"
            WindowSetShowing(titlePageWindowName, true)

            if (BookTemplate.OpenBooks[bookId].canEdit) then
				TextEditBoxSetText(titlePageWindowName.."EditTitle", BookTemplate.OpenBooks[bookId].title)
				WindowAssignFocus(titlePageWindowName.."EditTitle",true)
			end

        elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1] == BookTemplate.OpenBooks[bookId].numPages) then
            LabelSetText(bookWindowName.."Page2Text", L"")
        elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1]  ~= 0) then
            WindowSetShowing(bookWindowName.."TitlePage", false)
        end

    end
end

function BookTemplate.UpdatePageNumbers()
	local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    
	if (BookTemplate.OpenBooks[bookId]["pageNums"][1]) then
		if (BookTemplate.OpenBooks[bookId]["pageNums"][1] == 0) then
			LabelSetText(bookWindowName.."Page1Number", L"")	
		else
			LabelSetText(bookWindowName.."Page1Number", StringToWString(tostring(BookTemplate.OpenBooks[bookId]["pageNums"][1])))
		end
	end
	if (BookTemplate.OpenBooks[bookId]["pageNums"][2]) then
		LabelSetText(bookWindowName.."Page2Number", StringToWString(tostring(BookTemplate.OpenBooks[bookId]["pageNums"][2])))
	end
end

function BookTemplate.EnterTitle()
	local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local bookTitleEditBoxName = bookWindowName.."TitlePageEditTitle"
    
    BookTemplate.OpenBooks[bookId].title = TextEditBoxGetText(bookTitleEditBoxName)

    if (BookTemplate.OpenBooks[bookId].title) then
    	WindowAssignFocus(bookWindowName.."TitlePageEditTitle",false)
		GumpManagerSendAuthorTitle(bookId, BookTemplate.OpenBooks[bookId].title, BookTemplate.OpenBooks[bookId].author)
		WindowUtils.SetWindowTitle(bookWindowName, BookTemplate.OpenBooks[bookId].title)
	end
end

function BookTemplate.StoreText()
    local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local page1Text = TextEditBoxGetText(bookWindowName.."Page1EditText")
	local page2Text = TextEditBoxGetText(bookWindowName.."Page2EditText")

    pageText = {}
    pageNums = {}
    if( BookTemplate.OpenBooks[bookId]["pageNums"][1]  == 0) then
        pageNums[1] = BookTemplate.OpenBooks[bookId]["pageNums"][2]
        pageText[1] = page2Text
        --Debug.Print("Page "..tostring(pageNums[1])..", "..tostring(pageText[1]))
    else
        pageNums[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1]
        pageNums[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2]
        pageText[1] = page1Text
        pageText[2] = page2Text
        --Debug.Print("Page "..tostring(pageNums[1])..", "..tostring(pageText[1]))
        --Debug.Print("Page "..tostring(pageNums[2])..", "..tostring(pageText[2]))
    end
    
	GumpManagerSendBookPages(bookId, pageNums, pageText )
end