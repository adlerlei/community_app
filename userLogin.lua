-----------------------------------------------------------------------------------------
--practice
--userLogin.lua
--TonyChen
--2016/10/18
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
local loginButton
local registeredButton
local backButton
local title
local rect1
local rect2
local text1
local text2
local text3
local text4
local line1
local line2
local switch
local textField1
local textField2
local tmr
local loginButtonOptions

local textFieldBg_r = 211
local textFieldBg_g = 211
local textFieldBg_b = 211
local textFontSize = 50
local btn_width =  _SCREEN.WIDTH * 0.7
local btn_height = _SCREEN.WIDTH * 0.7 * (60/279)
local text3_y = _SCREEN.HEIGHT * 0.8
local textField1_y = _SCREEN.CENTER.Y * 0.47
local textField2_y = _SCREEN.CENTER.Y * 0.67
local textFieldWidth = _SCREEN.WIDTH * 0.75
local textFieldHeight = _SCREEN.HEIGHT * 0.08

--function
local initial
local makeTextField
local removeTextField
local loginButtonOnRelease
local registeredButtonOnRelease
local backButtonOnRelease
local checkTextField
local removeSpace

--group
local textFieldGroup = display.newGroup( )
local topGroup = display.newGroup( )
--=======================================================================================
--定義各種函式
--=======================================================================================
initial = function ( userLoginGroup )
	--背景
	bg = display.newRect( 0, 0, 0, 0 )
	bg.x = _SCREEN.CENTER.X
	bg.y = _SCREEN.CENTER.Y
	bg.width = _SCREEN.WIDTH
	bg.height = _SCREEN.HEIGHT
	bg:setFillColor( 1, 1, 1 )

	--登入按鈕
		
	loginButton = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.6,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Login.png",
			overFile = "Images/Login2.png",
			onRelease = loginButtonOnRelease
		}
	)
	loginButton.alpha = 0.5
	loginButton:setEnabled( false )

	--註冊按鈕
	registeredButton = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.9,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Registered.png",
			overFile = "Images/Registered2.png",
			onRelease = registeredButtonOnRelease
		}
	)

	switch = widget.newSwitch(
		{
			x = _SCREEN.WIDTH * 0.35,
			y = _SCREEN.CENTER.Y,
			width = _SCREEN.WIDTH * 0.08,
			height = _SCREEN.WIDTH * 0.08,
			style = "checkbox"
		}
	)

	--文字匡背景色
	rect1 = display.newRect( 0, 0, 0, 0 )
	rect1.x = _SCREEN.CENTER.X
	rect1.y = textField1_y
	rect1.width = textFieldWidth
	rect1.height = textFieldHeight
	rect1:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	rect2 = display.newRect( 0, 0, 0, 0 )
	rect2.x = _SCREEN.CENTER.X
	rect2.y = textField2_y
	rect2.width = textFieldWidth
	rect2.height = textFieldHeight
	rect2:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	title = display.newImageRect( "Images/Title.png", 0, 0 )
	title.anchorX = 0
	title.anchorY = 0
	title.x = 0
	title.y = 0
	title.width = _SCREEN.WIDTH
	title.height = _SCREEN.WIDTH * 33/372

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

	--錯誤信息(文字)
	text1 = display.newText( "錯誤信息提示", 0, 0, native.systemFont , textFontSize )
	text1.x = _SCREEN.CENTER.X
	text1.y = _SCREEN.HEIGHT * 0.15
	text1:setFillColor( 1, 0, 0 )

	--忘記密碼(文字)
	text2 = display.newText( "忘記密碼？", 0, 0, native.systemFont , textFontSize )
	text2.x = _SCREEN.CENTER.X
	text2.y = _SCREEN.HEIGHT * 0.42
	text2:setFillColor( 0, 0, 0 )

	--或者你可以(文字)
	text3 = display.newText( "或者你可以", 0, 0, native.systemFont , textFontSize )
	text3.x = _SCREEN.CENTER.X
	text3.y = text3_y
	text3:setFillColor( 0, 0, 0 )

	text4 = display.newText( "記得我", 0, 0, native.systemFont , textFontSize )
	text4.x = _SCREEN.WIDTH * 0.5
	text4.y = _SCREEN.CENTER.Y
	text4:setFillColor( 0, 0, 0 )

	--分隔線
	line1 = display.newLine( _SCREEN.WIDTH * 0.05,text3_y, _SCREEN.WIDTH * 0.32,text3_y )
	line1.strokeWidth = 3
	line1:setStrokeColor( 0, 0, 0 )

	line2 = display.newLine( _SCREEN.WIDTH * 0.68,text3_y, _SCREEN.WIDTH * 0.95,text3_y )
	line2.strokeWidth = 3
	line2:setStrokeColor( 0, 0, 0 )

	--加入Group
	topGroup:insert( title )
	topGroup:insert( backButton )

	userLoginGroup:insert( bg )
	userLoginGroup:insert( loginButton )
	userLoginGroup:insert( registeredButton )
	userLoginGroup:insert( topGroup )
	userLoginGroup:insert( rect1 )
	userLoginGroup:insert( rect2 )
	userLoginGroup:insert( text1 )
	userLoginGroup:insert( text2 )
	userLoginGroup:insert( text3 )
	userLoginGroup:insert( text4 )
	userLoginGroup:insert( line1 )
	userLoginGroup:insert( line2 )
	userLoginGroup:insert( switch )
	userLoginGroup:insert( textFieldGroup )

	topGroup.y = _SCREEN.HEIGHT * 0.03


	-- timer.performWithDelay( 1000, function (  )
	-- 	-- print( textField1.text )
	-- 	-- print( textField2.text )
	-- 	-- print( switch.isOn )
	-- 	-- if textField1.text == "" then
	-- 	-- 	print( "no text" )
	-- 	-- end
	-- end , -1 )
	-- print( string.gsub( textField1.text, " ",  "", "%s*" ) )
	-- print( string.gsub( "Hello banana", "banana", "Corona user" ) ) 
