jQuery.event.special.dblclick = {
    setup: function(data, namespaces) {
        var elem = this,
            $elem = jQuery(elem);
        $elem.bind('touchend.dblclick', jQuery.event.special.dblclick.handler);
    },

    teardown: function(namespaces) {
        var elem = this,
            $elem = jQuery(elem);
        $elem.unbind('touchend.dblclick');
    },

    handler: function(event) {
        var elem = event.target,
            $elem = jQuery(elem),
            lastTouch = $elem.data('lastTouch') || 0,
            now = new Date().getTime();

        var delta = now - lastTouch;
        if(delta > 20 && delta<250){
            $elem.data('lastTouch', 0);
            $elem.trigger('dblclick');
        }else
            $elem.data('lastTouch', now);
    }
};

$(function(){
    document.ondblclick = function(evt) {
    if (window.getSelection)
        window.getSelection().removeAllRanges();
    else if (document.selection)
        document.selection.empty();
    }
});
