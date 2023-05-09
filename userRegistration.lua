-----------------------------------------------------------------------------------------
--practice
--userRegistration.lua
--Tony Chen
--2016/10/19
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local widget = require( "widget" )
local composer = require("composer")
local scene = composer.newScene( )
--=======================================================================================
--宣告全域變數
--=======================================================================================

--=======================================================================================
--宣告區域變數
--=======================================================================================
local bg
local backButton
local title
local rect1
local rect2
local rect3
local text1
local text2
local text3
local nextButton1
local nextButton2
local tmr

-- textField
local firstBoardTextField = {}
local secendBoardTextField = {}

-- textField
local firstBoardTextField_bg = {}
local secendBoardTextField_bg = {}

local textFieldBg_r = 211
local textFieldBg_g = 211
local textFieldBg_b = 211
local textFieldSize = 80
local floorTextFontSize = 30.5
local rect_y = _SCREEN.HEIGHT * 0.18
local rectWidth = _SCREEN.WIDTH * 0.38
local rectHeight = _SCREEN.HEIGHT * 0.1
local floorText_y = _SCREEN.HEIGHT * 0.97
local btn_width =  _SCREEN.WIDTH * 0.7
local btn_height = _SCREEN.WIDTH * 0.7 * (60/279)
local textFieldWidth = _SCREEN.WIDTH * 0.75
local textFieldHeight = _SCREEN.HEIGHT * 0.08
local firstBoardTextField_x = _SCREEN.CENTER.X
local firstBoardTextField1_y = _SCREEN.HEIGHT * 0.33
local firstBoardTextField2_y = _SCREEN.HEIGHT * 0.44
local firstBoardTextField3_y = _SCREEN.HEIGHT * 0.55
local firstBoardTextField4_y = _SCREEN.HEIGHT * 0.66
local secendBoardTextField_x = _SCREEN.CENTER.X
local secendBoardTextField1_y = _SCREEN.HEIGHT * 0.33
local secendBoardTextField2_y = _SCREEN.HEIGHT * 0.44
local secendBoardTextField3_y = _SCREEN.HEIGHT * 0.55

--function
local initial
local makeTextField
local removeTextField
local nextButton1_onRelease
local nextButton2_onRelease
local checkTextField
local removeSpace