end

loginButtonOnRelease = function (  )
	print( "login" )
	
	if switch.isOn == true then
		--存取帳號
		local accountFile = system.pathForFile( "account.txt" , system.DocumentsDirectory )
		local accountFileHandle , errorString = io.open( accountFile , "w+" )
		if (accountFileHandle) then
			accountFileHandle:write( textField1.text )
			io.close( accountFileHandle )
		else
			print( errorString )
		end
	end

	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "main_interface" , options )
end

registeredButtonOnRelease = function (  )
	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "userRegistration" , options )
end

backButtonOnRelease = function (  )
	local options = { effect = "slideRight", time = 500 }
	composer.gotoScene( "loginType" , options )
end

makeTextField = function (  )
	--輸入文字匡
	textField1 = native.newTextField( _SCREEN.CENTER.X, textField1_y, textFieldWidth, textFieldHeight )
	textField1.hasBackground = false
	textField1.size = 80
	textField1.placeholder = "帳號"

	textField2 = native.newTextField( _SCREEN.CENTER.X, textField2_y, textFieldWidth, textFieldHeight )
	textField2.hasBackground = false
	textField2.size = 80
	textField2.isSecure = true
	textField2.placeholder = "密碼"

	textFieldGroup:insert( textField1 )
	textFieldGroup:insert( textField2 )

	print( "make text field" )
end

removeTextField = function (  )
	textField1:removeSelf( )
	textField2:removeSelf( )

	print( "remove text field" )
end

checkTextField = function (  )
	tmr = timer.performWithDelay( 100, function (  )
		removeSpace()
		if textField1.text == "" then
			if textField2.text == "" then
				loginButton.alpha = 0.5
				loginButton:setEnabled( false )
			else
				loginButton.alpha = 0.5
				loginButton:setEnabled( false )
			end
		else
			if textField2.text == "" then
				loginButton.alpha = 0.5
				loginButton:setEnabled( false )
			else
				loginButton.alpha = 1
				loginButton:setEnabled( true )
			end
		end
	end, -1 )
end

removeSpace = function (  )
	local str1 = string.gsub( textField1.text, "%s+",  "" )
	textField1.text = str1
	local str2 = string.gsub( textField2.text, "%s+",  "" )
	textField2.text = str2
	local str3 = string.gsub( textField1.text, "%p+",  "" )
	textField1.text = str3
	local str4 = string.gsub( textField2.text, "%p+",  "" )
	textField2.text = str4
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