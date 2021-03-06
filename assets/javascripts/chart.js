function plot_chart(data){
    var plot1 = jQuery.jqplot ('jchart', data, {
      series:[
           /* {label: 'Labor Hours', markerOptions: { style:'filledSquare' }}, */
            {label:'Ideal', markerOptions: { style:'x' }},
            {label:'Actual'}
      ],
      legend: {
            show: true
      },
      axes: {
        // options for each axis are specified in seperate option objects.
        xaxis: {
          label: "Dates",
          renderer: jQuery.jqplot.DateAxisRenderer,
          tickOptions: {
            fontSize: '8pt'
          }
        },
        yaxis: {
          label: "Hours/Story Points",
          labelRenderer: jQuery.jqplot.CanvasAxisLabelRenderer
        }
      },
      highlighter: {
        show: true,
        sizeAdjust: 7.5
      }, 
      cursor:{ 
        show: true,
        zoom: true
      } 
    });
    jQuery('.button-reset').click(function() { plot1.resetZoom() });

}
