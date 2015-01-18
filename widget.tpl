<!DOCTYPE html>
<html lang={_LANG}>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <script src="http://d3js.org/d3.v3.min.js"></script>

    <script src="d3.hemicycle2.js"></script>
    <script src="d3.tip.js"></script>
    <script src="d3.legend.js"></script>
    <script src="d3.orloj.js"></script>

    <style>
    text.shadow {
        stroke: gray;
        stroke-width: 1px;
        opacity: 0.9;
    }
    /* D3 tips */  
    .d3-tip {
      line-height: 1;
      font-weight: bold;
      padding: 12px;
      background: rgba(0, 0, 0, 0.8);
      color: #fff;
      border-radius: 2px;
    }
    .d3-tip.n:after {
      margin: -1px 0 0 0;
      top: 100%;
      left: 0;
    }
    .stronger {
      color: yellow;
    }
    </style>
  </head>
  <body>   
    <div id="chart"></div>

<script type="text/javascript">
  data = {_DATA};
  dat = {_DAT};
        
        //width and height
        var w = {_WIDTH},
            rowsOrloj = {_ROWS_ORLOJ},
            iconHeightOrloj = w/22, // w/22 for 2 rowsOrloj
            h = w*(1/2+1/8+rowsOrloj*1/16);

        //append svg
        var svg=d3.select("#chart")
            .append("svg")
            .attr("width",w)
            .attr("height",h)
            .attr("id","chart-svg");
        
        var hemicycleData = [{'widthIcon': dat.w, 'gap': dat.g, 'n': dat.n}];
        hemicycleData[0]['width'] = w;
        hemicycleData[0]['people'] = data;
        

       // Initialize tooltip
        tip = d3.tip().attr("class", "d3-tip").html(function(d) {
            return "<span class=\'stronger\'>" + d["name"] + "</span><br>" + d["party"] + "<br>";
        });
        
        // function for chart
        var myChart = d3.hemicycle()
                .n(function(d) {return d.n;})
                .gap(function(d) {return d.gap;})
                .widthIcon(function(d) {return d.widthIcon;})
                .width(function(d) {return d.width;})
                .people(function(d) {return d.people;})
                .arcs({_ARCS})
                ;
       
       //create hemicycle         
       var hc = svg.selectAll(".hc")
            .data(hemicycleData)
           .enter()
            .append("svg:g")
            .attr("width",w)
            .attr("height",w/2)
              .call(myChart);

	    // Invoke the tip in the context of your visualization
        svg.call(tip);
        
	    // Add tooltip div
        var div = d3.select("body").append("div")
        .attr("class", "tooltip")
        .style("opacity", 1e-6);   
        
        //legend data
        var legendData = [{_LEGEND}];   
        
        var myLegend = d3.legend()
                .label(function(d) {return d.label;})
                .width(w)
                .icons(function(d) {return d.icons;});
       
        svg.selectAll(".legend")
              .data(legendData)
           .enter()
            .append("svg:g")
            .attr("width",w)
            .attr("height",w/8)
            .attr("transform", "translate(0," + w/2 + ")")
            .call(myLegend);
            
         var orlojData = [{
                //'label' : ['Legenda:'],
                'rows': rowsOrloj,
                'iconHeight': iconHeightOrloj,
                'icons' : {_ORLOJ_PARTIES}
            }];
        
        var myOrloj = d3.orloj()
                //.label(function(d) {return d.label;})
                .rows(function(d) {return d.rows;})
                .iconHeight(function(d) {return d.iconHeight;})
                .icons(function(d) {return d.icons;})
                .width(w);  
        
        movey = w/2 + w/8;        
        svg.selectAll(".orloj")
              .data(orlojData)
           .enter()
            .append("svg:g")
            .attr("width",w)
            .attr("height",w/16*orlojData[0].rows)
            .attr("transform", "translate(0," + movey + ")")
            .call(myOrloj);     


</script>
  </body>
</html>