--group
local firstGroup = display.newGroup( )
local secendGroup = display.newGroup( )
local firstBoardGroup = display.newGroup( )
local secendBoardGroup = display.newGroup( )
local topGroup = display.newGroup( )
--=======================================================================================
--定義各種函式
--=======================================================================================
initial = function ( userRegistrationGroup )
	--背景
	bg = display.newRect( 0, 0, 0, 0 )
	bg.x = _SCREEN.CENTER.X
	bg.y = _SCREEN.CENTER.Y
	bg.width = _SCREEN.WIDTH
	bg.height = _SCREEN.HEIGHT
	bg:setFillColor( 1, 1, 1 )

	title = display.newImageRect( "Images/Title.png", 0, 0 )
	title.anchorX = 0
	title.anchorY = 0
	title.x = 0
	title.y = 0
	title.width = _SCREEN.WIDTH
	title.height = _SCREEN.WIDTH * 33/372

	--標籤底色
	rect1 = display.newRect( 0, 0, 0, 0 )
	rect1.width = rectWidth
	rect1.height = rectHeight
	rect1:setFillColor( 211/255, 211/255, 211/255 )

	rect2 = display.newRect( 0, 0, 0, 0 )
	rect2.width = rectWidth
	rect2.height = rectHeight
	rect2:setFillColor( 211/255, 211/255, 211/255 )

	--標籤文字
	text1 = display.newText( "步驟一", 0, 0, native.systemFont , FONTSIZE )
	text1:setFillColor( 0, 0, 0 )

	text2 = display.newText( "步驟二", 0, 0, native.systemFont , FONTSIZE )
	text2:setFillColor( 0, 0, 0 )

	backButton = widget.newButton(
		{
			x = title.height,
			y = title.height / 2,
			width = title.height * 2,
			height = title.height,
			label = "返回",
			fontSize = 40,
			labelColor = { default = { 1, 1, 1 }, over = { 1, 1, 1, 0.5 } },
			onRelease = backButtonOnRelease
		}
	)

	--=======================================================================================
	--第一部分版面
	firstBoardTextField_bg[1] = display.newRect( 0, 0, 0, 0 )
	firstBoardTextField_bg[1].x = _SCREEN.CENTER.X
	firstBoardTextField_bg[1].y = firstBoardTextField1_y
	firstBoardTextField_bg[1].width = textFieldWidth
	firstBoardTextField_bg[1].height = textFieldHeight
	firstBoardTextField_bg[1]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	firstBoardTextField_bg[2] = display.newRect( 0, 0, 0, 0 )
	firstBoardTextField_bg[2].x = _SCREEN.CENTER.X
	firstBoardTextField_bg[2].y = firstBoardTextField2_y
	firstBoardTextField_bg[2].width = textFieldWidth
	firstBoardTextField_bg[2].height = textFieldHeight
	firstBoardTextField_bg[2]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	firstBoardTextField_bg[3] = display.newRect( 0, 0, 0, 0 )
	firstBoardTextField_bg[3].x = _SCREEN.CENTER.X
	firstBoardTextField_bg[3].y = firstBoardTextField3_y
	firstBoardTextField_bg[3].width = textFieldWidth
	firstBoardTextField_bg[3].height = textFieldHeight
	firstBoardTextField_bg[3]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	firstBoardTextField_bg[4] = display.newRect( 0, 0, 0, 0 )
	firstBoardTextField_bg[4].x = _SCREEN.CENTER.X
	firstBoardTextField_bg[4].y = firstBoardTextField4_y
	firstBoardTextField_bg[4].width = textFieldWidth
	firstBoardTextField_bg[4].height = textFieldHeight
	firstBoardTextField_bg[4]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	nextButton1 = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.85,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Next.png",
			overFile = "Images/Next2.png",
			onRelease = nextButton1_onRelease
		}
	)
	nextButton1.alpha = 0.5
	nextButton1:setEnabled( false )

	firstBoardGroup:insert( firstBoardTextField_bg[1] )
	firstBoardGroup:insert( firstBoardTextField_bg[2] )
	firstBoardGroup:insert( firstBoardTextField_bg[3] )
	firstBoardGroup:insert( firstBoardTextField_bg[4] )
	firstBoardGroup:insert( nextButton1 )

	--=======================================================================================
	--第二部分版面
	secendBoardTextField_bg[1] = display.newRect( 0, 0, 0, 0 )
	secendBoardTextField_bg[1].x = _SCREEN.CENTER.X
	secendBoardTextField_bg[1].y = secendBoardTextField1_y
	secendBoardTextField_bg[1].width = textFieldWidth
	secendBoardTextField_bg[1].height = textFieldHeight
	secendBoardTextField_bg[1]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	secendBoardTextField_bg[2] = display.newRect( 0, 0, 0, 0 )
	secendBoardTextField_bg[2].x = _SCREEN.CENTER.X
	secendBoardTextField_bg[2].y = secendBoardTextField2_y
	secendBoardTextField_bg[2].width = textFieldWidth
	secendBoardTextField_bg[2].height = textFieldHeight
	secendBoardTextField_bg[2]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	secendBoardTextField_bg[3] = display.newRect( 0, 0, 0, 0 )
	secendBoardTextField_bg[3].x = _SCREEN.CENTER.X
	secendBoardTextField_bg[3].y = secendBoardTextField3_y
	secendBoardTextField_bg[3].width = textFieldWidth
	secendBoardTextField_bg[3].height = textFieldHeight
	secendBoardTextField_bg[3]:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	nextButton2 = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.85,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Next.png",
			overFile = "Images/Next2.png",
			onRelease = nextButton2_onRelease
		}
	)
	nextButton2.alpha = 0.5
	nextButton2:setEnabled( false )

	secendBoardGroup:insert( secendBoardTextField_bg[1] )
	secendBoardGroup:insert( secendBoardTextField_bg[2] )
	secendBoardGroup:insert( secendBoardTextField_bg[3] )
	secendBoardGroup:insert( nextButton2 )

	--=======================================================================================

	topGroup:insert( title )
	topGroup:insert( backButton )

	userRegistrationGroup:insert( bg )
	userRegistrationGroup:insert( topGroup )
	userRegistrationGroup:insert( firstGroup )
	userRegistrationGroup:insert( secendGroup )
	userRegistrationGroup:insert( firstBoardGroup )
	userRegistrationGroup:insert( secendBoardGroup )

	topGroup.y = _SCREEN.HEIGHT * 0.03

	firstGroup:insert( rect1 )
	firstGroup:insert( text1 )
	firstGroup.x = _SCREEN.WIDTH * 0.3
	firstGroup.y = rect_y

	secendGroup:insert( rect2 )
	secendGroup:insert( text2 )
	secendGroup.x = _SCREEN.WIDTH * 0.7
	secendGroup.y = rect_y
	secendGroup.alpha = 0.3

	secendBoardGroup.x = _SCREEN.WIDTH * 1
end

