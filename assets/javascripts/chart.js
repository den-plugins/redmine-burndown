function plot_chart(data){
    
    var plot1 = jQuery.jqplot ('jchart', data, {
      series:[
            {label:'Sprint'},
            {label:'Ideal'}
      ],
      legend: {
            show: true
      },
      axes: {
        // options for each axis are specified in seperate option objects.
        xaxis: {
          label: "Dates",
          renderer: jQuery.jqplot.DateAxisRenderer,
          
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
      } 
    });
    jQuery('.button-reset').click(function() { plot1.resetZoom() });

}
