-----------------------------------------------------------------------------------------
--製作團隊
-- 


-- date: 2016/10/31
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local scene = composer.newScene( )

--=======================================================================================
--宣告各種變數
--=======================================================================================
local background
local team
local teamGroup = display.newGroup( )
local maskGroup = display.newGroup( )
local position1
local position2
local position3
local position4
local mask

--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init

--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( _parent  )
    --背景
    background = display.newImageRect( _parent , "images/bg.png", _SCREEN.W , _SCREEN.H )
    background.x , background.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    background:setFillColor( 0 )
    --職位名稱
    position1 = display.newText(teamGroup , "職位 -  名稱" , _SCREEN.CENTER.X , _SCREEN.CENTER.Y , font , 60)
    position2 = display.newText(teamGroup , "職位 -  名稱" , _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2 , font , 60)
    position3 = display.newText(teamGroup , "職位 -  名稱" , _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.4 , font , 60)
    position4 = display.newText(teamGroup , "職位 -  名稱" , _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.6 , font , 60)
    --遮罩
    mask = display.newRect(  maskGroup , _SCREEN.CENTER.X , 50 , _SCREEN.W , 100 )
    mask:setFillColor( 0 )

    back = display.newText( _parent , "返回", _SCREEN.CENTER.X *0.2 , _SCREEN.CENTER.Y*0.2 , font , BACK_SIZE )
    back:setFillColor( 1 )

    back:addEventListener( "tap", function (  )
        composer.gotoScene( "main_interface" )
    end )

    teamGroup.y = 800
    transition.to( teamGroup , {time = 9000 , y = -1200 , onComplete = function (  )
        teamGroup.y = 800
    end , iterations = -1} )
end


--=======================================================================================
--Composer
--=======================================================================================

--畫面沒到螢幕上時，先呼叫scene:create
--任務:負責UI畫面繪製
function scene:create(event)
    print('scene:create')
    --把場景的view存在sceneGroup這個變數裡
    local sceneGroup = self.view

   --接下來把會出現在畫面的東西，加進sceneGroup裡面，這個非常重要
   init(sceneGroup)
   sceneGroup:insert( teamGroup )
   sceneGroup:insert( maskGroup )
end


--畫面到螢幕上時，呼叫scene:show
--任務:移除前一個場景，播放音效，開始計時，播放各種動畫
function  scene:show( event)
    local sceneGroup = self.view
    local phase = event.phase

    if( "will" == phase ) then
        print('scene:show will')
        --畫面即將要推上螢幕時要執行的程式碼寫在這邊
    elseif ( "did" == phase ) then
        print('scene:show did')
        --把畫面已經被推上螢幕後要執行的程式碼寫在這邊
        --可能是移除之前的場景，播放音效，開始計時，播放各種動畫

        --移除前一個畫面的元件
      
    end
end


--即將被移除，呼叫scene:hide
--任務:停止音樂，釋放音樂記憶體，停止移動的物體等
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( "will" == phase ) then
        print('scene:hide will')
        --畫面即將移開螢幕時，要執行的程式碼
        --這邊需要停止音樂，釋放音樂記憶體，有timer的計時器也可以在此停止
       
    elseif ( "did" == phase ) then
        print('scene:hide did')
        --畫面已經移開螢幕時，要執行的程式碼
    end
end

--下一個場景畫面推上螢幕後
--任務:摧毀場景
function scene:destroy( event )
    print('scene:destroy')
    if ("will" == event.phase) then
        --這邊寫下畫面要被消滅前要執行的程式碼

    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene