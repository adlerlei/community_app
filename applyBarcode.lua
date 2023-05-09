-----------------------------------------------------------------------------------------
--practice
--userBarcode.lua
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
local text1
local text2
local line1
local line2
local button1
local button2
local button3
local textField
local textField_bg
local tmr
local textFieldBg_r = 211
local textFieldBg_g = 211
local textFieldBg_b = 211
local line_y = _SCREEN.HEIGHT * 0.55
local btn_width =  _SCREEN.WIDTH * 0.7
local btn_height = _SCREEN.WIDTH * 0.7 * (60/279)
local textFieldWidth = _SCREEN.WIDTH * 0.75
local textFieldHeight = _SCREEN.HEIGHT * 0.08

--function
local initial
local makeTextField
local removeTextField
local button1_onRelease
local button2_onRelease
local button3_onRelease
local checkTextField
local removeSpace

--group
local textFieldGroup = display.newGroup( )
local topGroup = display.newGroup( )
--=======================================================================================
--定義各種函式
--=======================================================================================
initial = function ( ApplyBarcodeGroup )
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

	textField_bg = display.newRect( 0, 0, 0, 0 )
	textField_bg.x = _SCREEN.CENTER.X
	textField_bg.y = _SCREEN.HEIGHT * 0.33
	textField_bg.width = textFieldWidth
	textField_bg.height = textFieldHeight
	textField_bg:setFillColor( textFieldBg_r/255, textFieldBg_g/255, textFieldBg_b/255 )

	text1 = display.newText( "我沒有條碼", 0, 0, native.systemFont , 50 )
	text1.x = _SCREEN.CENTER.X
	text1.y = line_y
	text1:setFillColor( 0, 0, 0 )

	text2 = display.newText( "錯誤提示信息", 0, 0, native.systemFont , 50 )
	text2.x = _SCREEN.CENTER.X
	text2.y = _SCREEN.HEIGHT * 0.25
	text2:setFillColor( 1, 0, 0 )

	line1 = display.newLine( _SCREEN.WIDTH * 0.05,line_y, _SCREEN.WIDTH * 0.32,line_y )
	line1.strokeWidth = 2
	line1:setStrokeColor( 0, 0, 0 )

	line2 = display.newLine( _SCREEN.WIDTH * 0.68,line_y, _SCREEN.WIDTH * 0.95,line_y )
	line2.strokeWidth = 2
	line2:setStrokeColor( 0, 0, 0 )

	button1 = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.45,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Enter.png",
			overFile = "Images/Enter2.png",
			onRelease = button1_onRelease
		}
	)
	button1.alpha = 0.5
	button1:setEnabled( false )

	button2 = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.65,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/Experience.png",
			overFile = "Images/Experience2.png",
			onRelease = button2_onRelease
		}
	)

	button3 = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.76,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/ApplyBarcode.png",
			overFile = "Images/ApplyBarcode2.png",
			onRelease = button3_onRelease
		}
	)

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

	topGroup:insert( title )
	topGroup:insert( backButton )

	ApplyBarcodeGroup:insert( bg )
	ApplyBarcodeGroup:insert( topGroup )
	ApplyBarcodeGroup:insert( textField_bg )
	ApplyBarcodeGroup:insert( text1 )
	ApplyBarcodeGroup:insert( text2 )
	ApplyBarcodeGroup:insert( line1 )
	ApplyBarcodeGroup:insert( line2 )
	ApplyBarcodeGroup:insert( button1 )
	ApplyBarcodeGroup:insert( button2 )
	ApplyBarcodeGroup:insert( button3 )
	ApplyBarcodeGroup:insert( textFieldGroup )

	topGroup.y = _SCREEN.HEIGHT * 0.03
end

button1_onRelease = function (  )
	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "main_interface" , options )
end

button2_onRelease = function (  )
	
end

button3_onRelease = function (  )
	
end

backButtonOnRelease = function (  )
	local options = { effect = "slideRight", time = 500 }
	composer.gotoScene( "userRegistration" , options )
end

makeTextField = function (  )
	textField = native.newTextField( _SCREEN.CENTER.X, _SCREEN.HEIGHT * 0.33, textFieldWidth, textFieldHeight )
	textField.hasBackground = false
	textField.size = 80
	textField.placeholder = "輸入社區條碼"

	textFieldGroup:insert( textField )

	print( "make text field" )
end

removeTextField = function (  )
	textField:removeSelf( )

	print( "remove text field" )
end

removeSpace = function (  )
	local str1 = string.gsub( textField.text, "%s+",  "" )
	textField.text = str1
	local str2 = string.gsub( textField.text, "%p+",  "" )
	textField.text = str2
end

checkTextField = function (  )
	tmr = timer.performWithDelay( 100, function (  )
		removeSpace()
		if textField.text == "" then
			button1.alpha = 0.5
			button1:setEnabled( false )
		else
			button1.alpha = 1
			button1:setEnabled( true )
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
		timer.pause( tmr )
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