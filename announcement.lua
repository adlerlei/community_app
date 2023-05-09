-----------------------------------------------------------------------------------------
--社區公告
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
local back 
local hide
--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local onRowRender
local onRowTouch

iconData = { 
    {path =  "images/icon.jpg" , W = 0 , H = 0 } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    {path =  "images/icon.jpg" , W = 0 , H = 0 } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } ,
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO } , 
    { path = "images/icon.jpg" , W = 140*WIDTH_RATIO , H = 180*HEIGHT_RATIO} ,
}

titleData = {
    "2016年公告" ,
    "社區公告標題" ,
    "社區公告標題" ,
    "2017年公告" ,
    "社區公告標題" ,
    "社區公告標題" ,
    "社區公告標題" ,
    "社區公告標題" ,
    "社區公告標題" ,
    "社區公告標題" ,
}

contentData = {
    "" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
    "這裡是社區公告內容。這裡是社區公".."\n".."告內容。這裡是社區公告內容。這裡".."\n".."是社區公告內容。這裡是社區公告內容。" ,
}

--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( _parent  )
    background = display.newImageRect( _parent , "images/bg.png", _SCREEN.W , _SCREEN.H )
    background.x , background.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    background:setFillColor( 0.9 )

    back = display.newText( _parent , "返回", _SCREEN.CENTER.X *0.2, _SCREEN.CENTER.Y*0.1 , font , 40 )
    back:setFillColor( 0 )
    back:addEventListener( "tap", function (  )
        composer.gotoScene( "main_interface" )
    end )

    tableView = widget.newTableView( {
        x = _SCREEN.CENTER.X ,
        y = _SCREEN.CENTER.Y , 
        width = _SCREEN.W, 
        height = _SCREEN.H*0.85 , 
        isBouncedEnabled = true , 
        hideBackground = false , 
        onRowRender = onRowRender , 
        onRowTouch = onRowTouch ,   
      })   

    for i = 1 , 10 do
        local rowHeight = 280
        local rowColor = { default = {0,0,0,0} , over = { 0 , 0.7 , 0.8}}
        local isCategory = false
        local lineColor = { 0.8 , 0.8 , 0.8}

        if ( i == 1 or i == 4 ) then
            lineColor = {1 , 0 , 0}
            isCategory = true
            rowHeight = 100 
            rowColor = {default = { 1 , 1 ,0.2 ,1}} 
        end
        tableView:insertRow( {
        rowHeight = rowHeight , 
        rowColor = rowColor , 
        isCategory = isCategory , 
        lineColor = lineColor , 
      } )
    end
   _parent:insert( tableView )

   -- hide = display.newRect( _parent , _SCREEN.CENTER.X , 45 * HEIGHT , _SCREEN.W, 140 *HEIGHT )
   -- hide:setFillColor( 0.5 )
end



onRowRender = function ( e , scene)
    row = e.row
    if (row.isCategory) then 
        text = display.newText( row , titleData[row.index], _SCREEN.CENTER.X, 50 , font , FONTSIZE )
        text:setFillColor( 0.1 )
        -- icon = display.newImageRect( row , "images/icon.jpg", 50 , 50 )
    else
       icon = display.newImageRect( row , iconData[row.index].path, iconData[row.index].W , iconData[row.index].H )
       icon.x , icon.y = _SCREEN.CENTER.X*0.28 , 140*HEIGHT_RATIO

       title = display.newText( row , titleData[row.index], _SCREEN.CENTER.X*1.1 , _SCREEN.CENTER.Y*0.1 , font , 60 )
       title:setFillColor( 0 )

       content = display.newText( row, contentData[row.index], _SCREEN.CENTER.X*0.53, _SCREEN.CENTER.Y*0.28 , font , 40 )
       content:setFillColor( 0 , 0.4 , 0.8 )
       content.anchorX = 0
       content.anchoyY = 0
    end
end

onRowTouch = function (  )
    
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