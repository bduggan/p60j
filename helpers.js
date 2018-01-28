window.add_svg = function(element) {
 element.append(
   "<div style='margin: 0 auto'>"
   + "<svg id='out2' viewBox='-1 -1 2 2'></svg>"
   + "</div>"
    + "<table style='width:100%;'>"
    + "<tr><th style='width:50%;text-align:right;border:none;'>ratio:&nbsp;</td><td style='width:50%;border:none;' id='ratio'></td></tr>"
    + "<tr><th style='text-align:right;border:none;'>accuracy:&nbsp;</td><td style='border:none;' id='accuracy'></td></tr>"
    + "</table>"
   );
   return d3.select('#out2').attr('height',200);
}
window.add_square = function(svg, square) {
 svg.append('rect')
     .attr('x',square.corner[0])
     .attr('y',square.corner[1])
     .attr('height',square.height)
     .attr('width',square.height)
     .attr('transform',
       'rotate(' + square.rotation + ',' + square.corner[0] + ',' + square.corner[1] + ')')
     .style('fill','white').style('stroke','black').style('stroke-width',2)
     .style('vector-effect','non-scaling-stroke')
     ;
}
window.zoom_out = function(svg,square) {
  var h = square.height;
  var vb = -h*2 + "," + -h*2 + "," + (4*h) + "," + (4*h);
  svg.transition().duration(750).attr('viewBox',vb);
}
window.display_ratio = function(square) {
 d3.select('#ratio').html(
      '<sup>' + square.fraction[0] + '</sup>&frasl;'
       + '<sub>' + square.fraction[1] + '</sub>' + 
      ' == ' + square.ratio);
 d3.select('#accuracy').html(square.accuracy);
}
