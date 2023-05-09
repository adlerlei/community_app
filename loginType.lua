-----------------------------------------------------------------------------------------
--practice
--loginType.lua
--Tony Chen
--2016/10/18
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local widget = require( "widget" )
local composer = require("composer")
local scene = composer.newScene( )
local facebook = require( "plugin.facebook.v4" )
-- local facebook = require( "facebook" )
local json = require( "json" )
--=======================================================================================
--宣告全域變數
--=======================================================================================

--=======================================================================================
--宣告區域變數
--=======================================================================================
local bg
local title
local logo
local guestLoginButton
local userLoginButton
local fbLoginButten
local text1
local middleText
local text2
local btn_width =  _SCREEN.WIDTH * 0.7
local btn_height = _SCREEN.WIDTH * 0.7 * (60/279)
local textFont = native.systemFont
local textFontSize = 50
local text_y = _SCREEN.HEIGHT * 0.83
local r = 47
local g = 79
local b = 79

local FBAppID = " 352111358460100 "

--function
local initial
local guestLoginButtonOnRelease
local userLoginButtonOnRelease
local fbLoginButtenOnRelease
local facebookListener
--=======================================================================================
--定義各種函式
--=======================================================================================
initial = function ( loginTypeGroup )
	--背景
	bg = display.newRect( 0, 0, 0, 0 )
	bg.x = _SCREEN.CENTER.X
	bg.y = _SCREEN.CENTER.Y
	bg.width = _SCREEN.WIDTH
	bg.height = _SCREEN.HEIGHT
	bg:setFillColor( 1, 1, 1 )

	--訪客體驗按鈕
	guestLoginButton = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.5,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/VisitorExperience.png",
			overFile = "Images/VisitorExperience2.png",
			onRelease = guestLoginButtonOnRelease
		}
	)

	--用戶登入按鈕
	userLoginButton = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.62,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/UserLogin.png",
			overFile = "Images/UserLogin2.png",
			onRelease = userLoginButtonOnRelease
		}
	)

	--FaceBook登入按鈕
	fbLoginButten = widget.newButton(
		{
			x = _SCREEN.CENTER.X,
			y = _SCREEN.HEIGHT * 0.74,
			width = btn_width,
			height = btn_height,
			defaultFile = "Images/FBLogin.png",
			overFile = "Images/FBLogin2.png",
			onRelease = fbLoginButtenOnRelease
		}
	)

	title = display.newImageRect( "Images/Title.png", 0, 0 )
	title.anchorX = 0
	title.anchorY = 0
	title.x = 0
	title.y = _SCREEN.HEIGHT * 0.03
	title.width = _SCREEN.WIDTH
	title.height = _SCREEN.WIDTH * 33/372

	logo = display.newImageRect( "Images/logo.png", 0, 0 )
	logo.x = _SCREEN.CENTER.X
	logo.y = _SCREEN.HEIGHT * 0.25
	logo.width = _SCREEN.WIDTH * 0.5
	logo.height = _SCREEN.WIDTH * 0.5

	--服務條款(文字)
	text1 = display.newText( "服務條款", 0, 0, textFont , textFontSize )
	text1.x = _SCREEN.CENTER.X * 0.7
	text1.y = text_y
	text1:setFillColor( r/255, g/255, b/255 )

	--注意事項(文字)
	text2 = display.newText( "注意事項", 0, 0, textFont , textFontSize )
	text2.x = _SCREEN.CENTER.X * 1.3
	text2.y = text_y
	text2:setFillColor( r/255, g/255, b/255 )

	--中間分隔線
	middleText = display.newText( "|", 0, 0, textFont , textFontSize )
	middleText.x = _SCREEN.CENTER.X
	middleText.y = text_y
	middleText:setFillColor( r/255, g/255, b/255 )

	--加入Group
	loginTypeGroup:insert( bg )
	loginTypeGroup:insert( logo )
	loginTypeGroup:insert( title )
	loginTypeGroup:insert( guestLoginButton )
	loginTypeGroup:insert( userLoginButton )
	loginTypeGroup:insert( fbLoginButten )
	loginTypeGroup:insert( text1 )
	loginTypeGroup:insert( middleText )
	loginTypeGroup:insert( text2 )
end

guestLoginButtonOnRelease = function (  )
	print( "guest login" )
	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "experience" , options )
end

userLoginButtonOnRelease = function (  )
	local options = { effect = "slideLeft", time = 500 }
	composer.gotoScene( "userLogin" , options )
end

fbLoginButtenOnRelease = function (  )
	print( "facebook login" )
	-- facebook.login( FBAppID, facebookListener , { "email" , "name" } )
end

facebookListener = function ( e )
	if ( "session" == e.type ) then
		if ( "login" == e.phase ) then
			-- local access_token = event.token
		end
	elseif ( "request" == e.type ) then
		if not e.isError then
			-- local response = json.decode( event.response )
		end
	elseif ( "dialog" == e.type ) then
		-- print( "dialog", event.response )
	end
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
	elseif ( "did" == phase ) then
		--把畫面已經被推上螢幕後要執行的程式碼寫在這邊
		--可能是移除之前的場景，播放音效，開始計時，播放各種動畫

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