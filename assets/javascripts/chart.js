function plot_chart(data){
jQuery(document).ready(function(){
    
    var plot1 = jQuery.jqplot ('jchart', data, {
      // Give the plot a title.
      //title: 'Plot With Options',
      // You can specify options for all axes on the plot at once with
      // the axesDefaults object.  Here, we're using a canvas renderer
      // to draw the axis label which allows rotated text.
      // An axes object holds options for all axes.
      // Allowable axes are xaxis, x2axis, yaxis, y2axis, y3axis, ...
      // Up to 9 y axes are supported.
      axes: {
        // options for each axis are specified in seperate option objects.
        xaxis: {
          label: "Dates",
          renderer: jQuery.jqplot.DateAxisRenderer,
          // Turn off "padding".  This will allow data point to lie on the
          // edges of the grid.  Default padding is 1.2 and will keep all
          // points inside the bounds of the grid.
          //min: "<%= @chart.dates.first %> 00:00"
        },
        yaxis: {
          label: "Hours"
        }
      },
      highlighter: {
        show: true,
        sizeAdjust: 7.5
      }, 
      cursor:{ 
        show: true,
        zoom: true 
        //followMouse: true
      } 
    });
    jQuery('.button-reset').click(function() { plot1.resetZoom() });
});
}
