$.fn.toscamark=function(e){this.wookmarkOptions?e&&(this.wookmarkOptions=$.extend(this.wookmarkOptions,e)):this.wookmarkOptions=$.extend({container:$("body"),offset:40,offset_y:30,autoResize:!1,itemWidth:$(this[0]).outerWidth(!1),resizeDelay:50},e),this.containerWidth||(this.containerWidth=null),this.wookmarkLayout=function(){var e=this.wookmarkOptions.itemWidth+this.wookmarkOptions.offset,t=this.wookmarkOptions.container.width(),n=Math.floor((t+this.wookmarkOptions.offset)/e),r=this.wookmarkOptions.offset,i=this.wookmarkOptions.offset_y,s=0;s=this.wookmarkLayoutFull(e,n,r,i),window.resizing=!1,this.wookmarkOptions.container.css("height",s+"px")},this.wookmarkLayoutFull=function(e,t,n,r){var i=[];if(window.heights==null||window.resizing){window.heights=[];while(window.heights.length<t)window.heights.push(0)}var s,o,u,a=0,f=0,l=this.length,c=null,h=null,p=0;for(;a<l;a++){s=$(this[a]),c=null,h=0;for(f=0;f<t;f++)if(c==null||window.heights[f]<c)c=window.heights[f],h=f,c<400&&(c=0);var d=t*(500+n),v=(this.wookmarkOptions.containerWidth-d)/2+n/t;s.removeClass("shown").css({top:c+r+"px",left:h*e+v+"px"}),window.heights[h]=c+s.outerHeight(!0)+this.wookmarkOptions.offset_y,p=Math.max(p,window.heights[h])}return p},this.wookmarkLayout();var t=0;for(t=0;t<this.length;t++){var n=$("img",$(this[t])),r=$(".comment p",$(this[t]));n.delay(Math.floor(Math.random()*2e3)).slideDown(100,"easeOutElastic",function(){$(this).css("opacity",1),$("p",$(this).next()).delay(1e3).animate({top:"0px",height:"100px"},100)})}};