makeTextField = function (  )
	--第一版
	firstBoardTextField[1] = native.newTextField( _SCREEN.CENTER.X, firstBoardTextField1_y, textFieldWidth, textFieldHeight )
	firstBoardTextField[1].hasBackground = false
	firstBoardTextField[1].size = textFieldSize
	firstBoardTextField[1].placeholder = "帳號"

	firstBoardTextField[2] = native.newTextField( _SCREEN.CENTER.X, firstBoardTextField2_y, textFieldWidth, textFieldHeight )
	firstBoardTextField[2].hasBackground = false
	firstBoardTextField[2].size = textFieldSize
	firstBoardTextField[2].isSecure = true
	firstBoardTextField[2].placeholder = "密碼"

	firstBoardTextField[3] = native.newTextField( _SCREEN.CENTER.X, firstBoardTextField3_y, textFieldWidth, textFieldHeight )
	firstBoardTextField[3].hasBackground = false
	firstBoardTextField[3].size = textFieldSize
	firstBoardTextField[3].isSecure = true
	firstBoardTextField[3].placeholder = "密碼確認"

	firstBoardTextField[4] = native.newTextField( _SCREEN.CENTER.X, firstBoardTextField4_y, textFieldWidth, textFieldHeight )
	firstBoardTextField[4].hasBackground = false
	firstBoardTextField[4].size = textFieldSize
	firstBoardTextField[4].placeholder = "Email"

	firstBoardGroup:insert( firstBoardTextField[1] )
	firstBoardGroup:insert( firstBoardTextField[2] )
	firstBoardGroup:insert( firstBoardTextField[3] )
	firstBoardGroup:insert( firstBoardTextField[4] )

	--第二版
	secendBoardTextField[1] = native.newTextField( _SCREEN.CENTER.X, secendBoardTextField1_y, textFieldWidth, textFieldHeight )
	secendBoardTextField[1].hasBackground = false
	secendBoardTextField[1].size = textFieldSize
	secendBoardTextField[1].placeholder = "姓名"

	secendBoardTextField[2] = native.newTextField( _SCREEN.CENTER.X, secendBoardTextField2_y, textFieldWidth, textFieldHeight )
	secendBoardTextField[2].hasBackground = false
	secendBoardTextField[2].size = textFieldSize
	secendBoardTextField[2].placeholder = "聯絡電話"

	secendBoardTextField[3] = native.newTextField( _SCREEN.CENTER.X, secendBoardTextField3_y, textFieldWidth, textFieldHeight )
	secendBoardTextField[3].hasBackground = false
	secendBoardTextField[3].size = textFieldSize
	secendBoardTextField[3].placeholder = "地址"

	secendBoardGroup:insert( secendBoardTextField[1] )
	secendBoardGroup:insert( secendBoardTextField[2] )
	secendBoardGroup:insert( secendBoardTextField[3] )

	print( "make text field" )
end

removeTextField = function (  )
	firstBoardTextField[1]:removeSelf( )
	firstBoardTextField[2]:removeSelf( )
	firstBoardTextField[3]:removeSelf( )
	firstBoardTextField[4]:removeSelf( )
	secendBoardTextField[1]:removeSelf( )
	secendBoardTextField[2]:removeSelf( )
	secendBoardTextField[3]:removeSelf( )

	print( "remove text field" )
end

nextButton1_onRelease = function (  )
	transition.to( firstBoardGroup , { time = 500, x = _SCREEN.WIDTH * -1, transition = easing.inOutQuad } )
	transition.to( secendBoardGroup, { time = 500, x = 0, transition = easing.inOutQuad } )

	firstGroup.alpha = 0.3
	secendGroup.alpha = 1
end

nextButton2_onRelease = function (  )
	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "applyBarcode" , options )
end

backButtonOnRelease = function (  )
	local options = { effect = "slideRight", time = 500 }
	composer.gotoScene( "userLogin" , options )
end

