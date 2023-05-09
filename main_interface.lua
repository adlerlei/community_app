-----------------------------------------------------------------------------------------
--主介面
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
local adGroup = display.newGroup( )
local adImgData = {
    {defaultFile = "images/1.png" }  ,
    {defaultFile = "images/2.png" }  ,
    {defaultFile = "images/3.png" }  ,
    {defaultFile = "images/4.png" }  ,
    -- {defaultFile = "images/1.png" }  ,
    }

local img = {}
local tabBtn = {}
--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local ad
local adDisplacement = 0  --廣告輪播位移量
local count = 0
local imgNum = 1 --目前顯示圖片編號
local announcement
local prefecture
local official_website
local goblin
local team 
local marquee_bg
local marquee
local slideView
local adTimerStart


--=======================================================================================
--定義各種函式
--=======================================================================================


init = function ( _parent  )
    --背景
    background = display.newImageRect( _parent , "images/bg.png", _SCREEN.W , _SCREEN.H )
    background.x , background.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    --廣告區域
    ad = display.newImageRect( _parent , "images/ad.jpg", 620*WIDTH_RATIO , 400*HEIGHT_RATIO )
    ad.x , ad.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.5
    --社區公告
    announcement = display.newImageRect( _parent , "images/announcement.jpg", 620*WIDTH_RATIO , 100*HEIGHT_RATIO )
    announcement.x , announcement.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.95
    --用戶專區
    prefecture = display.newImageRect( _parent , "images/prefecture.jpg", 620*WIDTH_RATIO , 100*HEIGHT_RATIO )
    prefecture.x , prefecture.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.12
    --官方網站
    official_website = display.newImageRect( _parent , "images/official_website.jpg", 620*WIDTH_RATIO , 100*HEIGHT_RATIO )
    official_website.x , official_website.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.29
    --哥布林程式教育學苑
    goblin = display.newImageRect( _parent , "images/goblin.jpg", 620*WIDTH_RATIO , 100*HEIGHT_RATIO )
    goblin.x , goblin.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.46
    --製作團隊
    team = display.newImageRect( _parent , "images/team.jpg", 620*WIDTH_RATIO , 100*HEIGHT_RATIO )
    team.x , team.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.63

    back = display.newText( _parent , "社區好幫手", _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.1 , font , BACK_SIZE )
    back:setFillColor( 0 )

    --個按鈕加入偵聽
    announcement:addEventListener( "tap", function (  )
        composer.gotoScene( "announcement" )
    end )

    prefecture:addEventListener( "tap", function (  )
        composer.gotoScene( "prefecture" )
    end )

    official_website:addEventListener( "tap", function (  )
        composer.gotoScene( "official_website" )
    end )

    goblin:addEventListener( "tap", function (  )
        composer.gotoScene( "goblin" )
    end )

    team:addEventListener( "tap", function (  )
        composer.gotoScene( "team" )
    end )

    --跑馬燈
    marquee_bg = display.newRect( _parent , _SCREEN.CENTER.X , _SCREEN.CENTER.Y *2, _SCREEN.W , 100*HEIGHT_RATIO )
    marquee_bg.anchorY = 1
    marquee_bg:setFillColor( 0.9 , 0.1 , 0.1 )

    marquee = display.newText( _parent , "官方跑馬燈公告  官方跑馬燈公告", _SCREEN.CENTER.X *2, _SCREEN.CENTER.Y*1.92 , font , FONTSIZE )
    marquee.anchorX = 0

    local position = #marquee.text
    transition.to( marquee , {time = position * 220 , x = position * -22 , iterations = -1 } )
end

--廣告幻燈片產生的動作
adBottonListener = function ( e )
    local phase = e.phase
    local obj = e.target
    if (phase == "began") then 
        obj.OldX = adGroup.x
   
    elseif (phase == "moved") then 
        dx = e.x - e.xStart
        adGroup.x = obj.OldX + dx
        timer.cancel( adTimer )
    
    elseif  ( phase == "ended" ) then
        adTimerStart()
        if (dx ) and ( dx > 0 ) then 
            adDisplacement = adDisplacement + 500
            transition.to( adGroup , {time = 800 , x = adDisplacement} )
            count = count - 1 
            imgNum = imgNum - 1 

            if count == -1 then
                table.insert( img , 1 , img[#img] ) 
                img[#img].x = img[2].x - 500
                table.remove( img , #img )
                count = 0
            end  

            if ( imgNum == 0 ) then
                imgNum = #adImgData
            end

            for i = 1 , #adImgData do 
                tabBtn[i].alpha = 0.5 
                tabBtn[imgNum].alpha = 1
            end
        else 
            adDisplacement = adDisplacement - 500
            transition.to( adGroup , {time = 800 , x = adDisplacement} )
             -- print( "ad:" , adGroup.x )
             count = count + 1 
             imgNum = imgNum + 1 
            if count == 3 then
                img[#img+1] = img[1] 
                img[1].x = img[#img-1].x + 500
                table.remove( img , 1 )
                count = 2
            end             

            if ( imgNum == #adImgData + 1 ) then
                imgNum = 1
            end

            for i = 1 , #adImgData do 
                tabBtn[i].alpha = 0.5 
                tabBtn[imgNum].alpha = 1
            end
        end 
    end
end

--幻燈片
slideView = function ( group )
    
    for i = 1 , #adImgData do 
        img[i] = widget.newButton( {
            defaultFile = adImgData[i].defaultFile , 
            width = 500 , 
            height = 400 ,
            top = 140 , 
            left = 100 + i *500 - 500 ,
            onEvent = adBottonListener ,
            } )

        adGroup:insert( img[i] )
        group:insert( adGroup )
    end
end

--指示器
makeTabButtons = function ( sceneGroup )
    for i = 1 , #adImgData do 
        tabBtn[i] = display.newCircle( sceneGroup , 120 + i *100, 500, 30 )
        tabBtn[i].alpha = 0.5
        tabBtn[1].alpha = 1
    end
end

--跑馬燈計時開始
adTimerStart = function (  )
   adTimer = timer.performWithDelay( 2000 , function (  )
    adDisplacement = adDisplacement - 500
       transition.to( adGroup , {time = 800 , x = adDisplacement} )
             -- print( "ad:" , adGroup.x )
             count = count + 1 
             imgNum = imgNum + 1 
            if count == 3 then
                img[#img+1] = img[1] 
                img[1].x = img[#img-1].x + 500
                table.remove( img , 1 )
                count = 2
            end             

            if ( imgNum == #adImgData + 1 ) then
                imgNum = 1
            end

            for i = 1 , #adImgData do 
                tabBtn[i].alpha = 0.5 
                tabBtn[imgNum].alpha = 1
            end
   end , -1 )
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
   slideView(sceneGroup)
   makeTabButtons(sceneGroup)
   adTimerStart()
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