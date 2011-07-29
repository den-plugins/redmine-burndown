function DragCorner(container, handle) {
   
     var container = $(container);
     var handle = $(handle);
     
     container.moveposition = { x: 0, y: 0 };
     
     function moveListener(event) {
        
        var moved = {
           x: (event.pointerX() - container.moveposition.x),
           y: (event.pointerY() - container.moveposition.y)
        };
        
        container.moveposition = { x: event.pointerX(), y: event.pointerY() };
        
        function extractNumber(text) {
           return +text.split(' ')[0].replace(/[^0-9]/g,'');
        }
        
        var borderTop = extractNumber(container.getStyle('border-top-width'));
        var borderBottom = extractNumber(container.getStyle('border-bottom-width'));
        var borderLeft = extractNumber(container.getStyle('border-left-width'));
        var borderRight = extractNumber(container.getStyle('border-right-width'));
        
        var paddingTop = extractNumber(container.getStyle('padding-top'));
        var paddingBottom = extractNumber(container.getStyle('padding-bottom'));
        var paddingLeft = extractNumber(container.getStyle('padding-left'));
        var paddingRight = extractNumber(container.getStyle('padding-right'));
        
        var heightAdjust = borderTop + borderBottom + paddingTop + paddingBottom;
        var widthAdjust = borderLeft + borderRight + paddingLeft + paddingRight;
        
        var size = container.getDimensions();
        
        container.setStyle({
           height: size.height + moved.y - heightAdjust + 'px',
           width: size.width + moved.x - widthAdjust + 'px'
        });
     }
     
     handle.observe('mousedown', function(event) {
        container.moveposition = {x:event.pointerX(),y:event.pointerY()};
        Event.observe(document.body,'mousemove',moveListener);
     });
     
     Event.observe(document.body,'mouseup', function(event) {
        Event.stopObserving(document.body,'mousemove',moveListener);
     });
  }

  
     DragCorner('resizable_cont', 'DragHandle');