removeSpace = function (  )

	local str1_1 = string.gsub( firstBoardTextField[1].text, "%s+",  "" )
	firstBoardTextField[1].text = str1_1
	local str1_2 = string.gsub( firstBoardTextField[2].text, "%s+",  "" )
	firstBoardTextField[2].text = str1_2
	local str1_3 = string.gsub( firstBoardTextField[3].text, "%s+",  "" )
	firstBoardTextField[3].text = str1_3
	local str1_4 = string.gsub( firstBoardTextField[4].text, "%s+",  "" )
	firstBoardTextField[4].text = str1_4
	local str2_1 = string.gsub( secendBoardTextField[1].text, "%s+",  "" )
	secendBoardTextField[1].text = str2_1
	local str2_2 = string.gsub( secendBoardTextField[2].text, "%s+",  "" )
	secendBoardTextField[2].text = str2_2
	local str2_3 = string.gsub( secendBoardTextField[3].text, "%s+",  "" )
	secendBoardTextField[3].text = str2_3

	local str3_1 = string.gsub( firstBoardTextField[1].text, "%p+",  "" )
	firstBoardTextField[1].text = str3_1
	local str3_2 = string.gsub( firstBoardTextField[2].text, "%p+",  "" )
	firstBoardTextField[2].text = str3_2
	local str3_3 = string.gsub( firstBoardTextField[3].text, "%p+",  "" )
	firstBoardTextField[3].text = str3_3
	local str3_4 = string.gsub( firstBoardTextField[4].text, "%p+",  "" )
	firstBoardTextField[4].text = str3_4
	local str4_1 = string.gsub( secendBoardTextField[1].text, "%p+",  "" )
	secendBoardTextField[1].text = str4_1
	local str4_2 = string.gsub( secendBoardTextField[2].text, "%p+",  "" )
	secendBoardTextField[2].text = str4_2
	local str4_3 = string.gsub( secendBoardTextField[3].text, "%p+",  "" )
	secendBoardTextField[3].text = str4_3
end

checkTextField = function (  )
	tmr = timer.performWithDelay( 100, function (  )
		removeSpace()
		--第一部分版面
		if firstBoardTextField[1].text == "" then
			if firstBoardTextField[2].text == "" then
				if firstBoardTextField[3].text == "" then
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				else
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				end
			else
				if firstBoardTextField[3].text == "" then
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				else
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				end
			end
		else
			if firstBoardTextField[2].text == "" then
				if firstBoardTextField[3].text == "" then
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				else
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				end
			else
				if firstBoardTextField[3].text == "" then
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					end
				else
					if firstBoardTextField[4].text == "" then
						nextButton1.alpha = 0.5
						nextButton1:setEnabled( false )
					else
						nextButton1.alpha = 1
						nextButton1:setEnabled( true )
					end
				end
			end
		end

		--第二部分版面
		if secendBoardTextField[1].text == "" then
			if secendBoardTextField[2].text == "" then
				if secendBoardTextField[3].text == "" then
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				else
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				end
			else
				if secendBoardTextField[3].text == "" then
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				else
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				end
			end
		else
			if secendBoardTextField[2].text == "" then
				if secendBoardTextField[3].text == "" then
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				else
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				end
			else
				if secendBoardTextField[3].text == "" then
					nextButton2.alpha = 0.5
					nextButton2:setEnabled( false )
				else
					nextButton2.alpha = 1
					nextButton2:setEnabled( true )
				end
			end
		end
	end, -1 )
end

--=======================================================================================
--Composer
--=======================================================================================

--畫面沒到螢幕上時，先呼叫scene:create
--任務:負責UI畫面繪製
function scene:create(event)
	--把場景的view存在sceneGroup這個變數裡
	local sceneGroup = self.view

	--接下來把會出現在畫面的東西，加進sceneGroup裡面

	initial(sceneGroup)
end


--畫面到螢幕上時，呼叫scene:show
--任務:移除前一個場景，播放音效，開始計時，播放各種動畫
function  scene:show( event)
	local sceneGroup = self.view
	local phase = event.phase

	if( "will" == phase ) then
		--畫面即將要推上螢幕時要執行的程式碼寫在這邊
		makeTextField()

		firstBoardGroup.x = 0
		secendBoardGroup.x = _SCREEN.WIDTH * 1
		firstGroup.alpha = 1
		secendGroup.alpha = 0.3
	elseif ( "did" == phase ) then
		--把畫面已經被推上螢幕後要執行的程式碼寫在這邊
		--可能是移除之前的場景，播放音效，開始計時，播放各種動畫
		checkTextField()
	end
end


--即將被移除，呼叫scene:hide
--任務:停止音樂，釋放音樂記憶體，停止移動的物體等
function scene:hide( event )
	
	local sceneGroup = self.view
	local phase = event.phase

	if ( "will" == phase ) then
		--畫面即將移開螢幕時，要執行的程式碼
		--這邊需要停止音樂，釋放音樂記憶體，有timer的計時器也可以在此停止
		removeTextField()
		timer.cancel( tmr )
		tmr = nil

	elseif ( "did" == phase ) then
		--畫面已經移開螢幕時，要執行的程式碼

	end
end

--下一個場景畫面推上螢幕後
--任務:摧毀場景
function scene:destroy( event )
	if ("will" == event.phase) then
		--這邊寫下畫面要被消滅前要執行的程式碼

	end
end

--=======================================================================================
--加入偵聽器
--=======================================================================================

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene